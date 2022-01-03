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

class SelectScreen extends StatefulWidget {
  const SelectScreen({Key? key}) : super(key: key);

  static const routeName = '/deleted';

  @override
  State<SelectScreen> createState() => _DeeltedScreenState();
}

class _DeeltedScreenState extends State<SelectScreen> {
  bool selectMode = false;

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
                const Padding(
                  padding: EdgeInsets.only(top: 20, bottom: 100),
                  child: Text(
                    "Недавно\nудаленные",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
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
                            child: ListWidget(
                          audio: snapshot.data,
                        ));
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
