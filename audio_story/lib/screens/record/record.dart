import 'dart:async';
import 'dart:io';

import 'package:audio_story/Colors/colors.dart';
import 'package:audio_story/repositories/database.dart';
import 'package:audio_story/widgets/bottomnavbar.dart';
import 'package:audio_story/widgets/custom_paint.dart';
import 'package:audio_story/widgets/side_menu.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import 'widget/test.dart';

const int tSampleRate = 44000;
typedef _Fn = void Function();

class Records extends StatefulWidget {
  static const routeName = '/record';

  const Records({Key? key}) : super(key: key);

  @override
  State<Records> createState() => _RecordsState();
}

class _RecordsState extends State<Records> {
  final pathToSaveAudio = '/sdcard/Download/temp.aac';
  FlutterSoundRecorder? _mRecorder = FlutterSoundRecorder();
  bool _mRecorderIsInited = false;
  bool _mplaybackReady = false;
  StreamSubscription? _mRecordingDataSubscription;
  static String? _mPath;

  Future<void> _openRecorder() async {
    final status = await Permission.microphone.request();
    final secondStatus = await Permission.storage.request();
    if (status != PermissionStatus.granted &&
        secondStatus != PermissionStatus.granted) {
      throw RecordingPermissionException('Microphone permission error');
    }
    await _mRecorder!.openAudioSession();
    setState(() {
      _mRecorderIsInited = true;
    });
  }

  @override
  void initState() {
    super.initState();
    _openRecorder();
  }

  @override
  void dispose() {
    stopRecorder();
    _mRecorder!.closeAudioSession();
    _mRecorder = null;
    super.dispose();
  }

  Future<IOSink> createFile() async {
    var tempDir = await getTemporaryDirectory();
    _mPath = '${tempDir.path}/flutter_sound_example.pcm';
    var outputFile = File(_mPath!);
    if (outputFile.existsSync()) {
      await outputFile.delete();
    }
    return outputFile.openWrite();
  }

  Future<void> record() async {
    if (!_mRecorderIsInited) return;
    var sink = await createFile();
    var recordingDataController = StreamController<Food>();
    _mRecordingDataSubscription =
        recordingDataController.stream.listen((buffer) {
      if (buffer is FoodData) {
        sink.add(buffer.data!);
      }
    });
    await _mRecorder!.startRecorder(
      toStream: recordingDataController.sink,
      codec: Codec.pcm16,
      numChannels: 1,
      sampleRate: tSampleRate,
    );
    setState(() {});
  }

  Future<void> stopRecorder() async {
    await _mRecorder!.stopRecorder();
    if (_mRecordingDataSubscription != null) {
      await _mRecordingDataSubscription!.cancel();
      _mRecordingDataSubscription = null;
    }
    _mplaybackReady = true;
  }

  _Fn? getRecorderFn() {
    if (!_mRecorderIsInited) {
      return null;
    }
    return _mRecorder!.isStopped
        ? record
        : () {
            stopRecorder().then((value) => setState(() {}));
          };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      drawer: const SideMenu(),
      bottomNavigationBar: const CustomNavigationBar(2),
      body: _mplaybackReady
          ? Stack(
              children: [
                MyCustomPaint(color: CColors.purpule),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 50, horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Builder(
                            builder: (ctx) => IconButton(
                              icon: const Icon(
                                Icons.menu,
                                color: Colors.white,
                                size: 36,
                              ),
                              onPressed: () {
                                Scaffold.of(ctx).openDrawer();
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 385,
                      height: 580,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(30.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                  icon: Image(
                                    image: AssetImage("assets/Upload.png"),
                                  ),
                                  onPressed: () {
                                    File file = File(_mPath!);
                                    String uid =
                                        FirebaseAuth.instance.currentUser!.uid;
                                    DatabaseService dataBase =
                                        DatabaseService(uid);
                                    final destination =
                                        'Sounds/$uid/audio.pcm';
                                    dataBase.uploadFile(destination, file);
                                  },
                                ),
                                Image(
                                  image:
                                      AssetImage("assets/PaperDownload1.png"),
                                ),
                                Image(
                                  image: AssetImage("assets/Delete.png"),
                                ),
                                SizedBox(
                                  width: 4,
                                ),
                                Text("Сохранить"),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          const PlayerOnProgress(),
                        ],
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF6F6F6),
                        border: Border.all(
                          color: Colors.grey,
                        ),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20)),
                      ),
                    ),
                  ],
                ),
              ],
            )
          : Stack(
              children: [
                MyCustomPaint(color: CColors.purpule),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 50, horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Builder(
                            builder: (ctx) => IconButton(
                              icon: const Icon(
                                Icons.menu,
                                color: Colors.white,
                                size: 36,
                              ),
                              onPressed: () {
                                Scaffold.of(ctx).openDrawer();
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 385,
                      height: 580,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(30.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: const [
                                Text("Отменить"),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          const Text(
                            'Запись',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 100.0),
                            child: Text(
                                '-------------------------------------------------------------------'),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: buildStart(),
                          ),
                        ],
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF6F6F6),
                        border: Border.all(
                          color: Colors.grey,
                        ),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
    );
  }

  Widget buildStart() {
    final isRecording = _mRecorder!.isRecording;

    final icon = isRecording ? Icons.stop : Icons.mic;
    final text = isRecording ? 'STOP' : 'START';
    final primary = isRecording ? Colors.red : Colors.white;
    final onPrimary = isRecording ? Colors.white : Colors.black;

    return ElevatedButton.icon(
      onPressed: getRecorderFn(),
      icon: Icon(icon),
      label: Text(text),
      style: ElevatedButton.styleFrom(
        primary: primary,
        onPrimary: onPrimary,
      ),
    );
  }
}
