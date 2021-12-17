import 'package:audio_story/Colors/colors.dart';
import 'package:audio_story/widgets/bottomnavbar.dart';
import 'package:audio_story/widgets/custom_paint.dart';
import 'package:audio_story/widgets/side_menu.dart';
import 'package:flutter/material.dart';

import 'widget/test.dart';

class Player extends StatefulWidget {
  static const routeName = '/player';

  const Player({Key? key}) : super(key: key);

  @override
  State<Player> createState() => _PlayerState();
}

class _PlayerState extends State<Player> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      drawer: const SideMenu(),
      bottomNavigationBar: const CustomNavigationBar(2),
      body: Stack(
        children: [
          const MyCustomPaint(
            color: CColors.purpule,
            size: 0.85,
          ),
          Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 50, horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
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
                  ],
                ),
              ),
              Container(
                width: 385,
                height: 580,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Image(
                            image: AssetImage("assets/Upload.png"),
                          ),
                          Image(
                            image: AssetImage("assets/PaperDownload1.png"),
                          ),
                          Image(
                            image: AssetImage("assets/Delete.png"),
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Text("Сохранить"),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    const PlayerOnProgress(),
                  ],
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFF6F6F6),
                  border: Border.all(
                    color: Colors.grey,
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
