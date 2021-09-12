import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_layout_video_vlc/controller/video_player_controller.dart';
import 'package:flutter_layout_video_vlc/controls_bottom_video.dart';
import 'package:flutter_layout_video_vlc/controls_top_video.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {

  double widthGlobal;
  double heightGlobal;

  Home({this.heightGlobal, this.widthGlobal});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  VlcPlayerController _controller;

  Timer _timer;
  int _start = 3;

  void startTime() {
    if (_timer != null) {
      _timer.cancel();
    }
    _start = 3;
    const oneSec = const Duration(seconds: 1);
    _timer = Timer.periodic(oneSec, (Timer timer) {
      if (_start == 0) {
        setState(() {
          timer.cancel();
          _start = 3;
        });
      } else {
        setState(() {
          _start--;
        });
      }
    });
  }

  @override
  void dispose() async {
    _timer.cancel();
    super.dispose();
    await _controller.stopRecording();
    await _controller.stopRendererScanning();
    await _controller.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controller = VlcPlayerController.network(
      'https://firebasestorage.googleapis.com/v0/b/pdal-v2.appspot.com/o/classes_videos%2FPzXOFGVRYF7jYKT2Dmqp%2F01.mp4?alt=media&token=8e278c70-d999-4400-8664-c1a1d1a45c50',
      hwAcc: HwAcc.AUTO,
      options: VlcPlayerOptions(
        advanced: VlcAdvancedOptions(
          [
            VlcAdvancedOptions.networkCaching(2000),
          ],
        ),
        http: VlcHttpOptions(
          [
            VlcHttpOptions.httpReconnect(true),
          ],
        ),
        rtp: VlcRtpOptions(
          [
            VlcRtpOptions.rtpOverRtsp(true),
          ],
        ),
      ),
    );
    _controller.addListener(listener);
  }

  Future<void> setRatio(double width, double height) async {
    await _controller.setVideoAspectRatio("$width:$height");
    await _controller.setVideoScale(3.2);
    // await _controller.setVideoScale(1.75);
  }

  bool initRatio = true;
  double sliderValue = 0.0;
  double volumeValue = 50;
  String position = '';
  String duration = '';
  int numberOfCaptions = 0;
  int numberOfAudioTracks = 0;
  bool validPosition = false;

  void listener() async {
    if (!mounted) return;

    if (_controller.value.isInitialized) {
      setRatio(widget.widthGlobal, widget.heightGlobal);
      var oPosition = _controller.value.position;
      var oDuration = _controller.value.duration;
      if (oPosition != null && oDuration != null) {
        if (oDuration.inHours == 0) {
          var strPosition = oPosition.toString().split('.')[0];
          var strDuration = oDuration.toString().split('.')[0];
          position =
              "${strPosition.split(':')[1]}:${strPosition.split(':')[2]}";
          duration =
              "${strDuration.split(':')[1]}:${strDuration.split(':')[2]}";
        } else {
          position = oPosition.toString().split('.')[0];
          duration = oDuration.toString().split('.')[0];
        }
        validPosition = oDuration.compareTo(oPosition) >= 0;
        sliderValue = validPosition ? oPosition.inSeconds.toDouble() : 0;
      }
      numberOfCaptions = _controller.value.spuTracksCount;
      numberOfAudioTracks = _controller.value.audioTracksCount;

      setState(() {});
    }
  }

  Future<void> setSpeed(double speed) async {
    await _controller.setPlaybackSpeed(speed);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    print("width :" + width.toString() + "  height : " + height.toString()  );

    return Scaffold(
      body: Consumer<VideoPlayerController>(
        builder: (context, videoPlayController, child) {
          if (videoPlayController.getAdvance10sec) {
            print("avançando 10 segundos");
            _controller.seekTo(
                Duration(seconds: _controller.value.position.inSeconds + 10));
            Future.delayed(Duration(milliseconds: 1), () {
              videoPlayController.setAdvance10sec = false;
            });
          }
          if (videoPlayController.getBack10sec) {
            print("voltar 10 segundos");
            _controller.seekTo(
                Duration(seconds: _controller.value.position.inSeconds - 10));
            Future.delayed(Duration(milliseconds: 1), () {
              videoPlayController.setBack10sec = false;
            });
          }

          if (videoPlayController.getClickToTime &&
              videoPlayController.getFirstClick) {
            startTime();
            Future.delayed(Duration(milliseconds: 1), () {
              videoPlayController.setClickToTime = false;
            });
          }

          if (!videoPlayController.getBack10sec &&
              !videoPlayController.getAdvance10sec &&
              _start == 0) {
            Future.delayed(Duration(milliseconds: 1), () {
              if (videoPlayController.getPause) {
                videoPlayController.setFirstClick = false;
                videoPlayController.setShowControls = false;
                videoPlayController.setClickToTime = false;
              } else {
                videoPlayController.setFirstClick = false;
                videoPlayController.setShowControls = false;
                videoPlayController.setShowBottomControls = false;
                videoPlayController.setClickToTime = false;
              }
            });
          } else if (videoPlayController.getBack10sec ||
              videoPlayController.getAdvance10sec) {
            startTime();
          }

          if (videoPlayController.getFullScreen && Platform.isIOS) {
            SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
            SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
            ));
          } else if (!videoPlayController.getFullScreen && Platform.isIOS) {
            SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
          }
        

          if (videoPlayController.getFullScreen && Platform.isAndroid) {
            SystemChrome.setEnabledSystemUIOverlays([]);
            SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
            ));
          } else if (!videoPlayController.getFullScreen && Platform.isAndroid) {
            SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
          }

          if ((videoPlayController.getPause &&
                  videoPlayController.getFirstClick) ||
              (videoPlayController.getPause &&
                  videoPlayController.getShowBottomControls)) {
            _controller.pause();
          } else if ((videoPlayController.getFirstClick &&
                  !videoPlayController.getPause) ||
              (videoPlayController.getShowBottomControls &&
                  !videoPlayController.getPause)) {
            _controller.play();
          }

          // if (videoPlayController.getShowBottomControls) {
          //   if (videoPlayController.getSpeedVideo == 0.5) {
          //     setSpeed(videoPlayController.getSpeedVideo);
          //   } else if (videoPlayController.getSpeedVideo == 1.0) {
          //     setSpeed(videoPlayController.getSpeedVideo);
          //   } else if (videoPlayController.getSpeedVideo == 1.5) {
          //     setSpeed(videoPlayController.getSpeedVideo);
          //   } else if (videoPlayController.getSpeedVideo == 2.0) {
          //     setSpeed(videoPlayController.getSpeedVideo);
          //   }
          // }
          return Container(
            child: Stack(
              children: [
                Container(
                  alignment: Alignment.topCenter,
                  height: height,
                  color: Colors.amber,
                  child: VlcPlayer(
                    controller: _controller,
                    aspectRatio: width / height,
                    placeholder: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                ),
                Container(
                  child: Column(
                    children: [
                      Container(
                        height: height * 0.9,
                        child: ControlsTopVideo(),
                      ),
                      Container(
                        height: height * 0.1,
                        child: ControlsBottomVideo(),
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
