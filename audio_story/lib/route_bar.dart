import 'package:audio_story/provider/navigation_provider.dart';
import 'package:audio_story/screens/audio/audio.dart';
import 'package:audio_story/screens/main_screen/main_screen.dart';
import 'package:audio_story/screens/subscribe/subscribe.dart';
import 'package:audio_story/widgets/bottomnavbar.dart';
import 'package:audio_story/widgets/side_menu.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'routes/route.dart';
import 'screens/category/category.dart';
import 'screens/deleted/delete_screen.dart';
import 'screens/profile/profile.dart';
import 'screens/record/record.dart';
import 'screens/search/search.dart';

class Initilizer extends StatelessWidget {
  const Initilizer({Key? key}) : super(key: key);

  static const routeName = '/initilize';

  @override
  Widget build(BuildContext context) {
    int _buttonIndex =
        context.select((NavigationProvider nc) => nc.screenIndex);

    switch (_buttonIndex) {
      case 0:
        RouteGenerator.navigationKey.currentState
            ?.pushReplacementNamed(MainScreen.routeName);

        break;
      case 1:
        RouteGenerator.navigationKey.currentState
            ?.pushReplacementNamed(Category.routeName);

        break;
      case 2:
        RouteGenerator.navigationKey.currentState
            ?.pushReplacementNamed(Records.routeName);

        break;
      case 3:
        RouteGenerator.navigationKey.currentState
            ?.pushReplacementNamed(Audio.routeName);

        break;
      case 4:
        RouteGenerator.navigationKey.currentState
            ?.pushReplacementNamed(Profile.routeName);

        break;
      case 5:
        RouteGenerator.navigationKey.currentState
            ?.pushReplacementNamed(SearchScreen.routeName);

        break;
      case 6:
        RouteGenerator.navigationKey.currentState
            ?.pushReplacementNamed(DeleteScreen.routeName);
        break;
      case 7:
        RouteGenerator.navigationKey.currentState
            ?.pushReplacementNamed(Subscribe.routeName);
        break;
      default:
        break;
    }

    return Scaffold(
      drawer: const ClipRRect(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(25), bottomRight: Radius.circular(25)),
        child: SideMenu(),
      ),
      extendBody: true,
      bottomNavigationBar: const CustomNavigationBar(),
      body: Navigator(
        key: RouteGenerator.navigationKey,
        initialRoute: MainScreen.routeName,
        onGenerateRoute: RouteGenerator.generateRoute,
      ),
    );
  }
}
