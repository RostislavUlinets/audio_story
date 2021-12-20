import 'package:audio_story/Colors/colors.dart';
import 'package:audio_story/provider/navigation_provider.dart';
import 'package:audio_story/screens/main_screen/main_screen.dart';
import 'package:audio_story/screens/record/widget/test.dart';
import 'package:audio_story/widgets/bottomnavbar.dart';
import 'package:audio_story/widgets/custom_paint.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AudioInfo extends StatelessWidget {
  static const routeName = '/audioInfo';

  const AudioInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: const CustomNavigationBar(2),
      body: Stack(
        children: [
          const MyCustomPaint(
            color: CColors.purpule,
            size: 0.7,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            onPressed: () {
                              NavigationController navigation =
                                  Provider.of<NavigationController>(context,
                                      listen: false);
                              navigation.changeScreen(MainScreen.routeName);
                            },
                            icon: Image.asset('assets/Arrow - Left Circle.png'),
                          ),
                          PopupMenuButton(
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(20.0),
                              ),
                            ),
                            icon: const Icon(
                              Icons.more_horiz,
                              size: 32,
                              color: Colors.black54,
                            ),
                            itemBuilder: (context) => [
                              PopupMenuItem(
                                child: const Text("Удалить"),
                                //TODO: Question
                                onTap: () {},
                                value: 1,
                              ),
                              const PopupMenuItem(
                                child: Text("Подробнее об аудиозаписи"),
                                value: 2,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: SizedBox(
                        child: Image.asset(
                          'assets/story.jpg',
                          fit: BoxFit.fill,
                        ),
                        height: 300,
                        width: 300,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        "Название подборки",
                        style: TextStyle(fontSize: 24),
                      ),
                    ),
                    const PlayerOnProgress(),
                  ],
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
