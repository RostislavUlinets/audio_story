import 'dart:async';
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

const _boum = 'assets/sample2.aac';
const int duration = 42673;

///
typedef Fn = void Function();

/// Example app.
class PlayerOnProgress extends StatefulWidget {
  const PlayerOnProgress({Key? key}) : super(key: key);

  @override
  _PlayerOnProgressState createState() => _PlayerOnProgressState();
}

class _PlayerOnProgressState extends State<PlayerOnProgress> {
  final FlutterSoundPlayer _mPlayer = FlutterSoundPlayer();
  bool _mPlayerIsInited = false;
  Uint8List? _boumData;
  StreamSubscription? _mPlayerSubscription;
  int pos = 0;

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
    await _mPlayer.setSubscriptionDuration(Duration(milliseconds: 50));
    _boumData = await getAssetData(_boum);
    _mPlayerSubscription = _mPlayer.onProgress!.listen((e) {
      setPos(e.position.inMilliseconds);
      setState(() {});
    });
  }

  Future<Uint8List> getAssetData(String path) async {
    var asset = await rootBundle.load(path);
    return asset.buffer.asUint8List();
  }

  void play(FlutterSoundPlayer? player) async {
    await player!.startPlayer(
        fromDataBuffer: _boumData,
        codec: Codec.aacADTS,
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

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(3),
      padding: const EdgeInsets.all(3),
      width: double.infinity,
      alignment: Alignment.center,
      child: Column(
        children: [
          const Text(
            'Аудиозапись 1',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.normal,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 80.0),
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
          Padding(
            padding: const EdgeInsets.only(
              top: 60.0,
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
                  icon: Image.asset('assets/PlayBack.png'),
                  iconSize: 32,
                ),
                IconButton(
                  onPressed: getPlaybackFn(_mPlayer),
                  icon: _mPlayer.isPlaying
                      ? Image.asset('assets/PlayRec.png')
                      : Image.asset('assets/PlayRec.png'),
                  iconSize: 124,
                ),
                IconButton(
                  onPressed: () {
                    seekFoward(pos + 0.0);
                  },
                  icon: Image.asset('assets/PlayFront.png'),
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
