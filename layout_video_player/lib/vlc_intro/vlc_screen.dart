import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:layout_video_player/routes/routes.dart';
import 'package:layout_video_player/vlc_intro/controller/video_player_controller.dart';
import 'package:layout_video_player/vlc_intro/widgets/controls_bottom_widget.dart';
import 'package:layout_video_player/vlc_intro/widgets/contros_top_widget.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

import 'arguments/arguments_vlc_video_intro.dart';

class VLCScreen extends StatefulWidget {
  ArgumentsVlcVideoIntro argumentsVlcVideoIntro;

  VLCScreen(
    this.argumentsVlcVideoIntro,
  );

  @override
  _VLCScreenState createState() => _VLCScreenState(
        argumentsVlcVideoIntro: this.argumentsVlcVideoIntro,
      );
}

class _VLCScreenState extends State<VLCScreen> {
  ArgumentsVlcVideoIntro argumentsVlcVideoIntro;

  String position = '';
  String duration = '';
  double sliderValue = 0.0;
  bool validPosition = false;

  _VLCScreenState({
    this.argumentsVlcVideoIntro,
  });

  VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.transparent),
    );
    if (argumentsVlcVideoIntro.inApp) {
      _controller =
          VideoPlayerController.asset("${argumentsVlcVideoIntro.url}");
    } else {
      _controller =
          VideoPlayerController.network("${argumentsVlcVideoIntro.url}");
    }

    _controller.addListener(listener);
    // _controller.addListener(() {
    //   setState(() {});
    // });
    _controller.setLooping(true);
    _controller.initialize().then((_) => setState(() {}));
    _controller.play();
  }

  @override
  void dispose() async {
    super.dispose();
    // if (_timer != null) _timer.cancel();
    if (_controller.value.isPlaying) _controller.pause();
    _controller.removeListener(listener);
    _controller.dispose();
    SystemChrome.setEnabledSystemUIOverlays(
        [SystemUiOverlay.top, SystemUiOverlay.bottom]);
  }

  void listener() async {
    if (!mounted) return;

    if (_controller.value.isInitialized) {
      // setRatio(argumentsVlcVideoIntro.widthGlobal,
      //     argumentsVlcVideoIntro.heightGlobal);
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
      Provider.of<VideoPlayerControlle>(context, listen: false).position =
          position;
      Provider.of<VideoPlayerControlle>(context, listen: false).duration =
          duration;

      setState(() {});
    }
  }

  // Future<void> setRatio(double width, double height) async {
  //   await _controller.setVideoAspectRatio("$width:$height");
  //   // double escala = 0;

  //   // if (Platform.isIOS &&
  //   //     (_controller.value.size.height > _controller.value.size.width)) {
  //   //   if (height > _controller.value.size.height) {
  //   //     escala =
  //   //         (1 / (_controller.value.size.height / height)) + (height / width);
  //   //   } else if (height < _controller.value.size.height &&
  //   //       (_controller.value.size.height > _controller.value.size.width)) {
  //   //     escala = (1 / (_controller.value.size.height / height)) +
  //   //         (_controller.value.size.width / _controller.value.size.height);
  //   //   } else if (height == _controller.value.size.height &&
  //   //       (_controller.value.size.height > _controller.value.size.width)) {
  //   //     escala = 1;
  //   //   }
  //   // }
  //   // if (Platform.isAndroid &&
  //   //     (_controller.value.size.height < _controller.value.size.width)) {
  //   //   // escala = 0.9 +
  //   //   //     ((height / _controller.value.size.width) /
  //   //   //         (width / _controller.value.size.height));
  //   //   escala = (1 / ((width - _controller.value.size.width)/(height - _controller.value.size.height))).abs();
  //   // }

  //   // print("width phone result: " + escala.toString());
  //   // // await _controller.setVideoScale(escala);
  //   await _controller.setVideoScale(1);
  // }

  void _onSliderPositionChanged(double progress) {
    setState(() {
      sliderValue = progress.floor().toDouble();
    });
    //convert to Milliseconds since VLC requires MS to set time
    _controller.seekTo(Duration(milliseconds: sliderValue.toInt() * 1000));
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    // if (_controller.value. == PlayingState.ended) {
    //   WidgetsBinding.instance.addPostFrameCallback((_) {
    //     _controller.stop();
    //     Navigator.of(context).popUntil(ModalRoute.withName(Routes.HOME));
    //   });
    // }

    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            Center(
              child: Container(
                
                alignment: Alignment.topCenter,
                height: height,
                width: width,
                color: Colors.pink,
                child: _controller.value.isInitialized
                    ? VideoPlayer(_controller)
                    : Center(child: CircularProgressIndicator()),
              ),
            ),
            Stack(
              children: [
                Container(
                  child: Column(
                    children: [
                      Container(
                        color: Colors.transparent,
                        height: MediaQuery.of(context).orientation ==
                                Orientation.portrait
                            ? height * 0.945
                            : height * 0.92,
                      ),
                      Container(
                        color: Provider.of<VideoPlayerControlle>(context,
                                    listen: true)
                                .firstClick
                            ? Colors.black87
                            : Colors.transparent,
                        height: MediaQuery.of(context).orientation ==
                                Orientation.portrait
                            ? height * 0.055
                            : height * 0.08,
                      )
                    ],
                  ),
                ),
                Container(
                  child: Column(
                    children: [
                      Container(
                        color: Provider.of<VideoPlayerControlle>(context,
                                    listen: true)
                                .firstClick
                            ? Colors.black54
                            : Colors.transparent,
                        height: MediaQuery.of(context).orientation ==
                                Orientation.portrait
                            ? height * 0.945
                            : height * 0.92,
                        child: ControlsTopWidget(
                          controller: _controller,
                        ),
                      ),
                      Provider.of<VideoPlayerControlle>(context).firstClick
                          ? Container(
                              height: height * 0.015,
                              width: width,
                              child: SliderTheme(
                                data: SliderTheme.of(context).copyWith(
                                  trackHeight: 3.0,
                                  trackShape: CustomTrackShape(),
                                ),
                                child: Slider(
                                  activeColor: Colors.red,
                                  inactiveColor: Colors.white70,
                                  value: sliderValue,
                                  min: 0.0,
                                  max: (!validPosition &&
                                          _controller.value.duration == null)
                                      ? 1.0
                                      : _controller.value.duration.inSeconds
                                          .toDouble(),
                                  onChanged: validPosition
                                      ? _onSliderPositionChanged
                                      : null,
                                ),
                              ),
                            )
                          : Container(),
                      Container(
                        height: MediaQuery.of(context).orientation ==
                                Orientation.portrait
                            ? height * 0.035
                            : height * 0.065,
                        child: ControlsBottomWidget(
                          controller: _controller,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CustomTrackShape extends RoundedRectSliderTrackShape {
  Rect getPreferredRect({
    @required RenderBox parentBox,
    Offset offset = Offset.zero,
    @required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final double trackHeight = sliderTheme.trackHeight;
    final double trackLeft = offset.dx;
    // final double trackTop = offset.dy + (parentBox.size.height - trackHeight);
    final double trackTop = 0;
    final double trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}
