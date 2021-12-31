import 'dart:io';

import 'package:audio_story/Colors/colors.dart';
import 'package:audio_story/provider/navigation_provider.dart';
import 'package:audio_story/repositories/database.dart';
import 'package:audio_story/screens/audio/audio.dart';
import 'package:audio_story/widgets/bottomnavbar.dart';
import 'package:audio_story/widgets/custom_paint.dart';
import 'package:audio_story/widgets/side_menu.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:uuid/uuid.dart';

import 'widget/dialog.dart';
import 'widget/test.dart';

class Player extends StatefulWidget {
  static const routeName = '/player';

  const Player({Key? key}) : super(key: key);

  @override
  State<Player> createState() => _PlayerState();
}

class _PlayerState extends State<Player> {
  TextEditingController audioName =
      TextEditingController(text: 'Аудиозапись 1');
  final pathToSaveTemp = '/sdcard/Download/temp.aac';
  final pathToSaveAudio = '/sdcard/Download/audio.mp3';

  Future<void> saveAudio() async {
    File file = File(pathToSaveAudio);
    String uid = FirebaseAuth.instance.currentUser!.uid;
    DatabaseService dataBase = DatabaseService(uid);
    final destination = 'Sounds/$uid/${audioName.text}_${DateTime.now()}.mp3';
    dataBase.uploadFile(destination, file)?.whenComplete(
          () => dataBase.addAudio(destination, audioName.text),
        );
  }

  @override
  Widget build(BuildContext context) {
    NavigationController navigation =
        Provider.of<NavigationController>(context);

    return Stack(
      children: [
        const MyCustomPaint(
          color: CColors.purpule,
          size: 0.85,
        ),
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 10),
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
                      children: [
                        IconButton(
                          icon: const Image(
                            image: AssetImage("assets/Upload.png"),
                          ),
                          onPressed: () {
                            Share.shareFiles([pathToSaveAudio]);
                          },
                        ),
                        IconButton(
                          onPressed: () async {
                            await FlutterSoundHelper().convertFile(
                                pathToSaveTemp,
                                Codec.aacADTS,
                                '/storage/sdcard0/Downloads/${audioName.text}',
                                Codec.mp3);
                          },
                          icon: const Image(
                            image: AssetImage("assets/PaperDownload1.png"),
                          ),
                        ),
                        IconButton(
                          icon: const Image(
                            image: AssetImage("assets/Delete.png"),
                          ),
                          onPressed: () {
                            showAlertDialog(context);
                          },
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        TextButton(
                          onPressed: () {
                            saveAudio();
                            navigation.changeScreen(Audio.routeName);
                          },
                          child: const Text("Сохранить"),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0),
                    child: TextField(
                      textAlign: TextAlign.center,
                      controller: audioName,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
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
    );
  }
}
