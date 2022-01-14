import 'dart:developer';
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

final DatabaseService dataBase =
    DatabaseService(FirebaseAuth.instance.currentUser!.uid);

class ListWidget extends StatefulWidget {
  List<AudioModel> audio;
  bool buttonState;
  bool cycleState;

  ListWidget({
    Key? key,
    required this.audio,
    required this.buttonState,
    required this.cycleState,
  }) : super(key: key);

  @override
  _ListWidgetState createState() => _ListWidgetState();
}

class _ListWidgetState extends State<ListWidget> {
  TextEditingController text = TextEditingController();
  late List<AudioModel> audio;
  bool _onlyRead = false;
  bool buttonState = false;
  bool cycleState = false;

  @override
  initState() {
    super.initState();
    audio = widget.audio;
    buttonState = widget.buttonState;
    cycleState = widget.cycleState;
  }

  @override
  Widget build(BuildContext context) {
    final audioProvider = context.watch<CurrentAudio>();
    return ListView.builder(
      itemCount: audio.length,
      itemBuilder: (_, index) {
        String initialText = audio[index].name;
        TextEditingController _editingController =
            TextEditingController(text: initialText);
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          child: Container(
            child: ListTile(
              title: TextField(
                controller: _editingController,
                readOnly: _onlyRead,
                style: const TextStyle(color: Color(0xFF3A3A55)),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
                onEditingComplete: () {
                  dataBase.changeSoundName(
                    audio[index].id,
                    _editingController.text,
                  );
                  _onlyRead = true;
                  setState(() {});
                },
              ),
              subtitle: const Text(
                "30 минут",
                style: TextStyle(color: Color(0x803A3A55)),
              ),
              leading: SizedBox(
                height: 64,
                width: 64,
                child: IconButton(
                  padding: EdgeInsets.zero,
                  iconSize: 64,
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
                        repeat: buttonState,
                        cycle: cycleState,
                        audioProvider: audioProvider,
                      ),
                    );
                  },
                ),
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
                    onTap: () {
                      setState(() {
                        _onlyRead = !_onlyRead;
                      });
                      log(_onlyRead.toString());
                    },
                    value: 1,
                  ),
                  PopupMenuItem(
                    child: Text("Подробнее об аудиозаписи"),
                    onTap: () {
                      Future.delayed(
                        const Duration(seconds: 0),
                        () => Navigator.pushNamed(
                          context,
                          AudioInfo.routeName,
                          arguments: audio[index],
                        ),
                      );
                    },
                    value: 2,
                  ),
                  PopupMenuItem(
                    child: const Text("Удалить"),
                    //TODO: Question
                    onTap: () => dataBase.deleteAudio(audio[index].id),
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
