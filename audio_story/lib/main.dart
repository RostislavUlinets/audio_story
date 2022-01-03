import 'package:audio_story/bloc/record/record_bloc.dart';
import 'package:audio_story/models/user.dart';
import 'package:audio_story/provider/navigation_provider.dart';
import 'package:audio_story/screens/audio/audio.dart';
import 'package:audio_story/screens/category/category.dart';
import 'package:audio_story/screens/category/create_category.dart';
import 'package:audio_story/screens/deleted/deleted.dart';
import 'package:audio_story/screens/login_screen/final_screen.dart';
import 'package:audio_story/screens/profile/profile.dart';
import 'package:audio_story/screens/record/player.dart';
import 'package:audio_story/screens/record/record.dart';
import 'package:audio_story/screens/search/search.dart';
import 'package:audio_story/screens/subscribe/subscribe.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'route.dart';
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
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, //top bar color
    ));
    return const MaterialApp(
      initialRoute: WelcomeScreen.routeName,
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
