import 'package:flutter/material.dart';
import 'package:flutter_layout_video_vlc/controller/video_player_controller.dart';
import 'package:flutter_layout_video_vlc/widgets/controls_top_video_widget.dart';
import 'package:provider/provider.dart';

class ControlsTopVideo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Consumer<VideoPlaverController>(
      builder: (context, videoPlayerController, child) {
        return Container(
          child: GestureDetector(
            onTap: () {
              if (videoPlayerController.getFirstClick) {
                videoPlayerController.setFirstClick = false;
                videoPlayerController.setShowControls = false;
              } else if (!videoPlayerController.getFirstClick) {
                videoPlayerController.setFirstClick = true;
                videoPlayerController.setShowControls = true;
              }
            },
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
