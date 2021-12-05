import 'dart:developer';
import 'dart:ffi';

import 'package:audio_story/repositories/database.dart';
import 'package:audio_story/screens/category/card_info.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PlayList extends StatefulWidget {
  PlayList({Key? key}) : super(key: key);

  @override
  _PlayListState createState() => _PlayListState();
}

class _PlayListState extends State<PlayList> {
  final user = FirebaseAuth.instance.currentUser;
  DatabaseService dataBase =
      DatabaseService(FirebaseAuth.instance.currentUser!.uid);
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  var sounds = [];
  String name = '';

  Future<void> getSaveList() async {
    DocumentSnapshot ds =
        await userCollection.doc(FirebaseAuth.instance.currentUser!.uid).get();
    sounds = ds.get('SaveList');
    name = sounds[0]['Name'];
    setState(() {});
  }

  @override
  void initState() {
    getSaveList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 2,
      itemBuilder: (_, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CardInfo()),
                      );
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        alignment: Alignment.bottomRight,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              SizedBox(
                                child: Text(
                                  name,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                    height: 1,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                width: 90,
                              ),
                              Spacer(),
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
                                Colors.black.withOpacity(0.8),
                                BlendMode.dstATop),
                            fit: BoxFit.cover,
                          ),
                          color: Colors.black,
                        ),
                        height: 210,
                        width: 180,
                      ),
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: const [
                            SizedBox(
                              child: Text(
                                "Сказка \nо малыше Кокки",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                  height: 1,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              width: 90,
                            ),
                            Spacer(),
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
                            "assets/seconStory.jpg",
                          ),
                          colorFilter: ColorFilter.mode(
                              Colors.black.withOpacity(0.8), BlendMode.dstATop),
                          fit: BoxFit.cover,
                        ),
                        color: Colors.black,
                      ),
                      height: 210,
                      width: 180,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

ListView buildListView() {
  return ListView.builder(
    itemCount: 10,
    itemBuilder: (_, index) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: const [
                          SizedBox(
                            child: Text(
                              "Сказка \nо малыше Кокки",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                                height: 1,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            width: 90,
                          ),
                          Spacer(),
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
                            Colors.black.withOpacity(0.8), BlendMode.dstATop),
                        fit: BoxFit.cover,
                      ),
                      color: Colors.black,
                    ),
                    height: 210,
                    width: 180,
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: const [
                          SizedBox(
                            child: Text(
                              "Сказка \nо малыше Кокки",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                                height: 1,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            width: 90,
                          ),
                          Spacer(),
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
                          "assets/seconStory.jpg",
                        ),
                        colorFilter: ColorFilter.mode(
                            Colors.black.withOpacity(0.8), BlendMode.dstATop),
                        fit: BoxFit.cover,
                      ),
                      color: Colors.black,
                    ),
                    height: 210,
                    width: 180,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}
