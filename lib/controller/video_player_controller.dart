import 'package:flutter/material.dart';

class VideoPlayerController extends ChangeNotifier{

  bool _firstClick = false;
  bool _showControls = false;
  bool _showBottomControls = false;
  bool _pause = false;
  bool _advance10sec = false;
  bool _back10sec = false;
  bool _showVolume = false;
  bool _fullScreen = false;
  double _speedvideo = 1.0;

  bool _clicktoTimer = false;

  set setClickToTime(bool clickToTime){
    this._clicktoTimer = clickToTime;
    notifyListeners();
  }

  bool get getClickToTime{
    return this._clicktoTimer;
  }

  set setShowBottomControls(bool showBottomControls){
    this._showBottomControls = showBottomControls;
    notifyListeners();
  }

  bool get getShowBottomControls{
    return this._showBottomControls;
  }

  set setShowVolume(bool showVolume){
    this._showVolume = showVolume;
    notifyListeners();
  }

  bool get getShowVolume{
    return this._showVolume;
  }

  set setFullScreen(bool fullScreen){
    this._fullScreen = fullScreen;
    notifyListeners();
  }

  bool get getFullScreen{
    return this._fullScreen;
  }

  set setSpeedVideo(double speedVideo){
    this._speedvideo = speedVideo;
    notifyListeners();
  }

  double get getSpeedVideo{
    return this._speedvideo;
  }

  set setAdvance10sec(bool advance10sec){
    this._advance10sec = advance10sec;
    notifyListeners();
  }

  get getAdvance10sec{
    return this._advance10sec;
  }

  set setBack10sec(bool back10sec){
    this._back10sec = back10sec;
    notifyListeners();
  }

  get getBack10sec{
    return this._back10sec;
  }

  set setPause(bool pause){
    this._pause = pause;
    notifyListeners();
  } 

  bool get getPause{
    return this._pause;
  }

  set setFirstClick(bool firstClick){
    this._firstClick = firstClick;
    notifyListeners();
  }

  bool get getFirstClick{
    return this._firstClick;
  }

  set setShowControls(bool showControls){
    this._showControls = showControls;
    notifyListeners();
  }

  bool get getShowControls{
    return this._showControls;
  }

}