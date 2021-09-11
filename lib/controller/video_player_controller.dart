import 'package:flutter/material.dart';

class VideoPlaverController extends ChangeNotifier{

  bool firstClick = false;
  bool showControls = false;

  set setFirstClick(bool firstClick){
    this.firstClick = firstClick;
    notifyListeners();
  }

  bool get getFirstClick{
    return this.firstClick;
  }

  set setShowControls(bool showControls){
    this.showControls = showControls;
    notifyListeners();
  }

  bool get getShowControls{
    return this.showControls;
  }

}