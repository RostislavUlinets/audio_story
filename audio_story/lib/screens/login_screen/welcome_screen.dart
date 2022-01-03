import 'package:audio_story/Colors/colors.dart';
import 'package:audio_story/provider/navigation_provider.dart';
import 'package:audio_story/screens/login_screen/final_screen.dart';
import 'package:audio_story/screens/login_screen/login_screen_phone.dart';
import 'package:audio_story/widgets/custom_paint.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WelcomeScreen extends StatelessWidget {
  static const routeName = '/welcome';

  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const MyCustomPaint(
            color: CColors.purpule,
            size: 0.85,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: Padding(
              padding: const EdgeInsets.only(top: 150),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text(
                    "MemoryBox",
                    style: TextStyle(
                        fontSize: 48.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  const Text(
                    "Твой голос всегда рядом!",
                    style: TextStyle(fontSize: 14.0, color: Colors.white),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 150),
                    child: Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(bottom: 40),
                          child: Text(
                            "Привет!",
                            style: TextStyle(
                                fontSize: 24.0, fontWeight: FontWeight.bold),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(bottom: 40),
                          child: Text(
                            "Мы рады видеть тебя здесь.\nЭто приложение поможет записывать сказки и держать их в удобном месте не заполняя память на телефоне",
                            textAlign: TextAlign.center,
                          ),
                        ),
                        ElevatedButton(
                          child: const Text("Продолжить"),
                          onPressed: () {
                            if (FirebaseAuth.instance.currentUser?.uid ==
                                null) {
                              Navigator.pushNamed(context, LoginScreen.routeName);
                            } else {
                              Navigator.pushNamed(context, FinalScreen.routeName);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(double.infinity, 50),
                            primary: Colors.deepOrange[200],
                            onPrimary: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(32.0),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
