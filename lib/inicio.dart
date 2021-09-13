import 'package:flutter/material.dart';
import 'package:flutter_layout_video_vlc/home.dart';

class Inicio extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Teste"),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text("Clique Aqui!!"),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => Home(
                  heightGlobal: MediaQuery.of(context).size.height,
                  widthGlobal: MediaQuery.of(context).size.width,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
