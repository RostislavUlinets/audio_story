import 'dart:developer';

import 'package:audio_story/repositories/database.dart';
import 'package:audio_story/widgets/audio_list.dart';
import 'package:audio_story/widgets/bottomnavbar.dart';
import 'package:audio_story/widgets/side_menu.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'custompaint.dart';
import '../../widgets/player.dart';

class Audio extends StatelessWidget {
  static const routeName = '/audio';

  const Audio({Key? key}) : super(key: key);
  
  Future<void> AudioListDB() async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    ListResult result =
        await FirebaseStorage.instance.ref('Sounds/$uid/').listAll();
    List<String> url = [];
    for (var i = 0; i < result.items.length; i++) {
      url.add(await result.items[i].getDownloadURL());
    }
    log(result.items[0].name);
    url.forEach((element) {
      log('Found file $element');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const SideMenu(),
      extendBody: true,
      bottomNavigationBar: const CustomNavigationBar(3),
      body: Stack(
        children: [
          const CustomP(),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 60.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Builder(
                      builder: (ctx) => IconButton(
                        icon: const Icon(
                          Icons.menu,
                          color: Colors.white,
                          size: 36,
                        ),
                        onPressed: () {
                          Scaffold.of(ctx).openDrawer();
                        },
                      ),
                    ),
                    const Text(
                      "Аудиозаписи",
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
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
                const Text(
                  "Все в одном месте",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                  child: Row(
                    children: const [
                      Text(
                        "20 аудио\n10:30 часов",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 350,
                  height: 420,
                  child: ListWidget(),
                )
              ],
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

