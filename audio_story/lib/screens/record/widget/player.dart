/*
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class AudioPlayerWithLocalFiles extends StatefulWidget {
  AudioPlayerWithLocalFiles({Key? key}) : super(key: key);

  @override
  _AudioPlayerWithLocalFilesState createState() =>
      _AudioPlayerWithLocalFilesState();
}

class _AudioPlayerWithLocalFilesState extends State<AudioPlayerWithLocalFiles> {
  AudioPlayer audioPlayer = AudioPlayer();
  PlayerState audioPlayerState = PlayerState.PAUSED;
  late AudioCache audioCache;
  String path = '/sdcard/Download/temp.aac';

  @override
  void initState() {
    super.initState();

    audioCache = AudioCache(fixedPlayer: audioPlayer);
    audioPlayer.onPlayerStateChanged.listen((PlayerState e) {
      setState(() {
        audioPlayerState = e;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    audioPlayer.release();
    audioPlayer.dispose();
    audioCache.clearAll();
  }

  playMusic() async {
    await audioCache.play(path);
  }

  pauseMusic() async {
    await audioPlayer.pause();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          IconButton(
            onPressed: () {
              audioPlayerState == PlayerState.PLAYING
                  ? pauseMusic()
                  : playMusic();
            },
            icon: Icon(
              audioPlayerState == PlayerState.PLAYING
                  ? Icons.pause_rounded
                  : Icons.play_arrow_rounded,
            ),
          ),
        ],
      ),
    );
  }
}
*/