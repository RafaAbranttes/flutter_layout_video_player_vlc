import 'package:flutter/material.dart';
import 'package:flutter_layout_video_vlc/controller/video_player_controller.dart';
import 'package:flutter_layout_video_vlc/widgets/controls_bottom_video_widget.dart';
import 'package:provider/provider.dart';

class ControlsBottomVideo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Consumer<VideoPlayerController>(
      builder: (context, videoPlayerController, child) {
        return GestureDetector(
          onTap: () {
            if (videoPlayerController.getShowBottomControls &&
                videoPlayerController.getShowControls) {
              videoPlayerController.setShowControls = false;
              videoPlayerController.setShowBottomControls = false;
              videoPlayerController.setFirstClick = false;
            } else if (videoPlayerController.getShowBottomControls) {
              videoPlayerController.setShowControls = false;
              videoPlayerController.setShowBottomControls = false;
              videoPlayerController.setFirstClick = false;
            } else {
              videoPlayerController.setShowBottomControls = true;
            }
          },
          child: Container(
            child: videoPlayerController.getShowBottomControls ||
                    videoPlayerController.getShowControls
                ? ControlsBottomVideoWidget()
                : Container(
                    color: Colors.transparent,
                  ),
          ),
        );
      },
    );
  }
}
