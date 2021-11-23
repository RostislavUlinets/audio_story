import 'package:audio_story/Colors/colors.dart';
import 'package:audio_story/provider/navigation_provider.dart';
import 'package:audio_story/screens/main_screen/main_screen.dart';
import 'package:audio_story/widgets/custom_paint.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FinalScreen extends StatelessWidget {
  static const routeName = '/splash';

  final int duration;

  const FinalScreen({Key? key, required this.duration}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    NavigationController navigation =
        Provider.of<NavigationController>(context, listen: false);

    Future.delayed(Duration(seconds: duration), () {
      navigation.changeScreen(MainScreen.routeName);
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
            MyCustomPaint(
              color: CColors.purpule,
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
                const Image(
                  image: AssetImage('assets/Heart.png'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
