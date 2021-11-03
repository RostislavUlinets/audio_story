
import 'package:flutter/material.dart';

class NavigationController extends ChangeNotifier{
  String screenName = '';

  void changeScreen(String newScreenName) {
    screenName = newScreenName;
    notifyListeners();
  }
}