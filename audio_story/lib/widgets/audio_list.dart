import 'package:audio_story/models/audio.dart';
import 'package:audio_story/provider/navigation_provider.dart';
import 'package:audio_story/screens/audio_card/audo_info.dart';
import 'package:audio_story/widgets/player.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
              leading: IconButton(
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
              trailing: PopupMenuButton(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20.0),
                  ),
                ),
                icon: const Icon(
                  Icons.more_horiz,
                  size: 32,
                  color: Colors.black54,
                ),
                itemBuilder: (context) => [
                  PopupMenuItem(
                    child: const Text("Удалить"),
                    //TODO: Question
                    onTap: () {
                      FirebaseStorage.instance
                          .refFromURL(audio[index].url)
                          .delete();
                    },
                    value: 1,
                  ),
                  PopupMenuItem(
                    child: Text("Подробнее об аудиозаписи"),
                    onTap: () {
                      NavigationController navigation =
                          Provider.of<NavigationController>(context,
                              listen: false);
                      navigation.changeScreen(AudioInfo.routeName);
                    },
                    value: 2,
                  ),
                ],
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
