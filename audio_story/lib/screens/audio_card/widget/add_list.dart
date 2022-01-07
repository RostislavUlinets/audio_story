import 'dart:convert';
import 'dart:developer';

import 'package:audio_story/repositories/database.dart';
import 'package:audio_story/screens/category/card_info.dart';
import 'package:audio_story/screens/main_screen/main_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CustomListCategory extends StatefulWidget {
  final String id;
  const CustomListCategory({Key? key, required this.id}) : super(key: key);

  @override
  _CustomListCategoryState createState() => _CustomListCategoryState();
}

class _CustomListCategoryState extends State<CustomListCategory> {
  final user = FirebaseAuth.instance.currentUser;
  DatabaseService dataBase =
      DatabaseService(FirebaseAuth.instance.currentUser!.uid);
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  var sounds = [];
  String name = '';
  Image? image;
  List<bool> select = [];
  List<int> playList = [];

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
          select = List.filled(value.length, false);
        }));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          TextButton(
            onPressed: () {
              dataBase.addToPlayList(playList, widget.id);
              Navigator.pushNamed(context, MainScreen.routeName);
            },
            child: const Text(
              'Добавить',
              style: TextStyle(color: Colors.white),
              textAlign: TextAlign.end,
            ),
          ),
          Container(
            height: 560,
            color: const Color(0x0071A59F),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.count(
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
                            if (select[index] == false) {
                              select[index] = true;
                              playList.add(index);
                              setState(() {});
                            } else {
                              select[index] = false;
                              playList.removeWhere(
                                (element) => element == index,
                              );
                              setState(() {});
                            }
                            log(playList.toString());
                          },
                          child: Stack(
                            children: [
                              ClipRRect(
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
                                        const SizedBox(
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
                                    color: Colors.black,
                                    image: image != null
                                        ? DecorationImage(
                                            image: image!.image,
                                            fit: BoxFit.cover,
                                            colorFilter: ColorFilter.mode(
                                              Colors.black.withOpacity(0.6),
                                              BlendMode.dstATop,
                                            ),
                                          )
                                        : DecorationImage(
                                            image: const AssetImage(
                                                'assets/story.jpg'),
                                            fit: BoxFit.cover,
                                            colorFilter: ColorFilter.mode(
                                              Colors.black.withOpacity(0.6),
                                              BlendMode.dstATop,
                                            ),
                                          ),
                                  ),
                                ),
                              ),
                              Center(
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    border: Border.all(
                                        width: 2, color: Colors.white),
                                  ),
                                  child: Image(
                                    image: const AssetImage(
                                        'assets/TickSquare.png'),
                                    color: select[index]
                                        ? Colors.white
                                        : Colors.black.withOpacity(0),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
