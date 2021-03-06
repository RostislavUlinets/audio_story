import 'dart:convert';
import 'dart:developer';

import 'package:audio_story/models/audio.dart';
import 'package:audio_story/provider/navigation_provider.dart';
import 'package:audio_story/repositories/database.dart';
import 'package:audio_story/resources/app_icons.dart';
import 'package:audio_story/screens/category/category.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

class CustomListCategory extends StatefulWidget {
  final List<AudioModel> id;

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
              final nav = context.read<NavigationProvider>();
              nav.changeScreen(1);
            },
            child: const Text(
              '????????????????',
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
                                            "n ??????????\n1:30 ????????",
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
                                    image: AppIcons.complite,
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
