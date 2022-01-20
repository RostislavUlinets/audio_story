import 'package:audio_story/blocs/repeat_cycle/repeat_bloc.dart';
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
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share/share.dart';

class AudioScreenList extends StatefulWidget {
  final List<AudioModel> audio;

  const AudioScreenList({
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

  TextEditingController text = TextEditingController();
  bool _onlyRead = true;
  bool buttonState = false;
  bool cycleState = false;

  @override
  initState() {
    super.initState();
    audio = widget.audio;
  }

  @override
  Widget build(BuildContext context) {
    final audioProvider = context.watch<CurrentAudio>();
    return BlocBuilder<ButtonBloc, ButtonState>(
      buildWhen: (prev, state) => prev.runtimeType != state.runtimeType,
      builder: (context, state) {
        return ListView.builder(
          itemCount: audio.length,
          itemBuilder: (context, index) {
            TextEditingController _editingController =
                TextEditingController(text: audio[index].name);
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
                      setState(() {
                        audio[index] = AudioModel(
                          id: audio[index].id,
                          name: _editingController.text,
                          url: audio[index].url,
                        );
                        _onlyRead = true;
                      });
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
                      icon: audioProvider.audioId == audio[index].id
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
                            repeat: (state is ButtonCycleState),
                            cycle: (state is ButtonPlayAllState),
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
                        onTap: () {
                          setState(() {
                            _onlyRead = !_onlyRead;
                          });
                        },
                        value: 1,
                      ),
                      PopupMenuItem(
                        child: const Text("Подробнее об аудиозаписи"),
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
                        onTap: () {
                          dataBase.deleteAudio(audio[index].id);
                          setState(() {
                            audio.removeAt(index);
                          });
                        },
                        value: 3,
                      ),
                      PopupMenuItem(
                        child: const Text("Поделиться"),
                        onTap: () async {
                          dataBase.downloadAllAudio([audio[index]]).then(
                              (value) => Share.shareFiles(value));
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
