import 'package:flutter/material.dart';
import 'package:flutter_layout_video_vlc/controller/video_player_controller.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;

class ControlsBottomVideoWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    void _setSoundVolume(value) {
      Provider.of<VideoPlayerController>(context, listen: false).setVolumeSet =
          value;
    }

    return Consumer<VideoPlayerController>(
      builder: (context, videoPlayerController, child) {
        void _onSliderPositionChanged(double progress) {
          Provider.of<VideoPlayerController>(context, listen: false)
              .setSlideValue = progress.floor().toDouble();

          //convert to Milliseconds since VLC requires MS to set time
        }

        return Container(
          child: Stack(
            children: [
              Container(
                color: Colors.black87,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: width * 0.02),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () async {
                              if (videoPlayerController.getLoading) {
                                videoPlayerController.setReplay = true;
                                videoPlayerController.setFirstClick = false;
                                videoPlayerController.setShowControls = false;
                                videoPlayerController.setShowBottomControls =
                                    false;
                                videoPlayerController.setPause = false;
                              } else if (videoPlayerController.getPause) {
                                videoPlayerController.setPause = false;
                                await Future.delayed(
                                    Duration(milliseconds: 750), () {
                                  videoPlayerController.setFirstClick = false;
                                  videoPlayerController.setShowControls = false;
                                  videoPlayerController.setShowBottomControls =
                                      false;
                                });
                              } else {
                                videoPlayerController.setPause = true;
                              }
                            },
                            child: Container(
                              alignment: Alignment.center,
                              height: height * 0.06,
                              width: height * 0.0375,
                              child: videoPlayerController.getLoading
                                  ? SvgPicture.asset(
                                      "assets/icons/icon-play.svg",
                                      color: Colors.white,
                                      height: height * 0.03,
                                    )
                                  : !videoPlayerController.getPause
                                      ? SvgPicture.asset(
                                          "assets/icons/icon-pause-small.svg",
                                          color: Colors.white,
                                          height: height * 0.03,
                                        )
                                      : SvgPicture.asset(
                                          "assets/icons/icon-play.svg",
                                          color: Colors.white,
                                          height: height * 0.03,
                                        ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              videoPlayerController.setBack10sec = true;
                            },
                            child: Container(
                              alignment: Alignment.center,
                              height: height * 0.05,
                              width: height * 0.0375,
                              child: SvgPicture.asset(
                                "assets/icons/icon-voltar-10s.svg",
                                color: Colors.white,
                                height: height * 0.03,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              videoPlayerController.setAdvance10sec = true;
                            },
                            child: Container(
                              alignment: Alignment.center,
                              height: height * 0.05,
                              width: height * 0.0375,
                              child: SvgPicture.asset(
                                "assets/icons/icon-avancar-10s.svg",
                                color: Colors.white,
                                height: height * 0.03,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              videoPlayerController.setShowVolume =
                                  !videoPlayerController.getShowVolume;
                            },
                            onTapUp: (detail) {
                              videoPlayerController.setClickToTime = true;
                            },
                            child: Container(
                              padding: EdgeInsets.only(left: width * 0.006),
                              height: height * 0.05,
                              width: height * 0.04,
                              child: videoPlayerController.getVolumeSet == 0
                                  ? SvgPicture.asset(
                                      "assets/icons/icon-som-off.svg",
                                      color: Colors.white,
                                    )
                                  : SvgPicture.asset(
                                      "assets/icons/icon-volume-up.svg",
                                      color: Colors.white,
                                    ),
                            ),
                          ),
                          SizedBox(
                            width: width * 0.01,
                          ),
                          videoPlayerController.getShowVolume
                              ? Container(
                                  margin: EdgeInsets.only(right: width * 0.02),
                                  height: height * 0.05,
                                  width: height * 0.1,
                                  child: SliderTheme(
                                    data: SliderTheme.of(context).copyWith(
                                      trackHeight: 2.0,
                                      trackShape: CustomTrackShape2(),
                                    ),
                                    child: Slider(
                                      activeColor: Colors.red,
                                      min: 0,
                                      max: 100,
                                      value: Provider.of<VideoPlayerController>(
                                              context)
                                          .getVolumeSet,
                                      onChanged: _setSoundVolume,
                                    ),
                                  ),
                                )
                              : Container(),
                          Container(
                            alignment: Alignment.center,
                            height: height * 0.05,
                            child: Text(
                              "${Provider.of<VideoPlayerController>(context).getPosition} / ${Provider.of<VideoPlayerController>(context).getDuration}",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: width * 0.01),
                      height: height * 0.1,
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              if (videoPlayerController.getSpeedVideo == 2) {
                                videoPlayerController.setSpeedVideo = 0.5;
                              } else {
                                videoPlayerController.setSpeedVideo =
                                    videoPlayerController.getSpeedVideo + 0.5;
                              }
                              videoPlayerController.setClickSpeedVideo = true;
                            },
                            onTapUp: (detail) {
                              videoPlayerController.setClickToTime = true;
                            },
                            child: Container(
                              height: height * 0.05,
                              width: height * 0.0375,
                              child: Stack(
                                children: [
                                  Center(
                                    child: Icon(
                                      Icons.timer,
                                      size: height * 0.030,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                        left: height * 0.022,
                                        top: height * 0.022),
                                    alignment: Alignment.bottomRight,
                                    width: height * 0.022,
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Center(
                                      child: Text(
                                        videoPlayerController.getSpeedVideo
                                            .toString(),
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: height * 0.008,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              videoPlayerController.setFullScreen =
                                  !videoPlayerController.getFullScreen;
                            },
                            onTapUp: (detail) {
                              videoPlayerController.setClickToTime = true;
                            },
                            child: Container(
                                height: height * 0.05,
                                width: height * 0.0375,
                                child: Icon(
                                  Icons.fullscreen,
                                  size: height * 0.035,
                                  color: Colors.white,
                                )),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Container(
                alignment: Alignment.topCenter,
                height: height * 0.01,
                
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    margin: EdgeInsets.only(bottom: height * 0.01),
                    alignment: Alignment.topCenter,
                    child: SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        trackHeight: 2.0,
                        trackShape: CustomTrackShape(),
                      ),
                      child: Slider(
                        activeColor: Colors.red,
                        inactiveColor: Colors.white70,
                        value: Provider.of<VideoPlayerController>(context)
                            .getSlideValue,
                        min: 0.0,
                        // max: 13,
                        max: (!Provider.of<VideoPlayerController>(context)
                                    .getValidPosition &&
                                Provider.of<VideoPlayerController>(context)
                                        .getControllerDurationInSecond ==
                                    null)
                            ? 1.0
                            : Provider.of<VideoPlayerController>(context)
                                .getControllerDurationInSecond,
                        onChanged: Provider.of<VideoPlayerController>(context)
                                .getValidPosition
                            ? Provider.of<VideoPlayerController>(context).onSliderPositionChanged
                            : null,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class CustomTrackShape2 extends RoundedRectSliderTrackShape {
  Rect getPreferredRect({
    @required RenderBox parentBox,
    Offset offset = Offset.zero,
    @required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final double trackHeight = 2;
    final double trackLeft = offset.dx;
    final double trackTop =
        offset.dy + (parentBox.size.height - trackHeight) / 2;
    final double trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
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
    final double trackTop = offset.dy + (parentBox.size.height - trackHeight);
    final double trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}
