import 'dart:convert';

import 'package:audio_story/repositories/database.dart';
import 'package:audio_story/screens/category/card_info.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PlayList extends StatefulWidget {
  const PlayList({Key? key}) : super(key: key);

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
  Image? image;

  Future getSaveList() async {
    DocumentSnapshot ds =
        await userCollection.doc(FirebaseAuth.instance.currentUser!.uid).get();
    try {
      return ds.get('saveList');
    } catch (e) {
      return [];
    }
  }

  Image imageFromBase64String(String base64String) {
    return Image.memory(base64Decode(base64String));
  }

  @override
  void initState() {
    getSaveList().then((value) => setState(() {
          sounds = value;
        }));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      children: List.generate(
        sounds.isNotEmpty ? sounds.length : 0,
        (index) {
          if (sounds.isNotEmpty) {
            name = sounds[index]['name'];
            String bytes = sounds[index]['image'];
            image = imageFromBase64String(bytes);
          }
          return SizedBox(
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    '/cardInfo',
                    arguments: index,
                  );
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 5.0,
                        vertical: 10,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SizedBox(
                            child: Text(
                              name,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                                height: 1,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            width: 90,
                          ),
                          const Spacer(),
                          SizedBox(
                            child: Text(
                              "${sounds[index]['sounds'].length} аудио\n1:30 часа",
                              style: const TextStyle(
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
                              colorFilter: ColorFilter.mode(
                                Colors.black.withOpacity(0.8),
                                BlendMode.dstATop,
                              ),
                            )
                          : DecorationImage(
                              image: const AssetImage('assets/story.jpg'),
                              fit: BoxFit.cover,
                              colorFilter: ColorFilter.mode(
                                Colors.black.withOpacity(0.8),
                                BlendMode.dstATop,
                              ),
                            ),
                      color: Colors.black,
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
}
