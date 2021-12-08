import 'dart:developer';

import 'package:audio_story/widgets/player.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

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
    log(result.items[0].name);
    url.forEach((element) {
      log('Found file $element');
    });
    setState(() {});
  }

  @override
  initState() {
    super.initState();
    audioListDB();
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
                style: TextStyle(color: Color(0xFF3A3A55)),
              ),
              subtitle: Text(
                "30 минут",
                style: TextStyle(color: Color(0x803A3A55)),
              ),
              leading: IconButton(
                icon: Image(
                  image: AssetImage("assets/Play.png"),               
                ), onPressed: () {
                Scaffold
                    .of(context)
                    .showBottomSheet((context) => PlayerOnProgress(url: url[index],name: audioName[index],));
              },
              ),
              trailing: Icon(Icons.more_horiz),
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