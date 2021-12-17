

import 'package:audio_story/Colors/colors.dart';
import 'package:audio_story/models/audio.dart';
import 'package:audio_story/repositories/database.dart';
import 'package:audio_story/widgets/bottomnavbar.dart';
import 'package:audio_story/widgets/custom_paint.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'widget/player.dart';

var playList = [];
class AddAudio extends StatelessWidget {
  const AddAudio({Key? key}) : super(key: key);

  void _sendDataBack(BuildContext context, var playList) {
    Navigator.pop(context, playList);
  }

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
                  padding: const EdgeInsets.symmetric(vertical: 50.0),
                  child: Container(
                    child: TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(45)),
                        labelText: 'Password',
                      ),
                    ),
                    height: 50,
                    width: double.infinity - 25,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(45),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 350,
                  height: 420,
                  child: ListWidget(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


class ListWidget extends StatefulWidget {
  const ListWidget({Key? key}) : super(key: key);

  @override
  _ListWidgetState createState() => _ListWidgetState();
}

class _ListWidgetState extends State<ListWidget> {
  
  late List<AudioModel> audio;
  DatabaseService dataBase =
      DatabaseService(FirebaseAuth.instance.currentUser!.uid);

  @override
  initState() {
    super.initState();
    dataBase.audioListDB().then(
          (value) => setState(
            () {
              audio = value;
            },
          ),
        );
  }

  void _saveAudio(int index) {
    playList.add({
      'Name': audio[index].name,
      'URL': audio[index].url,
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
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
                  Scaffold.of(context)
                      .showBottomSheet((context) => PlayerOnProgress(
                            url: audio[index].url,
                            name: audio[index].name,
                          ));
                },
              ),
              trailing: IconButton(
                icon: const Icon(Icons.add),
                onPressed: () => _saveAudio(index),
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
    );
  }
}