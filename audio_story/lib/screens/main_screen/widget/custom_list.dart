import 'package:audio_story/Colors/colors.dart';
import 'package:audio_story/repositories/database.dart';
import 'package:audio_story/screens/audio/audio.dart';
import 'package:audio_story/widgets/audio_list.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CustomList extends StatelessWidget {
  CustomList({Key? key}) : super(key: key);

  DatabaseService dataBase =
      DatabaseService(FirebaseAuth.instance.currentUser!.uid);

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  children: [
                    const Text(
                      "Аудиозаписи",
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.black54,
                      ),
                    ),
                    const Spacer(),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, Audio.routeName);
                      },
                      child: const Text(
                        "Открыть все",
                        style: TextStyle(fontSize: 16, color: Colors.black54),
                      ),
                    ),
                  ],
                ),
              ),
              FutureBuilder(
                future: dataBase.audioListDB(),
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return const CircularProgressIndicator(
                        color: CColors.purpule,
                        strokeWidth: 1.5,
                      );
                    default:
                      return Expanded(child: ListWidget(audio: snapshot.data));
                  }
                },
              ),
            ],
          ),
        ),
        decoration: BoxDecoration(
          color: const Color(0xFFF6F6F6),
          border: Border.all(
            color: Colors.grey,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 10,
              blurRadius: 10,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        height: 350,
      ),
    );
  }
}
