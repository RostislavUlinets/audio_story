import 'package:audio_story/screens/login_screen/login_screen_phone.dart';
import 'package:audio_story/screens/login_screen/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';

import 'provider/navigation_provider.dart';
import 'screens/audio/audio.dart';
import 'screens/audio_card/audo_info.dart';
import 'screens/category/category.dart';
import 'screens/category/create_category.dart';
import 'screens/deleted/deleted.dart';
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
      case CreateCategory.routeName:
        return MaterialPageRoute(
          builder: (context) => const CreateCategory(),
        );
      case SearchScreen.routeName:
        return MaterialPageRoute(
          builder: (context) => const SearchScreen(),
        );
      case DeeltedScreen.routeName:
        return MaterialPageRoute(
          builder: (context) => const DeeltedScreen(),
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
