import 'dart:convert';
import 'package:audio_story/models/audio.dart';
import 'package:audio_story/models/sounds.dart';
import 'package:audio_story/provider/current_audio_provider.dart';
import 'package:audio_story/repositories/database.dart';
import 'package:audio_story/resources/app_colors.dart';
import 'package:audio_story/resources/app_icons.dart';
import 'package:audio_story/screens/audio_card/add_to_category.dart';
import 'package:audio_story/screens/category/category.dart';
import 'package:audio_story/screens/main_screen/main_screen.dart';
import 'package:audio_story/widgets/audio_content.dart';
import 'package:audio_story/widgets/custom_paint.dart';
import 'package:audio_story/widgets/player.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:share/share.dart';

final user = FirebaseAuth.instance.currentUser;
DatabaseService dataBase =
    DatabaseService(FirebaseAuth.instance.currentUser!.uid);
final CollectionReference userCollection =
    FirebaseFirestore.instance.collection('users');

bool selectFlag = true;
late List<int> eraseList;

Image imageFromBase64String(String base64String) {
  return Image.memory(base64Decode(base64String));
}

class SelectModeList extends StatefulWidget {
  final int index;
  final SoundModel audioPropeperty;

  const SelectModeList(
      {Key? key, required this.audioPropeperty, required this.index})
      : super(key: key);

  @override
  State<SelectModeList> createState() => _SelectModeListState();
}

class _SelectModeListState extends State<SelectModeList> {
  late SoundModel audioPropeperty;
  late final int index;
  List<AudioModel> playList = [];
  List<AudioModel> audio = [];
  List<bool> select = [];

  @override
  void initState() {
    index = widget.index;
    audioPropeperty = widget.audioPropeperty;
    audio = audioPropeperty.sounds;
    select = List.filled(50, false);
    super.initState();
  }

  bool playAll = false;

  @override
  Widget build(BuildContext context) {
    final audioProvider = context.watch<CurrentAudio>();
    return Scaffold(
      extendBody: true,
      body: Stack(
        children: [
          const MyCustomPaint(
            color: AppColors.green,
            size: 0.85,
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 60.0),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          color: Colors.white,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Image(image: AppIcons.arrowLeftInCircle),
                          ),
                        ),
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
                            child: const Text("Отменить выбор"),
                            onTap: () {
                              Navigator.pop(context);
                            },
                            value: 1,
                          ),
                          PopupMenuItem(
                            child: const Text("Добавить в подборку"),
                            onTap: () {
                              Future.delayed(
                                const Duration(seconds: 0),
                                () => Navigator.pushNamed(
                                  context,
                                  CustomCategory.routeName,
                                  arguments: playList,
                                ),
                              );
                            },
                            value: 2,
                          ),
                          PopupMenuItem(
                            child: const Text("Поделиться"),
                            onTap: () {
                              dataBase
                                  .downloadAllAudio(playList)
                                  .then((value) => Share.shareFiles(value));
                            },
                            value: 3,
                          ),
                          PopupMenuItem(
                            child: const Text("Скачать все"),
                            onTap: () {
                              dataBase.downloadAllAudio(playList);
                            },
                            value: 4,
                          ),
                          PopupMenuItem(
                            child: const Text("Удалить все"),
                            onTap: () {
                              dataBase.deleteSounds(index, playList);
                              Future.delayed(
                                const Duration(seconds: 0),
                                () => Navigator.pushNamed(
                                  context,
                                  Category.routeName,
                                ),
                              );
                            },
                            value: 4,
                          ),
                        ],
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: Text(
                      audioPropeperty.name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                      ),
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      alignment: Alignment.bottomLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              child: Text(
                                "${audioPropeperty.sounds.length} аудио\n1:30 часа",
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: Colors.white,
                                ),
                              ),
                              width: 70,
                            ),
                            const AudioButton(),
                          ],
                        ),
                      ),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: audioPropeperty.image.image,
                          fit: BoxFit.cover,
                        ),
                        color: Colors.black,
                      ),
                      height: 210,
                      width: double.infinity,
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
                                    playList.add(audio[index]);
                                    setState(() {
                                      select;
                                    });
                                  } else {
                                    select[index] = false;
                                    playList.removeWhere(
                                      (element) => element == audio[index].id,
                                    );
                                    setState(() {
                                      select;
                                    });
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
          ),
        ],
      ),
    );
  }
}
