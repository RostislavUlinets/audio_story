import 'package:flutter/material.dart';

class CurrentAudio extends ChangeNotifier {
  String? audioName;

  void changeScreen(String newAudioName) {
    audioName = newAudioName;
    notifyListeners();
  }
}
