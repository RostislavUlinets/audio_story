import 'package:audio_story/models/navigation_item.dart';
import 'package:flutter/material.dart';

class NavigationProvider extends ChangeNotifier{
  NavigationItem _navigationItem = NavigationItem.home;

  NavigationItem get navigationIteam => _navigationItem;

  void setNavigationIteam (NavigationItem navigationItem) {
    _navigationItem = navigationItem;

    notifyListeners();
  }
}

class NavigationController extends ChangeNotifier{
  String screenName = '/';

  void changeScreen(String newScreenName) {
    screenName = newScreenName;
    notifyListeners();
  }
}