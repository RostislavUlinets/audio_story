import 'dart:developer';

import 'package:audio_story/models/audio.dart';
import 'package:audio_story/widgets/player.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';


class ListWidget extends StatefulWidget {
  List<AudioModel> audio;

  ListWidget({Key? key,required this.audio}) : super(key: key);

  @override
  _ListWidgetState createState() => _ListWidgetState();
}

class _ListWidgetState extends State<ListWidget> {
  late List<AudioModel> audio;

  @override
  initState() {
    super.initState();
    audio = widget.audio;
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
                style: TextStyle(color: Color(0xFF3A3A55)),
              ),
              subtitle: Text(
                "30 минут",
                style: TextStyle(color: Color(0x803A3A55)),
              ),
              leading: IconButton(
                icon: Image(
                  image: AssetImage("assets/Play.png"),
                ),
                onPressed: () {
                  Scaffold.of(context).showBottomSheet(
                    (context) => PlayerOnProgress(
                      url: audio[index].url,
                      name: audio[index].name,
                    ),
                  );
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
