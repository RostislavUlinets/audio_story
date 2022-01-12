import 'dart:io';
import 'package:audio_story/blocs/repeat_cycle/repeat_bloc.dart';
import 'package:audio_story/models/audio.dart';
import 'package:audio_story/repositories/database.dart';
import 'package:audio_story/screens/audio_card/audo_info.dart';
import 'package:audio_story/service/local_storage.dart';
import 'package:audio_story/widgets/player.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share/share.dart';

class AudioScreenList extends StatefulWidget {
  List<AudioModel> audio;

  AudioScreenList({
    Key? key,
    required this.audio,
  }) : super(key: key);

  @override
  _AudioScreenListState createState() => _AudioScreenListState();
}

class _AudioScreenListState extends State<AudioScreenList> {
  List<AudioModel> audio = [];

  DatabaseService dataBase =
      DatabaseService(FirebaseAuth.instance.currentUser!.uid);

  @override
  initState() {
    super.initState();
    audio = widget.audio;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ButtonBloc, ButtonState>(
      buildWhen: (prev, state) => prev.runtimeType != state.runtimeType,
      builder: (context, state) {
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
                  leading: SizedBox(
                    height: 64,
                    width: 64,
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      iconSize: 64,
                      icon: const Image(
                        image: AssetImage("assets/Play.png"),
                      ),
                      onPressed: () {
                        Scaffold.of(context).showBottomSheet(
                          (context) => PlayerOnProgress(
                            soundsList: audio,
                            index: index,
                            repeat: (state is ButtonCycleState),
                            cycle: (state is ButtonPlayAllState),
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
                                url: audio[index].url,
                                name: audio[index].name,
                                id: audio[index].id,
                              ),
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
      },
    );
  }
}
