import 'package:flutter/material.dart';

class CurrentAudio extends ChangeNotifier {
  String? audioId;

  void changeScreen(String newAudioName) {
    audioId = newAudioName;
    notifyListeners();
  }
}
