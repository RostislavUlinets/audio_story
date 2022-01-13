import 'package:audio_story/provider/current_audio_provider.dart';
import 'package:audio_story/provider/navigation_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'routes/route.dart';
import 'screens/login_screen/welcome_screen.dart';

import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    MultiProvider(
      providers: [
        ListenableProvider<NavigationProvider>(
          create: (_) => NavigationProvider(),
        ),
        ListenableProvider<CurrentAudio>(
          create: (_) => CurrentAudio(),
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
