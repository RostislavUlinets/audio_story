import 'package:audio_story/Colors/colors.dart';
import 'package:audio_story/repositories/database.dart';
import 'package:audio_story/screens/audio/widget/audio_list.dart';
import 'package:audio_story/service/auth.dart';
import 'package:audio_story/widgets/anon_message.dart';
import 'package:audio_story/widgets/audio_list.dart';
import 'package:audio_story/widgets/bottomnavbar.dart';
import 'package:audio_story/widgets/custom_paint.dart';
import 'package:audio_story/widgets/side_menu.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Audio extends StatefulWidget {
  static const routeName = '/audio';

  const Audio({Key? key}) : super(key: key);

  @override
  State<Audio> createState() => _AudioState();
}

class _AudioState extends State<Audio> {
  Color _color = Colors.white38;
  bool buttonPressed = false;
  bool cycleState = false;

  DatabaseService dataBase =
      DatabaseService(FirebaseAuth.instance.currentUser!.uid);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AuthService.isAnonymous()
        ? const AnonMessage()
        : Scaffold(
            drawer: const SideMenu(),
            extendBody: true,
            bottomNavigationBar: const CustomNavigationBar(3),
            body: Stack(
              children: [
                const MyCustomPaint(
                  color: CColors.blue,
                  size: 0.7,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10.0,
                    vertical: 60.0,
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Builder(
                            builder: (ctx) => IconButton(
                              icon: const Icon(
                                Icons.menu,
                                color: Colors.white,
                                size: 36,
                              ),
                              onPressed: () {
                                Scaffold.of(ctx).openDrawer();
                              },
                            ),
                          ),
                          const Text(
                            "Аудиозаписи",
                            style: TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.more_horiz,
                              color: Colors.white,
                              size: 36,
                            ),
                            onPressed: () {},
                          ),
                        ],
                      ),
                      const Text(
                        "Все в одном месте",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 40,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "20 аудио\n10:30 часов",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                            Stack(
                              children: [
                                Container(
                                  alignment: Alignment.centerRight,
                                  height: 50,
                                  width: 200,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(40),
                                    color: _color,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        buttonPressed = !buttonPressed;
                                        cycleState = false;
                                        buttonPressed
                                            ? _color = Colors.white
                                            : _color = Colors.white38;
                                        setState(() {});
                                      },
                                      child: const Image(
                                        image: AssetImage(
                                            "assets/fluent_arrow.png"),
                                        color: CColors.purpule,
                                      ),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    cycleState = !cycleState;
                                    buttonPressed = false;
                                    setState(() {});
                                  },
                                  child: Container(
                                    height: 50,
                                    width: 160,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(40),
                                      color: Colors.white,
                                    ),
                                    child: Row(
                                      children: [
                                        cycleState == false
                                            ? const Image(
                                                image: AssetImage(
                                                    "assets/Play.png"),
                                                color: CColors.purpule,
                                              )
                                            : const Image(
                                                image: AssetImage(
                                                    "assets/Pause.png"),
                                                color: CColors.purpule,
                                              ),
                                        const Text(
                                          "Запустить все",
                                          style:
                                              TextStyle(color: CColors.purpule),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      FutureBuilder(
                        future: dataBase.audioListDB(),
                        builder: (BuildContext context,
                            AsyncSnapshot<dynamic> snapshot) {
                          switch (snapshot.connectionState) {
                            case ConnectionState.waiting:
                              return const SizedBox(
                                height: 250,
                                width: 250,
                                child: Center(
                                  child: CircularProgressIndicator(
                                    color: CColors.purpule,
                                    strokeWidth: 1.5,
                                  ),
                                ),
                              );
                            default:
                              return Expanded(
                                child: ListWidget(
                                  audio: snapshot.data,
                                  buttonState: buttonPressed,
                                  cycleState: cycleState,
                                ),
                              );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
  }
}
