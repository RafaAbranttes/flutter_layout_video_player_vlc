import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:layout_video_player/vlc_intro/controller/video_player_controller.dart';
import 'package:layout_video_player/vlc_intro/widgets/slide_volume.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

class ControlsBottomWidget extends StatelessWidget {
  VideoPlayerController controller;

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
                        height: MediaQuery.of(context).orientation ==
                                Orientation.portrait
                            ? height * 0.03
                            : height * 0.05,
                        width: MediaQuery.of(context).orientation ==
                                Orientation.portrait
                            ? height * 0.03
                            : height * 0.05,
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
                              Future.delayed(Duration(seconds: 2), () {
                                Provider.of<VideoPlayerControlle>(context,
                                        listen: false)
                                    .firstClick = false;
                              });
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
                        height: MediaQuery.of(context).orientation ==
                                Orientation.portrait
                            ? height * 0.03
                            : height * 0.05,
                        width: MediaQuery.of(context).orientation ==
                                Orientation.portrait
                            ? height * 0.03
                            : height * 0.05,
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
                        height: MediaQuery.of(context).orientation ==
                                Orientation.portrait
                            ? height * 0.03
                            : height * 0.05,
                        width: MediaQuery.of(context).orientation ==
                                Orientation.portrait
                            ? height * 0.03
                            : height * 0.05,
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
                        height: MediaQuery.of(context).orientation ==
                                Orientation.portrait
                            ? height * 0.03
                            : height * 0.05,
                        width: MediaQuery.of(context).orientation ==
                                Orientation.portrait
                            ? height * 0.037
                            : height * 0.057,
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
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).orientation ==
                                    Orientation.portrait
                                ? height * 0.002
                                : height * 0.0022),
                        child: Center(
                          child: Text(
                            "${Provider.of<VideoPlayerControlle>(context).position}/${Provider.of<VideoPlayerControlle>(context).duration}",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: MediaQuery.of(context).orientation ==
                                      Orientation.portrait
                                  ? height * 0.017
                                  : height * 0.025,
                            ),
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
                        height: MediaQuery.of(context).orientation ==
                                Orientation.portrait
                            ? height * 0.03
                            : height * 0.05,
                        width: MediaQuery.of(context).orientation ==
                                Orientation.portrait
                            ? height * 0.03
                            : height * 0.05,
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
                              Icon(Icons.timer,
                                  color: Colors.white,
                                  size: MediaQuery.of(context).orientation ==
                                          Orientation.portrait
                                      ? height * 0.025
                                      : height * 0.045),
                              Container(
                                margin: EdgeInsets.only(
                                  left: MediaQuery.of(context).orientation ==
                                          Orientation.portrait
                                      ? height * (0.03 - 0.017)
                                      : height * (0.05 - 0.025),
                                  top: MediaQuery.of(context).orientation ==
                                          Orientation.portrait
                                      ? height * (0.03 - 0.017)
                                      : height * (0.05 - 0.025),
                                ),
                                height: MediaQuery.of(context).orientation ==
                                        Orientation.portrait
                                    ? height * 0.017
                                    : height * 0.025,
                                width: MediaQuery.of(context).orientation ==
                                        Orientation.portrait
                                    ? height * 0.017
                                    : height * 0.025,
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
                                        fontSize: MediaQuery.of(context)
                                                    .orientation ==
                                                Orientation.portrait
                                            ? height * 0.008
                                            : height * 0.012),
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
                        height: MediaQuery.of(context).orientation ==
                                Orientation.portrait
                            ? height * 0.025
                            : height * 0.04,
                        width: MediaQuery.of(context).orientation ==
                                Orientation.portrait
                            ? height * 0.025
                            : height * 0.04,
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
                              if (controller.value.aspectRatio >= 1.5) {
                                SystemChrome.setEnabledSystemUIOverlays([]);
                                SystemChrome.setPreferredOrientations(
                                    [DeviceOrientation.landscapeRight]);
                              } else {
                                SystemChrome.setEnabledSystemUIOverlays([]);
                              }
                              // Provider.of<VideoPlayerControlle>(context,
                              //         listen: false)
                              //     .pause = false;
                              // if (Platform.isAndroid) {
                              //   SystemChrome.setEnabledSystemUIOverlays([]);
                              // }
                              // if (Platform.isIOS) {
                              //   SystemChrome.setEnabledSystemUIOverlays(
                              //       [SystemUiOverlay.bottom]);
                              // }
                            } else {
                              SystemChrome.setEnabledSystemUIOverlays([
                                SystemUiOverlay.bottom,
                                SystemUiOverlay.top
                              ]);
                              SystemChrome.setPreferredOrientations(
                                  [DeviceOrientation.portraitUp]);
                              // Provider.of<VideoPlayerControlle>(context,
                              //         listen: false)
                              //     .pause = false;
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
