import 'dart:convert';

import 'package:audio_story/Colors/colors.dart';
import 'package:audio_story/models/sounds.dart';
import 'package:audio_story/repositories/database.dart';
import 'package:audio_story/widgets/bottomnavbar.dart';
import 'package:audio_story/widgets/custom_paint.dart';
import 'package:audio_story/widgets/side_menu.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';

import 'widget/delete_audio.dart';
import 'widget/player.dart';

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

class CardInfo extends StatefulWidget {
  static const routeName = '/audio';
  final int index;

  const CardInfo({Key? key, required this.index}) : super(key: key);

  @override
  State<CardInfo> createState() => _CardInfoState(index);
}

class _CardInfoState extends State<CardInfo> {
  final int index;

  _CardInfoState(this.index);

  @override
  void initState() {
    dataBase.getSaveList(index).then((value) => setState(() {
          audioPropeperty = value;
        }));
    eraseList = [];
    selectFlag = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      drawer: const SideMenu(),
      bottomNavigationBar: const CustomNavigationBar(1),
      body: Stack(
        children: [
          const MyCustomPaint(
            color: CColors.green,
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
                            icon: Image.asset('assets/ArrowBack.png'),
                          ),
                        ),
                      ),
                      selectFlag
                          ? PopupMenuButton(
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
                                const PopupMenuItem(
                                  child: Text("Редактировать"),
                                  value: 1,
                                ),
                                PopupMenuItem(
                                  child: const Text("Выбрать несколько"),
                                  onTap: () {
                                    selectFlag = false;
                                    setState(() {});
                                  },
                                  value: 2,
                                ),
                                PopupMenuItem(
                                  child: const Text("Удалить подборку"),
                                  onTap: () {
                                    DeleteAudio.deletePlayList(context, index);
                                  },
                                  value: 3,
                                ),
                                const PopupMenuItem(
                                  child: Text("Поделиться"),
                                  value: 4,
                                ),
                              ],
                            )
                          : PopupMenuButton(
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
                                    selectFlag = true;
                                    setState(() {});
                                  },
                                  value: 1,
                                ),
                                const PopupMenuItem(
                                  child: Text("Добавить в подборку"),
                                  value: 2,
                                ),
                                PopupMenuItem(
                                  child: const Text("Поделиться"),
                                  onTap: () {
                                    Share.shareFiles(
                                        ['/sdcard/Download/audio.mp3']);
                                  },
                                  value: 3,
                                ),
                                const PopupMenuItem(
                                  child: Text("Скачать все"),
                                  value: 4,
                                ),
                                //TODO: CHECK SOLUTION
                                PopupMenuItem(
                                  child: const Text("Удалить все"),
                                  onTap: () => dataBase
                                      .deleteSounds(index, eraseList)
                                      .then(
                                        (value) => Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder:
                                                    (BuildContext context) =>
                                                        super.widget)),
                                      ),
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
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: const [
                            SizedBox(
                              child: Text(
                                "n аудио\n1:30 часа",
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.white,
                                ),
                              ),
                              width: 70,
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
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: Text(audioPropeperty.info),
                  ),
                  const Expanded(
                    child: ListWidget(),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ListWidget extends StatefulWidget {
  const ListWidget({Key? key}) : super(key: key);

  @override
  _ListWidgetState createState() => _ListWidgetState();
}

class _ListWidgetState extends State<ListWidget> {
  @override
  void initState() {
    super.initState();
    setState(() {});
  }

//TODO: FIX NAVIGATION.POP
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: audioPropeperty.audioList.isNotEmpty
          ? audioPropeperty.audioList.length
          : 0,
      itemBuilder: (_, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          child: Container(
            child: ListTile(
              title: Text(
                audioPropeperty.audioList[index]['Name'],
                style: const TextStyle(color: Color(0xFF3A3A55)),
              ),
              subtitle: const Text(
                "30 минут",
                style: TextStyle(color: Color(0x803A3A55)),
              ),
              leading: IconButton(
                iconSize: 32,
                icon: const Image(
                  image: AssetImage("assets/Play.png"),
                  color: CColors.green,
                ),
                onPressed: () {
                  Scaffold.of(context)
                      .showBottomSheet((context) => PlayerOnProgress(
                            url: audioPropeperty.audioList[index]['URL'],
                            name: audioPropeperty.audioList[index]['Name'],
                          ));
                },
              ),
              trailing: selectFlag
                  ? const Icon(Icons.more_horiz)
                  : IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: () => eraseList.add(index),
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
