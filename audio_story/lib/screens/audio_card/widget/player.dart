import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';

const int tSampleRate = 44000;
typedef Fn = void Function();

class PlayerOnProgress extends StatefulWidget {
  final String url, name;

  const PlayerOnProgress({Key? key, required this.url, required this.name})
      : super(key: key);

  @override
  _PlayerOnProgressState createState() => _PlayerOnProgressState(url, name);
}

class _PlayerOnProgressState extends State<PlayerOnProgress> {
  _PlayerOnProgressState(this.url, this.name);

  final FlutterSoundPlayer _mPlayer = FlutterSoundPlayer();
  bool _mPlayerIsInited = false;
  StreamSubscription? _mPlayerSubscription;
  int pos = 0;
  int duration = 0;
  final String url, name;

  @override
  void initState() {
    super.initState();
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
    duration = (await flutterSoundHelper.duration(url))!.inMilliseconds;
    await _mPlayer.setSubscriptionDuration(const Duration(milliseconds: 50));
    _mPlayerSubscription = _mPlayer.onProgress!.listen((e) {
      setPos(e.position.inMilliseconds);
      setState(() {});
    });
  }

  void play(FlutterSoundPlayer? player) async {
    await player!.startPlayer(
        codec: Codec.mp3,
        fromURI: url,
        whenFinished: () {
          setState(() {});
        });
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

  Future<void> seekBack(double d) async {
    await _mPlayer.seekToPlayer(Duration(milliseconds: d.floor() - 600));
    await setPos(d.floor() - 600);
  }

    Future<void> seekFoward(double d) async {
    await _mPlayer.seekToPlayer(Duration(milliseconds: d.floor() + 600));
    await setPos(d.floor() + 600);
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
          };
  }

  format(Duration d) => d.toString().split('.').first.padLeft(8, "0");

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: SizedBox(
            width: 250,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 60,
                  child: SliderTheme(
                    data: const SliderThemeData(
                      thumbColor: Colors.black,
                      inactiveTrackColor: Colors.black,
                      activeTrackColor: Colors.black,
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
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      "${format(Duration(milliseconds: duration))}",
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {
                          seekBack(pos + 0.0);
                        },
                        icon: Image.asset('assets/PlayBack.png',color: Colors.black,),
                        iconSize: 32,
                      ),
                      IconButton(
                        onPressed: getPlaybackFn(_mPlayer),
                        icon: _mPlayer.isPlaying
                            ? Image.asset('assets/PlayRec.png')
                            : Image.asset('assets/PlayRec.png'),
                        iconSize: 80,
                      ),
                      IconButton(
                        onPressed: () {
                          seekFoward(pos + 0.0);
                        },
                        icon: Image.asset('assets/PlayFront.png',color: Colors.black,),
                        iconSize: 32,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
