import 'package:audio_story/provider/navigation_provider.dart';
import 'package:audio_story/screens/audio/audio.dart';
import 'package:audio_story/screens/login_screen/welcome_screen.dart';
import 'package:audio_story/screens/main_screen/main_screen.dart';
import 'package:audio_story/widgets/bottomnavbar.dart';
import 'package:audio_story/widgets/side_menu.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/src/provider.dart';

import 'routes/route.dart';
import 'screens/category/category.dart';
import 'screens/deleted/delete_screen.dart';
import 'screens/profile/profile.dart';
import 'screens/record/record.dart';
import 'screens/search/search.dart';

class Initilizer extends StatelessWidget {
  static final _navigationKey = GlobalKey<NavigatorState>();

  static const routeName = '/initilize';

  const Initilizer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ListenableProvider<NavigationProvider>(
          create: (_) => NavigationProvider(),
        ),
      ],
      child: Builder(
        builder: (context) {
          return _launchNavigator(context);
        },
      ),
    );
  }

  Widget _launchNavigator(BuildContext context) {
    final navigationProvider = context.watch<NavigationProvider>();

    int _buttonIndex = navigationProvider.screenIndex;

    switch (_buttonIndex) {
      case 0:
        _navigationKey.currentState?.pushReplacementNamed(MainScreen.routeName);

        break;
      case 1:
        _navigationKey.currentState?.pushReplacementNamed(Category.routeName);

        break;
      case 2:
        _navigationKey.currentState?.pushReplacementNamed(Records.routeName);

        break;
      case 3:
        _navigationKey.currentState?.pushReplacementNamed(Audio.routeName);

        break;
      case 4:
        _navigationKey.currentState?.pushReplacementNamed(Profile.routeName);

        break;
      case 5:
        _navigationKey.currentState
            ?.pushReplacementNamed(SearchScreen.routeName);

        break;
      case 6:
        _navigationKey.currentState
            ?.pushReplacementNamed(DeleteScreen.routeName);
        break;
      default:
        _navigationKey.currentState?.pushReplacementNamed(MainScreen.routeName);
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
          key: _navigationKey,
          initialRoute: MainScreen.routeName,
          onGenerateRoute: RouteGenerator.generateRoute,
        ));
  }
}
