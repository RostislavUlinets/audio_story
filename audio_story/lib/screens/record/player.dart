import 'dart:io';
import 'package:audio_story/provider/navigation_provider.dart';
import 'package:audio_story/repositories/database.dart';
import 'package:audio_story/resources/app_colors.dart';
import 'package:audio_story/resources/app_icons.dart';
import 'package:audio_story/screens/audio/audio.dart';
import 'package:audio_story/widgets/custom_paint.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:provider/src/provider.dart';
import 'package:share/share.dart';

import 'widget/dialog.dart';
import 'widget/test.dart';

class Player extends StatefulWidget {
  static const routeName = '/player';

  const Player({Key? key}) : super(key: key);

  @override
  State<Player> createState() => _PlayerState();
}

class _PlayerState extends State<Player> {
  FlutterSoundHelper helper = FlutterSoundHelper();

  TextEditingController audioName =
      TextEditingController(text: 'Аудиозапись 1');
  final pathToSaveTemp = '/sdcard/Download/temp.aac';
  final pathToSaveAudio = '/sdcard/Download/audio.mp3';

  Future<void> saveAudio() async {
    if (FirebaseAuth.instance.currentUser!.isAnonymous) {
      await helper.convertFile(pathToSaveTemp, Codec.aacADTS,
          '/sdcard/Download/${audioName.text}.mp3', Codec.mp3);
    } else {
      File file = File(pathToSaveAudio);
      String uid = FirebaseAuth.instance.currentUser!.uid;
      DatabaseService dataBase = DatabaseService(uid);
      final destination = 'Sounds/$uid/${audioName.text}_${DateTime.now()}.mp3';
      dataBase.uploadFile(destination, file)?.whenComplete(() {
        dataBase.addAudio(destination, audioName.text);
      });
    }
    Future.delayed(const Duration(seconds: 3), () {
      File(pathToSaveTemp).delete();
      File(pathToSaveAudio).delete();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const MyCustomPaint(
          color: AppColors.purpule,
          size: 0.85,
        ),
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.menu,
                      color: Colors.white,
                      size: 36,
                    ),
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
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
                          icon: Image(
                            image: AppIcons.upload,
                          ),
                          onPressed: () {
                            Share.shareFiles([pathToSaveAudio]);
                          },
                        ),
                        IconButton(
                          onPressed: () async {
                            await helper.convertFile(
                              pathToSaveTemp,
                              Codec.aacADTS,
                              '/sdcard/Download/${audioName.text}.mp3',
                              Codec.mp3,
                            );
                          },
                          icon: Image(
                            image: AppIcons.paperDownload,
                          ),
                        ),
                        IconButton(
                          icon: Image(
                            image: AppIcons.delete,
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
                            final navigator =
                                context.read<NavigationProvider>();
                            saveAudio().then((value) {
                              Future.delayed(Duration(seconds: 1), () {
                                navigator.changeScreen(3);
                              });
                            });
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
