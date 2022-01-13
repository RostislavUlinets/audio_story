import 'package:flutter/material.dart';

class NavigationProvider extends ChangeNotifier {
  int screenIndex = 0;

  void changeScreen(int newIndex) {
    screenIndex = newIndex;
    notifyListeners();
  }
}
