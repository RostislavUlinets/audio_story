import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'routes/route.dart';
import 'screens/login_screen/welcome_screen.dart';

import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    const MyApp(),
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
