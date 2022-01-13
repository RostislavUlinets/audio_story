import 'package:audio_story/models/audio.dart';
import 'package:audio_story/provider/current_audio_provider.dart';
import 'package:audio_story/resources/app_colors.dart';
import 'package:audio_story/resources/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

import 'player.dart';

class SelectList extends StatefulWidget {
  List<AudioModel> audio = [];
  SelectList({Key? key, required this.audio}) : super(key: key);

  @override
  _SelectListState createState() => _SelectListState();
}

class _SelectListState extends State<SelectList> {
  List<AudioModel> playList = [];
  List<AudioModel> audio = [];
  List<bool> select = [];

  @override
  void initState() {
    super.initState();
    audio = widget.audio;
    select = List.filled(audio.length, false);
  }

  @override
  Widget build(BuildContext context) {
    final audioProvider = context.watch<CurrentAudio>();
    return ListView.builder(
      itemCount: audio.length,
      itemBuilder: (_, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0),
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
              icon: audioProvider.audioName == audio[index].name
                  ? Image(
                      image: AppIcons.pause,
                      color: AppColors.purpule,
                    )
                  : Image(
                      image: AppIcons.play,
                    ),
              onPressed: () {
                Scaffold.of(context).showBottomSheet(
                  (context) => PlayerOnProgress(
                    cycle: false,
                    index: index,
                    repeat: false,
                    soundsList: audio,
                    audioProvider: audioProvider,
                  ),
                );
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
                    border: Border.all(width: 2, color: Colors.black)),
                child: Image(
                  image: AppIcons.complite,
                  color: select[index] ? Colors.black : Colors.white,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
