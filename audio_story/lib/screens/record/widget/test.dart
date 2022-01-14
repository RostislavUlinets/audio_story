import 'dart:async';
import 'package:audio_story/resources/app_colors.dart';
import 'package:audio_story/resources/app_icons.dart';
import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_sound/flutter_sound.dart';

/*
 *
 * This is a very simple example for Flutter Sound beginners,
 * that show how to record, and then playback a file.
 *
 * This example is really basic.
 *
 */

const int tSampleRate = 44000;

///
typedef Fn = void Function();

/// Example app.
class PlayerOnProgress extends StatefulWidget {
  const PlayerOnProgress({Key? key}) : super(key: key);

  @override
  _PlayerOnProgressState createState() => _PlayerOnProgressState();
}

class _PlayerOnProgressState extends State<PlayerOnProgress> {
  final pathToSaveAudio = '/sdcard/Download/audio.mp3';
  final FlutterSoundPlayer _mPlayer = FlutterSoundPlayer();
  late FlutterSoundHelper _helper;
  bool _mPlayerIsInited = false;
  StreamSubscription? _mPlayerSubscription;
  int pos = 0;
  int duration = 0;

  @override
  void initState() {
    _helper = FlutterSoundHelper();
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

    // Be careful : you must `close` the audio session when you have finished with it.
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
    await _mPlayer.setSubscriptionDuration(const Duration(milliseconds: 50));
    _mPlayerSubscription = _mPlayer.onProgress!.listen((e) {
      setPos(e.position.inMilliseconds);
      setState(() {});
    });
    await _helper
        .duration(pathToSaveAudio)
        .then((value) => duration = value!.inMilliseconds);
  }

  Future<Uint8List> getAssetData(String path) async {
    var asset = await rootBundle.load(path);
    return asset.buffer.asUint8List();
  }

  void play(FlutterSoundPlayer? player) async {
    await player!.startPlayer(
        codec: Codec.mp3,
        fromURI: pathToSaveAudio,
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

  Future<void> seek(double d) async {
    await _mPlayer.seekToPlayer(Duration(milliseconds: d.floor()));
    await setPos(d.floor());
  }

  Future<void> seekBack(double d) async {
    await _mPlayer.seekToPlayer(Duration(milliseconds: d.floor() - 600));
    await setPos(d.floor() - 600);
  }

  Future<void> seekFoward(double d) async {
    await _mPlayer.seekToPlayer(Duration(milliseconds: d.floor() + 600));
    await setPos(d.floor() + 600);
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
    return Container(
      margin: const EdgeInsets.all(3),
      padding: const EdgeInsets.all(3),
      width: double.infinity,
      alignment: Alignment.center,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 60.0, bottom: 10),
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
              Text("${format(Duration(milliseconds: pos))}"),
              Text("${format(Duration(milliseconds: duration))}"),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 40.0,
              right: 40,
              left: 40,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    seekBack(pos + 0.0);
                  },
                  icon: Image(
                    image: AppIcons.playBack,
                  ),
                  iconSize: 32,
                ),
                IconButton(
                  onPressed: getPlaybackFn(_mPlayer),
                  icon: _mPlayer.isPlaying
                      ? Image(
                          image: AppIcons.pause,
                          color: AppColors.orange,
                        )
                      : Image(
                          image: AppIcons.playRec,
                          height: 64,
                          width: 64,
                        ),
                ),
                IconButton(
                  onPressed: () {
                    seekFoward(pos + 0.0);
                  },
                  icon: Image(
                    image: AppIcons.playFoward,
                  ),
                  iconSize: 32,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
