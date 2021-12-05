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

Future<void> getSaveList() async {
  DocumentSnapshot ds =
      await userCollection.doc(FirebaseAuth.instance.currentUser!.uid).get();
  sounds = ds.get('SaveList');
  name = sounds[0]['Name'];
  info = sounds[0]['Info'];
  url = sounds[0]['Sounds'][0]['URL'];
  audioName = sounds[0]['Sounds'][0]['Name'];
}

class CardInfo extends StatefulWidget {
  static const routeName = '/audio';

  const CardInfo({Key? key}) : super(key: key);

  @override
  State<CardInfo> createState() => _CardInfoState();
}

class _CardInfoState extends State<CardInfo> {
  @override
  void initState() {
    getSaveList().then((value) => setState(() {}));
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
                        onPressed: () {
                        },
                      ),
                    ],
                  ),
                  const Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: Text(
                      "Сказка о малыше Кокки",
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
                        image: DecorationImage(
                          image: const AssetImage(
                            "assets/story.jpg",
                          ),
                          colorFilter: ColorFilter.mode(
                              Colors.black.withOpacity(0.7), BlendMode.dstATop),
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

class CustomList extends StatelessWidget {
  const CustomList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  children: const [
                    Text("Аудиозаписи", style: TextStyle(fontSize: 24)),
                    Spacer(),
                    Text("Открыть все", style: TextStyle(fontSize: 16)),
                  ],
                ),
              ),
              Expanded(child: ListWidget()),
            ],
          ),
        ),
        decoration: BoxDecoration(
          color: const Color(0xFFF6F6F6),
          border: Border.all(
            color: Colors.grey,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 10,
              blurRadius: 10,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        height: 400,
      ),
    );
  }
}

ListView _buildListView() {
  return ListView.builder(
    itemCount: 10,
    itemBuilder: (_, index) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0),
        child: Container(
          child:  ListTile(
            title: Text(
              "Малышь Кокки 1",
              style: TextStyle(color: Color(0xFF3A3A55)),
            ),
            subtitle: Text(
              "30 минут",
              style: TextStyle(color: Color(0x803A3A55)),
            ),
            leading: Image(
              image: AssetImage("assets/Play.png",),
              color: CColors.green,
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

class ListWidget extends StatefulWidget {
  ListWidget({Key? key}) : super(key: key);

  @override
  _ListWidgetState createState() => _ListWidgetState();
}

class _ListWidgetState extends State<ListWidget> {
  @override
  void initState() {
    getSaveList();
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
