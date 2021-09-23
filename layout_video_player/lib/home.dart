import 'package:flutter/material.dart';
import 'package:layout_video_player/routes/routes.dart';
import 'package:layout_video_player/video/arguments/arguments_vlc_video_intro.dart';
import 'package:layout_video_player/video/controller/video_player_controller.dart';


import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        child: Center(
          child: ElevatedButton(
            onPressed: () {
              Provider.of<VideoPlayerControlle>(context, listen: false)
                  .resetData();
              Navigator.of(context).pushNamed(
                Routes.VIDEO_VLC_INTRO,
                arguments: ArgumentsVlcVideoIntro(
                  heightGlobal: height,
                  widthGlobal: width,
                  inApp: true,
                  url: "assets/01.mp4",
                  isIntroPage: true,
                ),
              );
            },
            child: Text("Clique aqui"),
          ),
        ),
      ),
    );
  }
}
