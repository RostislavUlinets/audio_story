import 'package:audio_story/models/navigation_item.dart';
import 'package:audio_story/provider/navigation_provider.dart';
import 'package:audio_story/screens/profile/profile.dart';
import 'package:audio_story/screens/subscribe/subscribe.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'screens/login_screen/new_user/welcome_screen.dart';

import 'package:firebase_core/firebase_core.dart';

import 'package:provider/provider.dart';

import 'screens/main_screen/main_screen.dart';

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
/*
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, //top bar color
    ));

    return ChangeNotifierProvider(
      create: (context) => NavigationProvider(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MainPage(),
      ),
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) => buildPages();
  Widget buildPages() {
    final provider = Provider.of<NavigationProvider>(context);
    final navigationItem = provider.navigationIteam;

    switch (navigationItem) {
      case NavigationItem.home:
        return MainScreen();
      case NavigationItem.profile:
        return Profile();
      case NavigationItem.subscribe:
        return Subscribe();
      default:
        return WelcomeScreen();
    }
  }
}*/

class NavApp extends StatelessWidget {
  const NavApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    NavigationController navigation = Provider.of<NavigationController>(context);

    return MaterialApp(
      home: Navigator(
        onPopPage: (route, result) {
          if (!route.didPop(result)) return false;
          return true;
        },
        pages: [
          const MaterialPage(child: WelcomeScreen()),
          if(navigation.screenName == '/')
            const MaterialPage(child: MainScreen()),
          if(navigation.screenName == '/profile')
            const MaterialPage(child: Profile()),
          if(navigation.screenName == '/subscribe')
            const MaterialPage(child: Subscribe()),
        ],
      ),
    );
  }
}
