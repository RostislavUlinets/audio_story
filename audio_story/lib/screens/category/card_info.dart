import 'dart:convert';
import 'dart:developer';

import 'package:audio_story/Colors/colors.dart';
import 'package:audio_story/repositories/database.dart';
import 'package:audio_story/screens/category/widget/player.dart';
import 'package:audio_story/widgets/bottomnavbar.dart';
import 'package:audio_story/widgets/custom_paint.dart';
import 'package:audio_story/widgets/side_menu.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

final user = FirebaseAuth.instance.currentUser;
DatabaseService dataBase =
    DatabaseService(FirebaseAuth.instance.currentUser!.uid);
final CollectionReference userCollection =
    FirebaseFirestore.instance.collection('users');

var sounds = [];
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
  String bytes = sounds[index]['Image'];
  image = imageFromBase64String(bytes);
}

Image imageFromBase64String(String base64String) {
  return Image.memory(base64Decode(base64String));
}

class CardInfo extends StatefulWidget {
  static const routeName = '/audio';
  final int index;

  const CardInfo({Key? key,required this.index}) : super(key: key);

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
      drawer: const SideMenu(),
      extendBody: true,
      body: Stack(
        children: [
          MyCustomPaint(color: CColors.green),
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
                      IconButton(
                        icon: Icon(
                          Icons.more_horiz,
                          color: Colors.white,
                          size: 36,
                        ),
                        onPressed: () {},
                      ),
                    ],
                  ),
                   Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: Text(
                      name,
                      style: TextStyle(
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
                          children: [
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
                            : DecorationImage(
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
                  SizedBox(
                    width: 350,
                    height: 200,
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
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 1,
      itemBuilder: (_, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          child: Container(
            child: ListTile(
              title: Text(
                name,
                style: TextStyle(color: Color(0xFF3A3A55)),
              ),
              subtitle: Text(
                "30 минут",
                style: TextStyle(color: Color(0x803A3A55)),
              ),
              leading: IconButton(
                iconSize: 32,
                icon: Image(
                  image: AssetImage("assets/Play.png"),
                  color: CColors.green,
                ),
                onPressed: () {
                  Scaffold.of(context)
                      .showBottomSheet((context) => PlayerOnProgress(
                            url: url.toString(),
                            name: audioName.toString(),
                          ));
                },
              ),
              trailing: Icon(Icons.more_horiz),
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
