import 'package:flutter/material.dart';
import 'package:flutter_layout_video_vlc/widgets/controls_top_video.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Container(
      color: Colors.blue,
      child: Stack(
        children: [
          Container(
            color: Colors.amber,
          ),
          Container(
            child: Column(
              children: [
                Container(
                  height: height * 0.9,
                  color: Colors.red,
                  child: ControlsTopVideo(),
                ),
                Container(
                  height: height * 0.1,
                  color: Colors.green,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
