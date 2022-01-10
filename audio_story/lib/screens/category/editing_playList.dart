import 'dart:convert';

import 'package:audio_story/Colors/colors.dart';
import 'package:audio_story/models/sounds.dart';
import 'package:audio_story/repositories/database.dart';
import 'package:audio_story/widgets/audio_list.dart';
import 'package:audio_story/widgets/bottomnavbar.dart';
import 'package:audio_story/widgets/custom_paint.dart';
import 'package:audio_story/widgets/side_menu.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'widget/description.dart';

DatabaseService dataBase =
    DatabaseService(FirebaseAuth.instance.currentUser!.uid);

bool selectFlag = true;
late List<int> eraseList;

late SoundModel audioPropeperty;

Image imageFromBase64String(String base64String) {
  return Image.memory(base64Decode(base64String));
}

class EditingPlayList extends StatefulWidget {
  final int index;

  EditingPlayList({Key? key, required this.index}) : super(key: key);

  @override
  _EditingPlayListState createState() => _EditingPlayListState();
}

class _EditingPlayListState extends State<EditingPlayList> {
  @override
  void initState() {
    dataBase.getSaveList(widget.index).then((value) => setState(() {
          audioPropeperty = value;
        }));
    super.initState();
  }

  bool playAll = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      drawer: const SideMenu(),
      bottomNavigationBar: const CustomNavigationBar(1),
      body: FutureBuilder(
        future: dataBase.getSaveList(widget.index).then(
              (value) => audioPropeperty = value,
            ),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const SizedBox(
                height: 250,
                width: 250,
                child: Center(
                  child: CircularProgressIndicator(
                    color: CColors.purpule,
                    strokeWidth: 1.5,
                  ),
                ),
              );
            default:
              return Stack(
                children: [
                  const MyCustomPaint(
                    color: CColors.green,
                    size: 0.85,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 60.0),
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
                              TextButton(
                                onPressed: () {},
                                child: const Text('Сохранить'),
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      child: Text(
                                        "${audioPropeperty.sounds.length} аудио\n1:30 часа",
                                        style: const TextStyle(
                                          fontSize: 13,
                                          color: Colors.white,
                                        ),
                                      ),
                                      width: 70,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        playAll = !playAll;
                                        setState(() {});
                                      },
                                      child: Container(
                                        height: 50,
                                        width: 160,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(40),
                                          color: Colors.white.withOpacity(0.6),
                                        ),
                                        child: Row(
                                          children: [
                                            playAll == false
                                                ? const Image(
                                                    image: AssetImage(
                                                        "assets/Play.png"),
                                                    color: Colors.white,
                                                  )
                                                : const Image(
                                                    image: AssetImage(
                                                        "assets/Pause.png"),
                                                    color: Colors.white,
                                                  ),
                                            const Text(
                                              "Запустить все",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ],
                                        ),
                                      ),
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
                            child: DescriptionTextWidget(
                              text: audioPropeperty.info,
                            ),
                          ),
                          FutureBuilder(
                            future: dataBase
                                .getPlayListAudio(audioPropeperty.sounds),
                            builder: (BuildContext context,
                                AsyncSnapshot<dynamic> snapshot) {
                              switch (snapshot.connectionState) {
                                case ConnectionState.waiting:
                                  return const SizedBox(
                                    height: 250,
                                    width: 250,
                                    child: Center(
                                      child: CircularProgressIndicator(
                                        color: CColors.purpule,
                                        strokeWidth: 1.5,
                                      ),
                                    ),
                                  );
                                default:
                                  return Expanded(
                                    child: ListWidget(
                                      audio: snapshot.data,
                                      buttonState: false,
                                      cycleState: playAll,
                                    ),
                                  );
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
          }
        },
      ),
    );
  }
}
