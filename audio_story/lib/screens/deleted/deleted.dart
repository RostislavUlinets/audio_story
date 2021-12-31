import 'package:audio_story/Colors/colors.dart';
import 'package:audio_story/repositories/database.dart';
import 'package:audio_story/widgets/bottomnavbar.dart';
import 'package:audio_story/widgets/custom_paint.dart';
import 'package:audio_story/widgets/side_menu.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'widget/custom_list.dart';

final DatabaseService dataBase =
    DatabaseService(FirebaseAuth.instance.currentUser!.uid);

class DeeltedScreen extends StatelessWidget {
  const DeeltedScreen({Key? key}) : super(key: key);

  static const routeName = '/deleted';

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
                Padding(
                  padding: const EdgeInsets.only(top: 20,bottom: 100),
                  child: Row(
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
                        "Недавно\nудаленные",
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
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
                          color: Colors.white,
                        ),
                        itemBuilder: (context) => [
                          PopupMenuItem(
                            child: const Text("Выбрать несколько"),
                            //TODO: Question
                            onTap: () {},
                            value: 1,
                          ),
                          PopupMenuItem(
                            child: Text("Удалить все"),
                            onTap: () {},
                            value: 2,
                          ),
                          PopupMenuItem(
                            child: Text("Восстановить все"),
                            onTap: () {},
                            value: 2,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                FutureBuilder(
                  future: dataBase.getDeletedAudio(),
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
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
                            child: ListWidget(audio: snapshot.data));
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
