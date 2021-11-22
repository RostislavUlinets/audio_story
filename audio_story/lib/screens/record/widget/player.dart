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

import 'package:flutter/cupertino.dart';
import 'package:flutter_sound_lite/flutter_sound.dart';

var pathToReadAudio = '/sdcard/Download/temp.aac';
class SoundPlayer {
  FlutterSoundPlayer? _audioPlayer;

  Future init() async {
    _audioPlayer = FlutterSoundPlayer();
    await _audioPlayer!.openAudioSession();
  }

  void dispose() {
    _audioPlayer!.closeAudioSession();
    _audioPlayer = null;
  }

  Future _play(VoidCallback whenFinished) async {
    
    await _audioPlayer!.startPlayer(
      fromURI: 'https://www.learningcontainer.com/wp-content/uploads/2020/02/Kalimba.mp3',
      codec: Codec.mp3,
      whenFinished: whenFinished,
    );
  }

  Future _stop() async {
    await _audioPlayer!.stopPlayer();
  }

  Future togglePlaying({required VoidCallback whenFinished}) async {
    if(_audioPlayer!.isStopped){
      await _play(whenFinished);
    }else{
      await _stop();
    }
  }
}