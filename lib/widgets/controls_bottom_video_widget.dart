import 'package:flutter/material.dart';
import 'package:flutter_layout_video_vlc/controller/video_player_controller.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;

class ControlsBottomVideoWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Consumer<VideoPlayerController>(
      builder: (context, videoPlayerController, child) {
        return Container(
          child: Stack(
            children: [
              Container(
                color: Colors.black87,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: width * 0.03),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () async {
                              if (videoPlayerController.getPause) {
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
                              width: height * 0.06,
                              child: Icon(
                                !videoPlayerController.getPause
                                    ? Icons.pause
                                    : Icons.play_arrow,
                                size: height * 0.055,
                                color: Colors.white,
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
                              width: height * 0.05,
                              child: Icon(
                                Icons.settings_backup_restore_rounded,
                                size: height * 0.045,
                                color: Colors.white,
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
                              width: height * 0.05,
                              child: Icon(
                                Icons.settings_backup_restore_rounded,
                                size: height * 0.045,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              videoPlayerController.setShowVolume =
                                  !videoPlayerController.getShowVolume;
                            },
                            onTapUp: (detail){
                              videoPlayerController.setClickToTime = true;
                            },
                            child: Container(
                                height: height * 0.05,
                                width: height * 0.05,
                                child: Icon(
                                  Icons.volume_up,
                                  size: height * 0.045,
                                  color: Colors.white,
                                )),
                          ),
                          SizedBox(
                            width: width * 0.01,
                          ),
                          videoPlayerController.getShowVolume
                              ? Container(
                                color: Colors.red,
                                  height: height * 0.05,
                                  width: height * 0.08,
                                )
                              : Container(),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: width * 0.03),
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
                            },
                            onTapUp: (detail){
                              videoPlayerController.setClickToTime = true;
                            },
                            child: Container(
                              height: height * 0.05,
                              width: height * 0.05,
                              child: Stack(
                                children: [
                                  Center(
                                    child: Icon(
                                      Icons.timer,
                                      size: height * 0.045,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                        left: height * 0.027,
                                        top: height * 0.027),
                                    alignment: Alignment.bottomRight,
                                    width: height * 0.03,
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
                                          fontSize: height * 0.01,
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
                              videoPlayerController.setFullScreen = !videoPlayerController.getFullScreen;

                            },
                            onTapUp: (detail){
                              videoPlayerController.setClickToTime = true;
                            },
                            child: Container(
                                height: height * 0.05,
                                width: height * 0.05,
                                child: Icon(
                                  Icons.fullscreen,
                                  size: height * 0.045,
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
                height: height * 0.01,
                color: Colors.transparent,
              ),
            ],
          ),
        );
      },
    );
  }
}
