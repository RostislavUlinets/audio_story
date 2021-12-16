import 'dart:developer';

import 'package:audio_story/Colors/colors.dart';
import 'package:audio_story/repositories/database.dart';
import 'package:audio_story/screens/category/card_info.dart';
import 'package:audio_story/widgets/audio_list.dart';
import 'package:audio_story/widgets/bottomnavbar.dart';
import 'package:audio_story/widgets/custom_paint.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
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
      bottomNavigationBar: const CustomNavigationBar(1),
      body: Stack(
        children: [
          MyCustomPaint(color: CColors.green),
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
                        final db = DatabaseService(
                            FirebaseAuth.instance.currentUser!.uid);
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
                SizedBox(
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
  ListWidget({Key? key}) : super(key: key);

  @override
  _ListWidgetState createState() => _ListWidgetState();
}

class _ListWidgetState extends State<ListWidget> {
  List<String> url = [];
  List<String> audioName = [];

  Future<void> audioListDB() async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    ListResult result =
        await FirebaseStorage.instance.ref('Sounds/$uid/').listAll();

    for (var i = 0; i < result.items.length; i++) {
      url.add(await result.items[i].getDownloadURL());
      List<String> temp = result.items[i].name.split('_');
      temp.removeLast();
      audioName.add(temp.join('_'));
    }
    setState(() {});
  }

  void _saveAudio(int index) {
    playList.add({
      'Name': audioName[index].toString(),
      'URL': url[index].toString(),
    });
    log(playList.toString());
  }

  @override
  initState() {
    super.initState();
    audioListDB();
    playList = [];
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: audioName.length,
      itemBuilder: (_, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          child: Container(
            child: ListTile(
              title: Text(
                audioName[index],
                style: const TextStyle(color: Color(0xFF3A3A55)),
              ),
              subtitle: const Text(
                "30 минут",
                style: TextStyle(color: Color(0x803A3A55)),
              ),
              leading: IconButton(
                icon: Image(
                  image: AssetImage("assets/Play.png"),
                ),
                onPressed: () {
                  Scaffold.of(context)
                      .showBottomSheet((context) => PlayerOnProgress(
                            url: url[index],
                            name: audioName[index],
                          ));
                },
              ),
              trailing: IconButton(
                icon: Icon(Icons.add),
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
