import 'package:audio_story/screens/audio_card/add_to_category.dart';
import 'package:audio_story/screens/category/card_info.dart';
import 'package:audio_story/screens/deleted/delete_screen.dart';
import 'package:audio_story/screens/login_screen/login_screen_phone.dart';
import 'package:audio_story/screens/login_screen/welcome_screen.dart';
import 'package:flutter/material.dart';

import 'screens/audio/audio.dart';
import 'screens/category/category.dart';
import 'screens/category/create_category.dart';
import 'screens/login_screen/final_screen.dart';
import 'screens/main_screen/main_screen.dart';
import 'screens/profile/profile.dart';
import 'screens/record/player.dart';
import 'screens/record/record.dart';
import 'screens/search/search.dart';
import 'screens/subscribe/subscribe.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case WelcomeScreen.routeName:
        return MaterialPageRoute(
          builder: (context) => const WelcomeScreen(),
        );
      case FinalScreen.routeName:
        return MaterialPageRoute(
          builder: (context) => const FinalScreen(duration: 3),
        );
      case LoginScreen.routeName:
        return MaterialPageRoute(
          builder: (context) => LoginScreen(),
        );
      case MainScreen.routeName:
        return MaterialPageRoute(
          builder: (context) => const MainScreen(),
        );
      case Category.routeName:
        return MaterialPageRoute(
          builder: (context) => const Category(),
        );
      case CreateCategory.routeName:
        return MaterialPageRoute(
          builder: (context) => const CreateCategory(),
        );
      case CardInfo.routeName:
        return MaterialPageRoute(
          builder: (context) => CardInfo(index: settings.arguments as int),
        );
      case CustomCategory.routeName:
        return MaterialPageRoute(
          builder: (context) => const CustomCategory(),
        );
      case Audio.routeName:
        return MaterialPageRoute(
          builder: (context) => const Audio(),
        );
      case Profile.routeName:
        return MaterialPageRoute(
          builder: (context) => const Profile(),
        );
      case Subscribe.routeName:
        return MaterialPageRoute(
          builder: (context) => const Subscribe(),
        );
      case Records.routeName:
        return MaterialPageRoute(
          builder: (context) => const Records(),
        );
      case Player.routeName:
        return MaterialPageRoute(
          builder: (context) => const Player(),
        );
      case SearchScreen.routeName:
        return MaterialPageRoute(
          builder: (context) => const SearchScreen(),
        );
      case DeleteScreen.routeName:
        return MaterialPageRoute(
          builder: (context) => const DeleteScreen(),
        );
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (context) {
      return Scaffold(
        appBar: AppBar(
          title: Text("ERROR"),
          centerTitle: true,
        ),
        body: const Center(
          child: Text("PAGE NOT FOUND!"),
        ),
      );
    });
  }
}
