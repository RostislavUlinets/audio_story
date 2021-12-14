import 'dart:convert';

import 'package:audio_story/Colors/colors.dart';
import 'package:audio_story/provider/navigation_provider.dart';
import 'package:audio_story/repositories/database.dart';
import 'package:audio_story/screens/category/widget/player.dart';
import 'package:audio_story/widgets/bottomnavbar.dart';
import 'package:audio_story/widgets/custom_paint.dart';
import 'package:audio_story/widgets/side_menu.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

final user = FirebaseAuth.instance.currentUser;
DatabaseService dataBase =
    DatabaseService(FirebaseAuth.instance.currentUser!.uid);
final CollectionReference userCollection =
    FirebaseFirestore.instance.collection('users');

bool selectFlag = true;

var sounds = [];
var audioList = [];
String name = '';
String url = '';
String audioName = '';
String info = '';
Image? image;

Future<void> getSaveList(int index) async {
  DocumentSnapshot ds =
      await userCollection.doc(FirebaseAuth.instance.currentUser!.uid).get();
  sounds = ds.get('SaveList');
  name = sounds[index]['Name'];
  info = sounds[index]['Info'];
  url = sounds[index]['Sounds'][0]['URL'];
  audioName = sounds[index]['Sounds'][0]['Name'];
  audioList = sounds[index]['Sounds'];
  String bytes = sounds[index]['Image'];
  image = imageFromBase64String(bytes);
}

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
    getSaveList(index).then((value) => setState(() {}));
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
          const MyCustomPaint(color: CColors.green),
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
                                PopupMenuItem(
                                  child: const Text("Редактировать"),
                                  onTap: () {
                                    selectFlag = false;
                                    setState(() {});
                                  },
                                  value: 1,
                                ),
                                const PopupMenuItem(
                                  child: Text("Выбрать несколько"),
                                  value: 2,
                                ),
                                PopupMenuItem(
                                  child: const Text("Удалить подборку"),
                                  onTap: () {
                                    _deletePlayList(context, index);
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
                                  onTap: () {},
                                  value: 3,
                                ),
                                const PopupMenuItem(
                                  child: Text("Скачать все"),
                                  value: 4,
                                ),
                                const PopupMenuItem(
                                  child: Text("Удалить все"),
                                  value: 4,
                                ),
                              ],
                            ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: Text(
                      name,
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
                        image: image != null
                            ? DecorationImage(
                                image: image!.image,
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
                    child: Text(info),
                  ),
                  Expanded(
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
  ListWidget({Key? key}) : super(key: key);

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
      itemCount: audioList.isNotEmpty ? audioList.length : 0,
      itemBuilder: (_, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          child: Container(
            child: ListTile(
              title: Text(
                audioList[index]['Name'],
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
                            url: audioList[index]['URL'],
                            name: audioList[index]['Name'],
                          ));
                },
              ),
              trailing: selectFlag
                  ? const Icon(Icons.more_horiz)
                  : IconButton(
                      icon: Icon(Icons.add), 
                      onPressed: () { 
                        dataBase.deleteSounds(index,[0,1,2]);
                       },
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

void _deletePlayList(BuildContext context, int index) {
  // set up the buttons
  Widget cancelButton = TextButton(
    child: const Text(
      "Нет",
      style: TextStyle(color: CColors.purpule),
    ),
    style: ButtonStyle(
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
          side: const BorderSide(color: CColors.purpule),
        ),
      ),
    ),
    onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
  );

  Widget continueButton = TextButton(
    child: const Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      child: Text(
        "Удалить",
        style: TextStyle(color: Colors.white),
      ),
    ),
    style: ButtonStyle(
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
        ),
      ),
      backgroundColor: MaterialStateProperty.all(CColors.purpule),
    ),
    onPressed: () {
      dataBase.deletePlayList(index).then(
            (value) => Navigator.pop(context),
          );
    },
  );

  // set up the AlertDialog
  Widget alert = AlertDialog(
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20.0))),
    content: SizedBox(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: Text("Подтверждаете удаление?",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: CColors.red)),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                "Ваш файл перенесется в папку “Недавно удаленные”.\nЧерез 15 дней он исчезнет.",
                style: TextStyle(
                    fontSize: 14, color: CColors.black.withOpacity(0.5)),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35.0),
              child: Row(
                children: [
                  continueButton,
                  const Spacer(),
                  cancelButton,
                ],
              ),
            ),
          ],
        ),
      ),
      height: 180,
      width: 350,
    ),
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
