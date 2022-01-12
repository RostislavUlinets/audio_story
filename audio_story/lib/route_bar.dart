import 'package:audio_story/screens/audio/audio.dart';
import 'package:audio_story/screens/login_screen/welcome_screen.dart';
import 'package:audio_story/screens/main_screen/main_screen.dart';
import 'package:audio_story/widgets/bottomnavbar.dart';
import 'package:audio_story/widgets/side_menu.dart';
import 'package:flutter/material.dart';

import 'routes/route.dart';

class Initilizer extends StatelessWidget {
  static const routeName = '/initilize';

  const Initilizer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
        ));
  }
}
