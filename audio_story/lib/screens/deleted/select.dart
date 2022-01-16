import 'package:audio_story/models/audio.dart';
import 'package:audio_story/provider/current_audio_provider.dart';
import 'package:audio_story/repositories/database.dart';
import 'package:audio_story/resources/app_colors.dart';
import 'package:audio_story/resources/app_icons.dart';
import 'package:audio_story/widgets/custom_paint.dart';
import 'package:audio_story/widgets/player.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

class SelectMode extends StatefulWidget {
  static const String routeName = '/selectDeleted';

  const SelectMode({Key? key}) : super(key: key);

  @override
  _SelectModeState createState() => _SelectModeState();
}

class _SelectModeState extends State<SelectMode> {
  final DatabaseService dataBase =
      DatabaseService(FirebaseAuth.instance.currentUser!.uid);
  List<bool> select = [];
  List<String> playList = [];
  List<AudioModel> audio = [];

  @override
  void initState() {
    super.initState();
    dataBase.getDeletedAudio().then((value) {
      audio = value;
      select = List.filled(audio.length, false);
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final audioProvider = context.watch<CurrentAudio>();
    return Scaffold(
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
          child: BottomNavigationBar(
            selectedItemColor: Colors.black,
            unselectedItemColor: Colors.black,
            onTap: (buttonIndex) {
              switch (buttonIndex) {
                case 0:
                  dataBase.recoverAudio(playList).then(
                        (value) => setState(() {}),
                      );
                  Navigator.pop(context);
                  break;
                case 1:
                  dataBase.fullDeleteAudio(playList).then(
                        (value) => setState(() {}),
                      );
                  Navigator.pop(context);
                  break;
              }
            },
            items: [
              BottomNavigationBarItem(
                icon: Image(
                  image: AppIcons.swap,
                ),
                label: 'Восстановить все',
              ),
              BottomNavigationBarItem(
                icon: Image(
                  image: AppIcons.delete,
                ),
                label: 'Удалить все',
              ),
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          const MyCustomPaint(
            color: AppColors.blue,
            size: 0.7,
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 60.0),
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 20, bottom: 20),
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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text(
                          'Отменить',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: audio.length,
                    itemBuilder: (_, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: Container(
                          child: ListTile(
                            title: Text(
                              audio[index].name,
                              style:
                                  const TextStyle(color: Color(0xFF3A3A55)),
                            ),
                            subtitle: const Text(
                              "30 минут",
                              style: TextStyle(color: Color(0x803A3A55)),
                            ),
                            leading: IconButton(
                              icon:
                                  audioProvider.audioName == audio[index].name
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
                            trailing: GestureDetector(
                              onTap: () {
                                if (select[index] == false) {
                                  select[index] = true;
                                  playList.add(audio[index].id);
                                  setState(() {});
                                } else {
                                  select[index] = false;
                                  playList.removeWhere(
                                    (element) => element == audio[index].id,
                                  );
                                  setState(() {});
                                }
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    border: Border.all(
                                        width: 2, color: Colors.black)),
                                child: Image(
                                  image: AppIcons.complite,
                                  color: select[index]
                                      ? Colors.black
                                      : Colors.white,
                                ),
                              ),
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
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
