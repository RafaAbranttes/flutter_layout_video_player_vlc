import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';
import 'package:layout_vlc/vlc_intro/controller/video_player_controller.dart';
import 'package:layout_vlc/vlc_intro/widgets/slide_volume.dart';
import 'package:provider/provider.dart';

class ControlsBottomWidget extends StatelessWidget {
  VlcPlayerController controller;

  ControlsBottomWidget({
    @required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Provider.of<VideoPlayerControlle>(context).firstClick
        ? Container(
            margin: EdgeInsets.symmetric(horizontal: width * 0.01),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Row(
                    children: [
                      Container(
                        height: height * 0.03,
                        width: height * 0.03,
                        child: GestureDetector(
                          onTap: () {
                            Provider.of<VideoPlayerControlle>(context,
                                    listen: false)
                                .pause = !Provider.of<VideoPlayerControlle>(
                                    context,
                                    listen: false)
                                .pause;
                            if (Provider.of<VideoPlayerControlle>(context,
                                    listen: false)
                                .pause) {
                              controller.pause();
                            } else {
                              controller.play();
                            }
                          },
                          child: Provider.of<VideoPlayerControlle>(context,
                                      listen: false)
                                  .pause
                              ? SvgPicture.asset(
                                  "assets/icons/icon-play.svg",
                                  color: Colors.white,
                                )
                              : SvgPicture.asset(
                                  "assets/icons/icon-pause-small.svg",
                                  color: Colors.white,
                                ),
                        ),
                      ),
                      SizedBox(
                        width: width * 0.01,
                      ),
                      Container(
                        height: height * 0.03,
                        width: height * 0.03,
                        child: GestureDetector(
                          onTap: () {
                            Provider.of<VideoPlayerControlle>(context,
                                    listen: false)
                                .voltar10s = !Provider.of<VideoPlayerControlle>(
                                    context,
                                    listen: false)
                                .voltar10s;
                            if (Provider.of<VideoPlayerControlle>(context,
                                    listen: false)
                                .voltar10s) {
                              controller.seekTo(
                                Duration(
                                  seconds:
                                      controller.value.position.inSeconds - 10,
                                ),
                              );
                            }
                          },
                          child: SvgPicture.asset(
                            "assets/icons/icon-voltar-10s.svg",
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: width * 0.01,
                      ),
                      Container(
                        height: height * 0.03,
                        width: height * 0.03,
                        child: GestureDetector(
                          onTap: () {
                            Provider.of<VideoPlayerControlle>(context,
                                        listen: false)
                                    .avancar10s =
                                !Provider.of<VideoPlayerControlle>(context,
                                        listen: false)
                                    .avancar10s;

                            if (Provider.of<VideoPlayerControlle>(context,
                                    listen: false)
                                .avancar10s) {
                              controller.seekTo(
                                Duration(
                                  seconds:
                                      controller.value.position.inSeconds + 10,
                                ),
                              );
                            }
                          },
                          child: SvgPicture.asset(
                            "assets/icons/icon-avancar-10s.svg",
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: width * 0.01,
                      ),
                      Container(
                        height: height * 0.03,
                        width: height * 0.037,
                        child: GestureDetector(
                          onTap: () {
                            Provider.of<VideoPlayerControlle>(context,
                                    listen: false)
                                .volume = !Provider.of<VideoPlayerControlle>(
                                    context,
                                    listen: false)
                                .volume;
                          },
                          child: controller.value.volume == 0
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
                      Provider.of<VideoPlayerControlle>(context).volume
                          ? SlideVolumeWidget(controller: controller)
                          : Container(),
                      SizedBox(
                        width: width * 0.01,
                      ),
                      Container(
                        child: Text(
                          "${Provider.of<VideoPlayerControlle>(context).position}/${Provider.of<VideoPlayerControlle>(context).duration}",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Row(
                    children: [
                      Container(
                        height: height * 0.03,
                        width: height * 0.03,
                        child: GestureDetector(
                          onTap: () {
                            Provider.of<VideoPlayerControlle>(context,
                                    listen: false)
                                .speed = Provider.of<VideoPlayerControlle>(
                                        context,
                                        listen: false)
                                    .speed +
                                0.5;

                            if (Provider.of<VideoPlayerControlle>(context,
                                        listen: false)
                                    .speed ==
                                2.5) {
                              Provider.of<VideoPlayerControlle>(context,
                                      listen: false)
                                  .speed = 0.5;
                            }

                            controller.setPlaybackSpeed(
                                Provider.of<VideoPlayerControlle>(context,
                                        listen: false)
                                    .speed);
                          },
                          child: Stack(
                            children: [
                              Icon(
                                Icons.timer,
                                color: Colors.white,
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                  left: height * (0.03 - 0.017),
                                  top: height * (0.03 - 0.017),
                                ),
                                height: height * 0.017,
                                width: height * 0.017,
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(90),
                                ),
                                child: Center(
                                  child: Text(
                                    Provider.of<VideoPlayerControlle>(context)
                                        .speed
                                        .toString(),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: height * 0.008),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: width * 0.015,
                      ),
                      Container(
                        height: height * 0.025,
                        width: height * 0.025,
                        child: GestureDetector(
                          onTap: () {
                            Provider.of<VideoPlayerControlle>(context,
                                        listen: false)
                                    .fullScreen =
                                !Provider.of<VideoPlayerControlle>(context,
                                        listen: false)
                                    .fullScreen;
                            if (Provider.of<VideoPlayerControlle>(context,
                                    listen: false)
                                .fullScreen) {
                              if (Platform.isAndroid) {
                                SystemChrome.setEnabledSystemUIOverlays([]);
                              }
                              if (Platform.isIOS) {
                                SystemChrome.setEnabledSystemUIOverlays(
                                    [SystemUiOverlay.bottom]);
                              }
                            }
                          },
                          child: SvgPicture.asset(
                            "assets/icons/icon-expandir.svg",
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        : Container();
  }
}
