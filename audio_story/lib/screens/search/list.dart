import 'package:audio_story/models/audio.dart';
import 'package:audio_story/widgets/player.dart';
import 'package:flutter/material.dart';

class SearchCustomList extends StatefulWidget {
  List<Audio> audio;

  SearchCustomList({Key? key, required this.audio}) : super(key: key);

  @override
  _SearchCustomListState createState() => _SearchCustomListState();
}

class _SearchCustomListState extends State<SearchCustomList> {
  late List<Audio> audio;


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
