import 'dart:io';

import 'package:audio_story/models/audio.dart';
import 'package:audio_story/provider/current_audio_provider.dart';
import 'package:audio_story/repositories/database.dart';
import 'package:audio_story/resources/app_colors.dart';
import 'package:audio_story/resources/app_icons.dart';
import 'package:audio_story/screens/audio_card/audo_info.dart';
import 'package:audio_story/service/local_storage.dart';
import 'package:audio_story/widgets/player.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/src/provider.dart';
import 'package:share/share.dart';

class SearchCustomList extends StatefulWidget {
  List<AudioModel> audio;

  SearchCustomList({Key? key, required this.audio}) : super(key: key);

  @override
  _SearchCustomListState createState() => _SearchCustomListState();
}

class _SearchCustomListState extends State<SearchCustomList> {
  
  DatabaseService dataBase =
      DatabaseService(FirebaseAuth.instance.currentUser!.uid);

  late List<AudioModel> audio;

  @override
  initState() {
    super.initState();
    audio = widget.audio;
  }

  @override
  Widget build(BuildContext context) {
    final audioProvider = context.watch<CurrentAudio>();
    return ListView.builder(
      itemCount: audio.length,
      itemBuilder: (_, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          child: Container(
            child: ListTile(
              title: Text(
                audio[index].name,
                style: const TextStyle(color: Color(0xFF3A3A55)),
              ),
              subtitle: const Text(
                "30 минут",
                style: TextStyle(color: Color(0x803A3A55)),
              ),
              leading: IconButton(
                icon: audioProvider.audioName == audio[index].name
                    ? Image(
                        image: AppIcons.pause,
                        color: AppColors.purpule,
                      )
                    : Image(
                        image: AppIcons.play,
                      ),
                onPressed: () {
                  Scaffold.of(context).showBottomSheet(
                    (context) => PlayerOnProgress(
                      soundsList: audio,
                      index: index,
                      repeat: false,
                      cycle: false,
                      audioProvider: audioProvider,
                    ),
                  );
                },
              ),
              trailing: PopupMenuButton(
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
                    child: const Text("Переименовать"),
                    //TODO: Question
                    onTap: () {},
                    value: 1,
                  ),
                  PopupMenuItem(
                    child: Text("Подробнее об аудиозаписи"),
                    onTap: () {
                      Future.delayed(
                        const Duration(seconds: 0),
                        () => showDialog(
                          context: context,
                          builder: (BuildContext context) => AudioInfo(
                            audio: audio[index],
                          ),
                        ),
                      );
                    },
                    value: 2,
                  ),
                  PopupMenuItem(
                    child: const Text("Удалить"),
                    //TODO: Question
                    onTap: () {
                      dataBase.deleteAudio(audio[index].id);
                      setState(() {
                        audio[index];
                      });
                    },

                    value: 3,
                  ),
                  PopupMenuItem(
                    child: const Text("Поделиться"),
                    //TODO: Question
                    onTap: () async {
                      LocalStorage storage = LocalStorage();
                      Directory dir = await getTemporaryDirectory();
                      final message = await storage
                          .downloadFile(
                            audio[index].url,
                            audio[index].name,
                            dir.path,
                          )
                          .then(
                            (value) => Share.shareFiles([value]),
                          );
                    },
                    value: 4,
                  ),
                ],
              ),
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(75),
              border: Border.all(
                color: Colors.grey,
              ),
            ),
          ),
        );
      },
    );
  }
}
