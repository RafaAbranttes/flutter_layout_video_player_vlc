import 'package:flutter/material.dart';
import 'package:layout_video_player/home.dart';
import 'package:layout_video_player/routes/routes.dart';
import 'package:layout_video_player/vlc_intro/controller/video_player_controller.dart';
import 'package:layout_video_player/vlc_intro/vlc_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => VideoPlayerControlle(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routes: {
          Routes.HOME: (context) => Home(),
          Routes.VIDEO_VLC_INTRO: (context) => VLCScreen(ModalRoute.of(context).settings.arguments),
        },
      ),
    );
  }
}
