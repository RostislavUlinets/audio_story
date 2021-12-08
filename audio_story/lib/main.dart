import 'package:audio_story/models/user.dart';
import 'package:audio_story/provider/navigation_provider.dart';
import 'package:audio_story/screens/audio/audio.dart';
import 'package:audio_story/screens/category/category.dart';
import 'package:audio_story/screens/category/create_category.dart';
import 'package:audio_story/screens/login_screen/final_screen.dart';
import 'package:audio_story/screens/profile/profile.dart';
import 'package:audio_story/screens/record/player.dart';
import 'package:audio_story/screens/record/record.dart';
import 'package:audio_story/screens/subscribe/subscribe.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'screens/login_screen/welcome_screen.dart';

import 'package:firebase_core/firebase_core.dart';

import 'package:provider/provider.dart';

import 'screens/main_screen/main_screen.dart';
import 'service/auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ListenableProvider<NavigationController>(
          create: (_) => NavigationController(),
        ),
      ],
      child: const NavApp(),
    ),
  );
}

class NavApp extends StatelessWidget {
  const NavApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, //top bar color
    ));

    NavigationController navigation =
        Provider.of<NavigationController>(context);

    return StreamProvider<CustomUser?>.value(
      updateShouldNotify: (_, __) => true,
      value: AuthService.instance.user,
      initialData: null,
      child: MaterialApp(
        home: Navigator(
          onPopPage: (route, result) {
            if (!route.didPop(result)) return false;
            return true;
          },
          pages: [
            const MaterialPage(child: WelcomeScreen()),
            if (navigation.screenName == FinalScreen.routeName)
              const MaterialPage(child: FinalScreen(duration: 3)),
            if (navigation.screenName == MainScreen.routeName)
              const MaterialPage(child: MainScreen()),
            if (navigation.screenName == Category.routeName)
              const MaterialPage(child: Category()),
            if (navigation.screenName == Audio.routeName)
              const MaterialPage(child: Audio()),
            if (navigation.screenName == Profile.routeName)
              const MaterialPage(child: Profile()),
            if (navigation.screenName == Subscribe.routeName)
              const MaterialPage(child: Subscribe()),
            if (navigation.screenName == Records.routeName)
              const MaterialPage(child: Records()),//records
            if (navigation.screenName == Player.routeName)
              const MaterialPage(child: Player()),
            if (navigation.screenName == CreateCategory.routeName)
              const MaterialPage(child: CreateCategory()),
          ],
        ),
      ),
    );
  }
}
