import 'package:audio_story/Colors/colors.dart';
import 'package:audio_story/widgets/bottomnavbar.dart';
import 'package:audio_story/widgets/custom_paint.dart';
import 'package:audio_story/widgets/side_menu.dart';
import 'package:flutter/material.dart';

class DeeltedScreen extends StatefulWidget {
  static const routeName = '/deleted';
  const DeeltedScreen({Key? key}) : super(key: key);

  @override
  State<DeeltedScreen> createState() => _DeeltedScreenState();
}

class _DeeltedScreenState extends State<DeeltedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 60.0),
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
                      "Недавно удаленные",
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
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
                          child: const Text("Выбрать несколько"),
                          //TODO: Question
                          onTap: () {
 
                          },
                          value: 1,
                        ),
                        PopupMenuItem(
                          child: Text("Удалить все"),
                          onTap: () {
                          },
                          value: 2,
                        ),
                        PopupMenuItem(
                          child: Text("Восстановить все"),
                          onTap: () {
                          },
                          value: 2,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
