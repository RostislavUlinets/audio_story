import 'dart:async';

import 'package:audio_story/models/audio.dart';
import 'package:audio_story/resources/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';

const int tSampleRate = 44000;
typedef Fn = void Function();

class PlayerOnProgress extends StatefulWidget {
  final List<AudioModel> soundsList;
  final int index;
  final bool repeat;
  final bool cycle;
  final audioProvider;

  const PlayerOnProgress({
    Key? key,
    required this.soundsList,
    required this.index,
    required this.repeat,
    required this.cycle,
    required this.audioProvider,
  }) : super(key: key);

  @override
  _PlayerOnProgressState createState() => _PlayerOnProgressState();
}

class _PlayerOnProgressState extends State<PlayerOnProgress> {
  List<AudioModel> soundsList = [];
  int index = 0;

  final FlutterSoundPlayer _mPlayer = FlutterSoundPlayer();
  bool _mPlayerIsInited = false;
  StreamSubscription? _mPlayerSubscription;
  int pos = 0;
  int duration = 0;

  @override
  void initState() {
    super.initState();
    soundsList = widget.soundsList;
    index = widget.index;
    init().then((value) {
      setState(() {
        _mPlayerIsInited = true;
      });
    });
  }

  @override
  void dispose() {
    stopPlayer(_mPlayer);
    cancelPlayerSubscriptions();
    _mPlayer.closeAudioSession();
    super.dispose();
  }

  void cancelPlayerSubscriptions() {
    if (_mPlayerSubscription != null) {
      _mPlayerSubscription!.cancel();
      _mPlayerSubscription = null;
    }
  }

  Future<void> init() async {
    await _mPlayer.openAudioSession();
    duration = (await flutterSoundHelper.duration(soundsList[index].url))!
        .inMilliseconds;
    await _mPlayer.setSubscriptionDuration(const Duration(milliseconds: 50));
    _mPlayerSubscription = _mPlayer.onProgress!.listen((e) {
      setPos(e.position.inMilliseconds);
      setState(() {});
    });
  }

  void playList() async {
    index++;
    pos = 0;
    duration = (await flutterSoundHelper.duration(soundsList[index].url))!
        .inMilliseconds;
    setState(() {});
  }

  void repeatAudio() {
    pos = 0;
    setState(() {});
  }

  void play(FlutterSoundPlayer? player) async {
    await player!.startPlayer(
        codec: Codec.mp3,
        fromURI: soundsList[index].url,
        whenFinished: () async {
          if (widget.repeat) {
            repeatAudio();
            play(player);
          } else if (widget.cycle && index < soundsList.length - 1) {
            playList();
            play(player);
          }
        });
    widget.audioProvider.changeScreen(soundsList[index].id);
    setState(() {});
  }

  Future<void> stopPlayer(FlutterSoundPlayer player) async {
    await player.stopPlayer();
  }

  Future<void> setPos(int d) async {
    if (d > duration) {
      d = duration;
    }
    setState(() {
      pos = d;
    });
  }

  Future<void> seek(double d) async {
    await _mPlayer.seekToPlayer(Duration(milliseconds: d.floor()));
    await setPos(d.floor());
  }

  Fn? getPlaybackFn(FlutterSoundPlayer? player) {
    if (!_mPlayerIsInited) {
      return null;
    }
    return player!.isStopped
        ? () {
            play(player);
          }
        : () {
            stopPlayer(player).then((value) => setState(() {}));
            widget.audioProvider.changeScreen('');
          };
  }

  format(Duration d) => d.toString().split('.').first.padLeft(8, "0");

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Color(0xFF6C689F),
            Color(0xFF8C84E2),
          ],
        ),
        borderRadius: BorderRadius.circular(90),
      ),
      height: 75,
      alignment: Alignment.center,
      child: Row(
        children: [
          IconButton(
            onPressed: getPlaybackFn(_mPlayer),
            icon: _mPlayer.isPlaying
                ? Image(
                    image: AppIcons.pause,
                    color: Colors.white,
                  )
                : Image(
                    image: AppIcons.playRec,
                    color: Colors.white,
                  ),
            iconSize: 64,
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: SizedBox(
              width: 250,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    soundsList[index].name,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                    child: SliderTheme(
                      data: const SliderThemeData(
                        thumbColor: Colors.white,
                        inactiveTrackColor: Colors.white,
                        activeTrackColor: Colors.white,
                      ),
                      child: Slider(
                        value: pos + 0.0,
                        min: 0.0,
                        max: duration + 0.0,
                        onChanged: seek,
                        divisions: 100,
                        //divisions: 100
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${format(Duration(milliseconds: pos))}",
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        "${format(Duration(milliseconds: duration))}",
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
