import 'package:flutter/material.dart';

class ControlsTopVideoWidget extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Container(
      height: height * 0.9,
      color: Colors.blue,
      child: Text("Ola"),
    );
  }
}