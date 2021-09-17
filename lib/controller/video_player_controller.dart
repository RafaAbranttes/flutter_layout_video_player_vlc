import 'package:flutter/material.dart';

class VideoPlayerController extends ChangeNotifier {
  bool _firstClick = false;
  bool _showControls = false;
  bool _showBottomControls = false;
  bool _pause = false;
  bool _advance10sec = false;
  bool _back10sec = false;
  bool _showVolume = false;
  bool _fullScreen = false;
  bool _clickSpeedVideo = false;
  double _speedvideo = 1.0;
  double _volumeSet = 50;
  String _position = '00:00';
  String _duration = '00:01';
  bool _loading = false;
  bool _replay = false;

  get getReplay {
    return this._replay;
  }

  set setReplay(bool replay) {
    this._replay = replay;
    notifyListeners();
  }

  get getLoading {
    return this._loading;
  }

  set setLoading(bool loading) {
    this._loading = loading;
    notifyListeners();
  }

  set setClickSpeedVideo(bool clickSpeedVideo) {
    this._clickSpeedVideo = clickSpeedVideo;
    notifyListeners();
  }

  get getClickSpeedVideo {
    return this._clickSpeedVideo;
  }

  set setPosition(String position) {
    this._position = position;
    notifyListeners();
  }

  get getPosition {
    return this._position;
  }

  set setDuration(String duration) {
    this._duration = duration;
  }

  get getDuration {
    return this._duration;
  }

  bool _clicktoTimer = false;

  double get getVolumeSet {
    return this._volumeSet;
  }

  set setVolumeSet(double volumeSet) {
    this._volumeSet = volumeSet;
    notifyListeners();
  }

  set setClickToTime(bool clickToTime) {
    this._clicktoTimer = clickToTime;
    notifyListeners();
  }

  bool get getClickToTime {
    return this._clicktoTimer;
  }

  set setShowBottomControls(bool showBottomControls) {
    this._showBottomControls = showBottomControls;
    notifyListeners();
  }

  bool get getShowBottomControls {
    return this._showBottomControls;
  }

  set setShowVolume(bool showVolume) {
    this._showVolume = showVolume;
    notifyListeners();
  }

  bool get getShowVolume {
    return this._showVolume;
  }

  set setFullScreen(bool fullScreen) {
    this._fullScreen = fullScreen;
    notifyListeners();
  }

  bool get getFullScreen {
    return this._fullScreen;
  }

  set setSpeedVideo(double speedVideo) {
    this._speedvideo = speedVideo;
    notifyListeners();
  }

  double get getSpeedVideo {
    return this._speedvideo;
  }

  set setAdvance10sec(bool advance10sec) {
    this._advance10sec = advance10sec;
    notifyListeners();
  }

  get getAdvance10sec {
    return this._advance10sec;
  }

  set setBack10sec(bool back10sec) {
    this._back10sec = back10sec;
    notifyListeners();
  }

  get getBack10sec {
    return this._back10sec;
  }

  set setPause(bool pause) {
    this._pause = pause;
    notifyListeners();
  }

  bool get getPause {
    return this._pause;
  }

  set setFirstClick(bool firstClick) {
    this._firstClick = firstClick;
    notifyListeners();
  }

  bool get getFirstClick {
    return this._firstClick;
  }

  set setShowControls(bool showControls) {
    this._showControls = showControls;
    notifyListeners();
  }

  bool get getShowControls {
    return this._showControls;
  }

  void resetData() {
    this._firstClick = false;
    this._showControls = false;
    this._showBottomControls = false;
    this._pause = false;
    this._advance10sec = false;
    this._back10sec = false;
    this._showVolume = false;
    this._fullScreen = false;
    this._clickSpeedVideo = false;
    this._speedvideo = 1.0;
    this._volumeSet = 50;
    this._position = '00:00';
    this._duration = '00:01';
    this._loading = false;
    this._replay = false;
    notifyListeners();
  }
}
