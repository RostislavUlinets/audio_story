import 'dart:async';
import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_sound/flutter_sound.dart';
import 'package:path_provider/path_provider.dart';

const int tSampleRate = 44000;
typedef Fn = void Function();

class PlayerOnProgress extends StatefulWidget {
  const PlayerOnProgress({Key? key}) : super(key: key);

  @override
  _PlayerOnProgressState createState() => _PlayerOnProgressState();
}

class _PlayerOnProgressState extends State<PlayerOnProgress> {
  final FlutterSoundPlayer _mPlayer = FlutterSoundPlayer();
  bool _mPlayerIsInited = false;
  StreamSubscription? _mPlayerSubscription;
  int pos = 0;
  int duration = 0;
  String url = "https://firebasestorage.googleapis.com/v0/b/audiostorysl.appspot.com/o/Sounds%2FvlzG8jhQYWVx7dVkeiMdLrzbYpp1%2FMyAudio_2021-12-01%2011%3A58%3A19.078318.mp3?alt=media&token=12721916-3e8b-488c-b3b5-b29a2d339122";
  
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

  Future<String> _getTempPath(String path) async {
    var tempDir = await getTemporaryDirectory();
    var tempPath = tempDir.path;
    return tempPath + '/' + path;
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
    return Container(
      margin: const EdgeInsets.all(3),
      padding: const EdgeInsets.all(3),
      width: double.infinity,
      alignment: Alignment.center,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 60.0,bottom: 10),
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
                  onPressed: getPlaybackFn(_mPlayer),
                  icon: _mPlayer.isPlaying
                      ? Image.asset('assets/PlayRec.png')
                      : Image.asset('assets/PlayRec.png'),
                  iconSize: 124,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
