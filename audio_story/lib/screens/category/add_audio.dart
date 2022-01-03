import 'dart:developer';

import 'package:audio_story/Colors/colors.dart';
import 'package:audio_story/models/audio.dart';
import 'package:audio_story/repositories/database.dart';
import 'package:audio_story/screens/search/search_field.dart';
import 'package:audio_story/widgets/bottomnavbar.dart';
import 'package:audio_story/widgets/custom_paint.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'widget/player.dart';

class AddAudio extends StatefulWidget {
  const AddAudio({Key? key}) : super(key: key);

  @override
  State<AddAudio> createState() => _AddAudioState();
}

class _AddAudioState extends State<AddAudio> {
  List<AudioModel> playList = [];
  void _sendDataBack(BuildContext context, var playList) {
    Navigator.pop(context, playList);
  }

  @override
  void initState() {
    getData();
    super.initState();

    // dataBase.audioListDB().then((value) {
    //   audio = value;
    //   allAudio = audio;
    // });
  }

  Future<void> getData() async {
    await dataBase.audioListDB().then(
      (value) {
        audio = value;
        allAudio = audio;
        select = List.filled(audio.length, false);
        setState(() {});
      },
    );
  }

  DatabaseService dataBase =
      DatabaseService(FirebaseAuth.instance.currentUser!.uid);

  List<AudioModel> audio = [];

  List<AudioModel> allAudio = [];

  String query = '';

  List<bool> select = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: const CustomNavigationBar(1),
      body: Stack(
        children: [
          const MyCustomPaint(
            color: CColors.green,
            size: 0.7,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 15),
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
                            _sendDataBack(context, playList);
                          },
                          icon: Image.asset('assets/ArrowBack.png'),
                        ),
                      ),
                    ),
                    const Text(
                      "Выбрать",
                      style: TextStyle(
                          fontSize: 36,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    TextButton(
                      onPressed: () {
                        //Navigator.pop(context);
                        _sendDataBack(context, playList);
                      },
                      child: const Text(
                        "Добавить",
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 40.0),
                  child: buildSearch(),
                ),
                SizedBox(
                  width: 350,
                  height: 420,
                  child: ListView.builder(
                    itemCount: audio.length,
                    itemBuilder: (_, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: Container(
                          child: ListTile(
                            title: Text(
                              audio[index].name,
                              style: const TextStyle(color: Color(0xFF3A3A55)),
                            ),
                            subtitle: const Text(
                              "30 минут",
                              style: TextStyle(color: Color(0x803A3A55)),
                            ),
                            leading: IconButton(
                              icon: const Image(
                                image: AssetImage("assets/Play.png"),
                              ),
                              onPressed: () {
                                Scaffold.of(context).showBottomSheet(
                                    (context) => PlayerOnProgress(
                                          url: audio[index].url,
                                          name: audio[index].name,
                                        ));
                              },
                            ),
                            trailing: GestureDetector(
                              onTap: () {
                                if (select[index] == false) {
                                  select[index] = true;
                                  playList.add(audio[index]);
                                  setState(() {});
                                } else {
                                  select[index] = false;
                                  playList.removeWhere(
                                    (element) => element.id == audio[index].id,
                                  );
                                  setState(() {});
                                }
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    border: Border.all(
                                        width: 2, color: Colors.black)),
                                child: Image(
                                  image: AssetImage('assets/TickSquare.png'),
                                  color: select[index]
                                      ? Colors.black
                                      : Colors.white,
                                ),
                              ),
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
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSearch() => SearchWidget(
        text: query,
        hintText: 'Title or Author Name',
        onChanged: searchBook,
      );

  void searchBook(String query) {
    final audioList = allAudio.where((element) {
      final nameToLower = element.name.toLowerCase();
      final searchLower = query.toLowerCase();

      return nameToLower.contains(searchLower);
    }).toList();

    setState(() {
      this.query = query;
      audio = audioList;
    });
  }

  void _saveAudio(AudioModel audio) {
    log(playList.toString());
  }
}
