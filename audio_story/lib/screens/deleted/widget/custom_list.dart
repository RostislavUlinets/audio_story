import 'package:audio_story/models/audio.dart';
import 'package:audio_story/provider/navigation_provider.dart';
import 'package:audio_story/repositories/database.dart';
import 'package:audio_story/screens/audio_card/audo_info.dart';
import 'package:audio_story/widgets/player.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:animations/animations.dart';

final DatabaseService dataBase =
    DatabaseService(FirebaseAuth.instance.currentUser!.uid);

class ListWidget extends StatefulWidget {
  List<AudioModel> audio;

  ListWidget({Key? key, required this.audio}) : super(key: key);

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
                style: const TextStyle(color: Color(0xFF3A3A55)),
              ),
              subtitle: const Text(
                "30 минут",
                style: TextStyle(color: Color(0x803A3A55)),
              ),
              leading: SizedBox(
                height: 64,
                width: 64,
                child: IconButton(
                  padding: EdgeInsets.zero,
                  iconSize: 64,
                  icon: const Image(
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
              ),
              trailing: GestureDetector(
                onTap: (){
                  dataBase.fullDeleteAudio(audio[index].id);
                },
                child: Image(
                  image: AssetImage("assets/Delete.png"),
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
    );
  }
}