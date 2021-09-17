import 'package:flutter/material.dart';
import 'package:flutter_layout_video_vlc/controller/video_player_controller.dart';
import 'package:flutter_layout_video_vlc/widgets/controls_top_video_widget.dart';
import 'package:provider/provider.dart';

class ControlsTopVideo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Consumer<VideoPlayerController>(
      builder: (context, videoPlayerController, child) {
        return Container(
          child: GestureDetector(
            onTap: () {
              if (!videoPlayerController.getFirstClick &&
                  videoPlayerController.getShowBottomControls) {
                videoPlayerController.setShowBottomControls = false;
              } else if (videoPlayerController.getShowBottomControls &&
                  videoPlayerController.getShowControls) {
                videoPlayerController.setFirstClick = false;
                videoPlayerController.setShowControls = false;
                videoPlayerController.setShowBottomControls = false;
              } else if (videoPlayerController.getFirstClick) {
                videoPlayerController.setFirstClick = false;
                videoPlayerController.setShowControls = false;
                videoPlayerController.setShowBottomControls = false;
              } else if (!videoPlayerController.getFirstClick) {
                videoPlayerController.setFirstClick = true;
                videoPlayerController.setShowControls = true;
                videoPlayerController.setShowBottomControls = true;
              }
            },
            onTapUp: (detail) => videoPlayerController.setClickToTime = true,
            child: videoPlayerController.getShowControls
                ? ControlsTopVideoWidget()
                : Container(
                    height: height,
                    color: Colors.transparent,
                  ),
          ),
        );
      },
    );
  }
}
