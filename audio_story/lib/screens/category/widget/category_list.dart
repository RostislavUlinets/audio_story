import 'dart:convert';
import 'dart:developer';
import 'dart:ffi';
import 'dart:io';

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
  Image? image = null;

  Future getSaveList() async {
    DocumentSnapshot ds =
        await userCollection.doc(FirebaseAuth.instance.currentUser!.uid).get();
    return ds.get('SaveList');
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
    return ListView.builder(
      itemCount: sounds.isNotEmpty ? sounds.length : 0,
      itemBuilder: (_, index) {
        if (sounds.isNotEmpty) {
          name = sounds[index]['Name'];
          String bytes = sounds[index]['Image'];
          image = imageFromBase64String(bytes);
        }
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
                        MaterialPageRoute(builder: (context) => CardInfo(index: index,)),
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
                          image: image != null
                              ? DecorationImage(
                                  image: image!.image,
                                  fit: BoxFit.cover,
                                  colorFilter: ColorFilter.mode(
                                      Colors.black.withOpacity(0.8),
                                      BlendMode.dstATop),
                                )
                              : DecorationImage(
                                  image: AssetImage('assets/story.jpg'),
                                  fit: BoxFit.cover,
                                  colorFilter: ColorFilter.mode(
                                      Colors.black.withOpacity(0.8),
                                      BlendMode.dstATop),
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

// ListView buildListView() {
//   return ListView.builder(
//     itemCount: 10,
//     itemBuilder: (_, index) {
//       return Padding(
//         padding: const EdgeInsets.symmetric(vertical: 5.0),
//         child: Column(
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 ClipRRect(
//                   borderRadius: BorderRadius.circular(20),
//                   child: Container(
//                     alignment: Alignment.bottomRight,
//                     child: Padding(
//                       padding: const EdgeInsets.all(10.0),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.end,
//                         children: const [
//                           SizedBox(
//                             child: Text(
//                               "Сказка \nо малыше Кокки",
//                               style: TextStyle(
//                                 fontSize: 14,
//                                 color: Colors.white,
//                                 height: 1,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                             width: 90,
//                           ),
//                           Spacer(),
//                           SizedBox(
//                             child: Text(
//                               "n аудио\n1:30 часа",
//                               style: TextStyle(
//                                 fontSize: 13,
//                                 color: Colors.white,
//                               ),
//                             ),
//                             width: 70,
//                           ),
//                         ],
//                       ),
//                     ),
//                     decoration: BoxDecoration(
//                       image: DecorationImage(
//                         image: const AssetImage(
//                           "assets/story.jpg",
//                         ),
//                         colorFilter: ColorFilter.mode(
//                             Colors.black.withOpacity(0.8), BlendMode.dstATop),
//                         fit: BoxFit.cover,
//                       ),
//                       color: Colors.black,
//                     ),
//                     height: 210,
//                     width: 180,
//                   ),
//                 ),
//                 ClipRRect(
//                   borderRadius: BorderRadius.circular(20),
//                   child: Container(
//                     alignment: Alignment.bottomRight,
//                     child: Padding(
//                       padding: const EdgeInsets.all(10.0),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.end,
//                         children: const [
//                           SizedBox(
//                             child: Text(
//                               "Сказка \nо малыше Кокки",
//                               style: TextStyle(
//                                 fontSize: 14,
//                                 color: Colors.white,
//                                 height: 1,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                             width: 90,
//                           ),
//                           Spacer(),
//                           SizedBox(
//                             child: Text(
//                               "n аудио\n1:30 часа",
//                               style: TextStyle(
//                                 fontSize: 13,
//                                 color: Colors.white,
//                               ),
//                             ),
//                             width: 70,
//                           ),
//                         ],
//                       ),
//                     ),
//                     decoration: BoxDecoration(
//                       image: DecorationImage(
//                         image: const AssetImage(
//                           "assets/seconStory.jpg",
//                         ),
//                         colorFilter: ColorFilter.mode(
//                             Colors.black.withOpacity(0.8), BlendMode.dstATop),
//                         fit: BoxFit.cover,
//                       ),
//                       color: Colors.black,
//                     ),
//                     height: 210,
//                     width: 180,
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       );
//     },
//   );
// }
