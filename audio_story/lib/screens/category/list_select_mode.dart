import 'dart:convert';
import 'package:audio_story/models/audio.dart';
import 'package:audio_story/models/sounds.dart';
import 'package:audio_story/repositories/database.dart';
import 'package:audio_story/resources/app_colors.dart';
import 'package:audio_story/resources/app_icons.dart';
import 'package:audio_story/screens/audio_card/add_to_category.dart';
import 'package:audio_story/screens/main_screen/main_screen.dart';
import 'package:audio_story/widgets/bottomnavbar.dart';
import 'package:audio_story/widgets/custom_paint.dart';
import 'package:audio_story/widgets/player.dart';
import 'package:audio_story/widgets/side_menu.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';

final user = FirebaseAuth.instance.currentUser;
DatabaseService dataBase =
    DatabaseService(FirebaseAuth.instance.currentUser!.uid);
final CollectionReference userCollection =
    FirebaseFirestore.instance.collection('users');

bool selectFlag = true;
late List<int> eraseList;

late SoundModel audioPropeperty;

Image imageFromBase64String(String base64String) {
  return Image.memory(base64Decode(base64String));
}

class SelectModeList extends StatefulWidget {
  final int index;

  const SelectModeList({Key? key, required this.index}) : super(key: key);

  @override
  State<SelectModeList> createState() => _SelectModeListState(index);
}

class _SelectModeListState extends State<SelectModeList> {
  final int index;
  List<AudioModel> playList = [];
  List<AudioModel> audio = [];
  List<bool> select = [];

  _SelectModeListState(this.index);

  @override
  void initState() {
    select = List.filled(50, false);
    dataBase.getSaveList(index).then((value) => setState(() {
          audioPropeperty = value;
        }));
    eraseList = [];
    selectFlag = true;
    super.initState();
  }

  bool playAll = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      drawer: const SideMenu(),
      bottomNavigationBar: const CustomNavigationBar(1),
      body: FutureBuilder(
        future: dataBase.getSaveList(index).then(
              (value) => audioPropeperty = value,
            ),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const SizedBox(
                height: 250,
                width: 250,
                child: Center(
                  child: CircularProgressIndicator(
                    color: AppColors.purpule,
                    strokeWidth: 1.5,
                  ),
                ),
              );
            default:
              return Stack(
                children: [
                  const MyCustomPaint(
                    color: AppColors.green,
                    size: 0.85,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 60.0),
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
                                    icon: Image(
                                        image: AppIcons.arrowLeftInCircle),
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
                                    child: Text("Добавить в подборку"),
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
                                      dataBase.downloadAllAudio(playList).then(
                                          (value) => Share.shareFiles(value));
                                    },
                                    value: 3,
                                  ),
                                  PopupMenuItem(
                                    child: Text("Скачать все"),
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
                                          MainScreen.routeName,
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                    GestureDetector(
                                      onTap: () {
                                        playAll = !playAll;
                                        setState(() {});
                                      },
                                      child: Container(
                                        height: 50,
                                        width: 160,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(40),
                                          color: Colors.white.withOpacity(0.6),
                                        ),
                                        child: Row(
                                          children: [
                                            playAll == false
                                                ? Image(
                                                    image: AppIcons.play,
                                                    color: Colors.white,
                                                  )
                                                : Image(
                                                    image: AppIcons.pause,
                                                    color: Colors.white,
                                                  ),
                                            const Text(
                                              "Запустить все",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              decoration: BoxDecoration(
                                image: audioPropeperty.image != null
                                    ? DecorationImage(
                                        image: audioPropeperty.image.image,
                                        fit: BoxFit.cover,
                                      )
                                    : const DecorationImage(
                                        image: AssetImage('assets/story.jpg'),
                                        fit: BoxFit.cover,
                                      ),
                                color: Colors.black,
                              ),
                              height: 210,
                              width: double.infinity,
                            ),
                          ),
                          FutureBuilder(
                            future: dataBase
                                .getPlayListAudio(audioPropeperty.sounds)
                                .then((value) => audio = value),
                            builder: (BuildContext context,
                                AsyncSnapshot<dynamic> snapshot) {
                              switch (snapshot.connectionState) {
                                case ConnectionState.waiting:
                                  return const SizedBox(
                                    height: 250,
                                    width: 250,
                                    child: Center(
                                      child: CircularProgressIndicator(
                                        color: AppColors.purpule,
                                        strokeWidth: 1.5,
                                      ),
                                    ),
                                  );
                                default:
                                  return Expanded(
                                    child: ListView.builder(
                                      itemCount: audio.length,
                                      itemBuilder: (_, index) {
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 5.0),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(75),
                                              border: Border.all(
                                                color: Colors.grey,
                                              ),
                                            ),
                                            child: ListTile(
                                              title: Text(
                                                audio[index].name,
                                                style: const TextStyle(
                                                    color: Color(0xFF3A3A55)),
                                              ),
                                              subtitle: const Text(
                                                "30 минут",
                                                style: TextStyle(
                                                    color: Color(0x803A3A55)),
                                              ),
                                              leading: SizedBox(
                                                height: 64,
                                                width: 64,
                                                child: IconButton(
                                                  padding: EdgeInsets.zero,
                                                  iconSize: 64,
                                                  icon: Image(
                                                    image: AppIcons.play,
                                                  ),
                                                  onPressed: () {
                                                    Scaffold.of(context)
                                                        .showBottomSheet(
                                                      (context) =>
                                                          PlayerOnProgress(
                                                        cycle: false,
                                                        index: index,
                                                        repeat: false,
                                                        soundsList: audio,
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ),
                                              trailing: GestureDetector(
                                                onTap: () {
                                                  if (select[index] == false) {
                                                    setState(() {
                                                      select[index] = true;
                                                      playList
                                                          .add(audio[index]);
                                                    });
                                                  } else {
                                                    setState(() {
                                                      select[index] = false;
                                                      playList.removeWhere(
                                                        (element) =>
                                                            element.id ==
                                                            audio[index].id,
                                                      );
                                                    });
                                                  }
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              100),
                                                      border: Border.all(
                                                          width: 2,
                                                          color: Colors.black)),
                                                  child: Image(
                                                    image: AppIcons.complite,
                                                    color: select[index]
                                                        ? Colors.black
                                                        : Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  );
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
          }
        },
      ),
    );
  }
}
