import 'package:audio_story/resources/app_colors.dart';
import 'package:audio_story/resources/app_icons.dart';
import 'package:audio_story/route_bar.dart';
import 'package:audio_story/screens/main_screen/main_screen.dart';
import 'package:audio_story/widgets/custom_paint.dart';
import 'package:flutter/material.dart';

class FinalScreen extends StatelessWidget {
  static const routeName = '/splash';

  final int duration;

  const FinalScreen({Key? key, required this.duration}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: duration), () {
      Navigator.of(context).pushNamedAndRemoveUntil(
        Initilizer.routeName,
        (route) => false,
      );
    });

    return Scaffold(
      body: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const MainScreen(),
            ),
          );
        },
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            const MyCustomPaint(
              color: AppColors.purpule,
              size: 0.85,
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 150),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: const [
                      Text(
                        "Регистрация",
                        style: TextStyle(
                          fontSize: 48.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                Material(
                  borderRadius: BorderRadius.circular(15.0),
                  elevation: 5,
                  shadowColor: Colors.grey,
                  child: const Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Text(
                      "Мы рады тебя видеть",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Image(
                  image: AppIcons.heart,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
