import 'package:flutter/material.dart';
import 'package:flutter_layout_video_vlc/controller/video_player_controller.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;

class ControlsTopVideoWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Consumer<VideoPlayerController>(
      builder: (context, videoPlayerController, child) {
        return Container(
          width: width,
          height: height * 0.9,
          color: Colors.black54,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: width * 0.02),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  alignment: Alignment.centerRight,
                  height: width * 0.3,
                  width: width * 0.3,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: videoPlayerController.getLoading
                      ? Container()
                      : TextButton(
                          child: SvgPicture.asset(
                            "assets/icons/icon-voltar-10s.svg",
                            color: Colors.white,
                            height: height * 0.1,
                          ),
                          style: TextButton.styleFrom(
                              primary: Colors.white, shape: CircleBorder()),
                          onPressed: () {
                            videoPlayerController.setBack10sec = true;
                          },
                        ),
                ),
                Container(
                  alignment: Alignment.center,
                  height: width * 0.3,
                  width: width * 0.3,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: videoPlayerController.getLoading
                      ? TextButton(
                          child: SvgPicture.asset(
                            "assets/icons/icon-play.svg",
                            color: Colors.white,
                            height: height * 0.15,
                          ),
                          style: TextButton.styleFrom(
                            primary: Colors.white,
                            shape: CircleBorder(),
                          ),
                          onPressed: () async {
                            if (videoPlayerController.getLoading) {
                              videoPlayerController.setReplay = true;
                              videoPlayerController.setFirstClick = false;
                              videoPlayerController.setShowControls = false;
                              videoPlayerController.setShowBottomControls =
                                  false;
                              videoPlayerController.setPause = false;
                            }
                          },
                        )
                      : TextButton(
                          child: !videoPlayerController.getPause
                              ? SvgPicture.asset(
                                  "assets/icons/icon-pause-small.svg",
                                  color: Colors.white,
                                  height: height * 0.15,
                                )
                              : SvgPicture.asset(
                                  "assets/icons/icon-play.svg",
                                  color: Colors.white,
                                  height: height * 0.15,
                                ),
                          style: TextButton.styleFrom(
                              primary: Colors.white, shape: CircleBorder()),
                          onPressed: () async {
                            videoPlayerController.setPause =
                                !videoPlayerController.getPause;
                            if (videoPlayerController.getPause) {
                            } else {
                              await Future.delayed(Duration(milliseconds: 750),
                                  () {
                                videoPlayerController.setFirstClick = false;
                                videoPlayerController.setShowControls = false;
                                videoPlayerController.setShowBottomControls =
                                    false;
                              });
                            }
                          },
                        ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  height: width * 0.3,
                  width: width * 0.3,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: videoPlayerController.getLoading
                      ? Container()
                      : TextButton(
                          child: SvgPicture.asset(
                            "assets/icons/icon-avancar-10s.svg",
                            color: Colors.white,
                            height: height * 0.1,
                          ),
                          style: TextButton.styleFrom(
                              primary: Colors.white, shape: CircleBorder()),
                          onPressed: () {
                            videoPlayerController.setAdvance10sec = true;
                          },
                        ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
