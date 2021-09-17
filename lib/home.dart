import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_layout_video_vlc/controller/video_player_controller.dart';
import 'package:flutter_layout_video_vlc/controls_bottom_video.dart';
import 'package:flutter_layout_video_vlc/controls_top_video.dart';
import 'package:flutter_layout_video_vlc/inicio.dart';
import 'package:flutter_statusbar_manager/flutter_statusbar_manager.dart';
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
    super.dispose();
    if (_timer != null) _timer.cancel();
    if (_controller.value.isPlaying) _controller.pause();
    _controller.removeListener(listener);
    _controller.dispose();
  }

  @override
  void initState() {
    super.initState();
    finish = false;
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    _controller = VlcPlayerController.network(
      'https://firebasestorage.googleapis.com/v0/b/pdal-2af91.appspot.com/o/video_class%2FyX2CzbYRahHUTyLWPoVH%2F01.mp4?alt=media&token=18d6c5b2-9d10-4a80-9b6c-1e6ee244309e',
      autoPlay: true,
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
    double escala = 0;

    if (Platform.isIOS) {
      if (height > _controller.value.size.height) {
        escala =
            (1 / (_controller.value.size.height / height)) + (height / width);
      } else if (height < _controller.value.size.height) {
        escala = (1 / (_controller.value.size.height / height)) +
            (_controller.value.size.width / _controller.value.size.height);
      } else {
        escala = 1;
      }
    }
    if (Platform.isAndroid) {
      escala = 2.5;
    }

    // await _controller.setVideoScale(escala);
    await _controller.setVideoScale(escala);
  }

  bool initRatio = true;
  double sliderValue = 0.0;
  double volumeValue = 50;
  String position = '';
  String duration = '';
  int numberOfCaptions = 0;
  int numberOfAudioTracks = 0;
  bool validPosition = false;
  bool finish = false;

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
      }

      setState(() {});

      Provider.of<VideoPlayerController>(context, listen: false).setPosition =
          position;
      Provider.of<VideoPlayerController>(context, listen: false).setDuration =
          duration;
    }
  }

  Future<void> setSpeed(double speed) async {
    await _controller.setPlaybackSpeed(speed);
  }

  // void backPage() {
  //   // _timer.cancel();
  //   // if (_controller.value.isPlaying) _controller.pause();
  //   // _controller.removeListener(listener);
  //   // _controller = null;
  //   _controller.dispose();
  //   _controller = null;
  //   Navigator.of(context).pop();
  // }

  Future<void> backPage() async {
    if (_controller == null) {
      // If there was no controller, just create a new one

    } else {
      // If there was a controller, we need to dispose of the old one first
      final oldController = _controller;

      // Registering a callback for the end of next frame
      // to dispose of an old controller
      // (which won't be used anymore after calling setState)
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        await _controller.dispose();
        if (_timer != null) _timer.cancel();
        // Initing new controller
      });
      setState(() {
        _controller = null; //   _controller = null;
      });

      Navigator.of(context).pop();
      // Making sure that controller is not used by setting it to null
      // setState(() {

      // });
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Consumer<VideoPlayerController>(
        builder: (context, videoPlayController, child) {
          if ((_controller.value.playingState == PlayingState.ended ||
              _controller.value.playingState == PlayingState.stopped) && _controller != null) {
            
              if (!finish) {
                finish = true;
              }
            
            Future.delayed(Duration(milliseconds: 250), () {
              // videoPlayController.setLoading = true;
              // _controller.stop();
              // videoPlayController.setPause = true;
              // videoPlayController.setShowControls = true;
              backPage();
            });
          }
          // if (videoPlayController.getReplay) {
          //   Future.delayed(Duration.zero, () {
          //     videoPlayController.resetData();
          //     _controller.play();
          //     videoPlayController.setPause = false;
          //     videoPlayController.setShowControls = false;
          //     videoPlayController.setShowBottomControls = false;
          //     videoPlayController.setReplay = false;
          //     videoPlayController.setLoading = false;
          //   });
          // }

          // if(videoPlayController.getDuration == videoPlayController.getPosition){
          //   _controller.stop();
          //   _controller.play();
          // }

          if (videoPlayController.getClickSpeedVideo && _controller != null) {
            Future.delayed(Duration(milliseconds: 1), () {
              _controller.setPlaybackSpeed(videoPlayController.getSpeedVideo);
              videoPlayController.setClickSpeedVideo = false;
            });
          }
          if (videoPlayController.getAdvance10sec && _controller != null) {
            print("avançando 10 segundos");
            _controller.seekTo(
                Duration(seconds: _controller.value.position.inSeconds + 10));
            Future.delayed(Duration(milliseconds: 1), () {
              videoPlayController.setAdvance10sec = false;
            });
          }
          if (videoPlayController.getBack10sec && _controller != null) {
            print("voltar 10 segundos");
            _controller.seekTo(
                Duration(seconds: _controller.value.position.inSeconds - 10));
            Future.delayed(Duration(milliseconds: 1), () {
              videoPlayController.setBack10sec = false;
            });
          }

          if (videoPlayController.getClickToTime &&
              videoPlayController.getFirstClick && _controller != null) {
            startTime();
            Future.delayed(Duration(milliseconds: 1), () {
              videoPlayController.setClickToTime = false;
            });
          }

          if (!videoPlayController.getBack10sec &&
              !videoPlayController.getAdvance10sec && 
              _start == 0 && _controller != null) {
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
          } else if ((videoPlayController.getBack10sec ||
              videoPlayController.getAdvance10sec) && _controller != null) {
            startTime();
          }

          if (videoPlayController.getFullScreen && Platform.isIOS && _controller != null) {
            SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
            SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
            ));
          } else if (!videoPlayController.getFullScreen && Platform.isIOS && _controller != null) {
            SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
          }

          if (videoPlayController.getFullScreen && Platform.isAndroid && _controller != null) {
            // SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top]);
            // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
            //   statusBarColor: Colors.transparent,
            // ));
            FlutterStatusbarManager.setColor(Colors.transparent,
                animated: true);
            FlutterStatusbarManager.setFullscreen(true);
          } else if (!videoPlayController.getFullScreen && Platform.isAndroid && _controller != null) {
            FlutterStatusbarManager.setColor(Colors.transparent,
                animated: true);
            FlutterStatusbarManager.setFullscreen(false);
          }

          if ((videoPlayController.getPause &&
                  videoPlayController.getFirstClick) ||
              (videoPlayController.getPause &&
                  videoPlayController.getShowBottomControls) && _controller != null) {
            _controller.pause();
          } else if ((videoPlayController.getFirstClick &&
                  !videoPlayController.getPause) ||
              (videoPlayController.getShowBottomControls &&
                  !videoPlayController.getPause) && _controller != null) {
            _controller.play();
          }

          if (videoPlayController.getShowVolume && _controller != null) {
            Future.delayed(Duration.zero, () {
              _controller.setVolume(videoPlayController.getVolumeSet.toInt());
            });
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
                  child: finish
                      ? Container()
                      : VlcPlayer(
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
                        height: height * 0.95,
                        child: ControlsTopVideo(),
                      ),
                      Container(
                        height: height * 0.05,
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
