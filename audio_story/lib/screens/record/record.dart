import 'dart:async';
import 'dart:io';

import 'package:audio_story/Colors/colors.dart';
import 'package:audio_story/provider/navigation_provider.dart';
import 'package:audio_story/repositories/database.dart';
import 'package:audio_story/screens/audio/audio.dart';
import 'package:audio_story/screens/main_screen/main_screen.dart';
import 'package:audio_story/widgets/bottomnavbar.dart';
import 'package:audio_story/widgets/custom_paint.dart';
import 'package:audio_story/widgets/side_menu.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';

import 'widget/dialog.dart';
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
  final pathToSaveAudio = '/sdcard/Download/audio.mp3';
  final pathToSaveTemp = '/sdcard/Download/temp.aac';
  FlutterSoundRecorder? _mRecorder = FlutterSoundRecorder();
  bool _mRecorderIsInited = false;
  bool _mplaybackReady = false;
  final audioName = TextEditingController(text: 'Аудиозапись 1');
  //StreamSubscription? _mRecordingDataSubscription;

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

  void record() {
    _mRecorder!
        .startRecorder(
      toFile: pathToSaveTemp,
    )
        .then((value) {
      setState(() {});
    });
  }

  Future<void> stopRecorder() async {
    await _mRecorder!.stopRecorder();
    // if (_mRecordingDataSubscription != null) {
    //   await _mRecordingDataSubscription!.cancel();
    //   _mRecordingDataSubscription = null;
    // }
    _mplaybackReady = true;
    await FlutterSoundHelper()
        .convertFile(pathToSaveTemp, Codec.aacADTS, pathToSaveAudio, Codec.mp3);
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

  Future<void> saveAudio() async {
    File file = File(pathToSaveAudio);
    String uid = FirebaseAuth.instance.currentUser!.uid;
    DatabaseService dataBase = DatabaseService(uid);
    final destination = 'Sounds/$uid/${audioName.text}_${DateTime.now()}.mp3';
    dataBase.uploadFile(destination, file);
  }

  @override
  Widget build(BuildContext context) {
    NavigationController navigation =
        Provider.of<NavigationController>(context);

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
                                    Share.shareFiles([pathToSaveAudio]);
                                  },
                                ),
                                IconButton(
                                  onPressed: () async {
                                    await FlutterSoundHelper().convertFile(
                                        pathToSaveTemp,
                                        Codec.aacADTS,
                                        '/sdcard/Music/audio.mp3',
                                        Codec.mp3);
                                  },
                                  icon: Image(
                                    image:
                                        AssetImage("assets/PaperDownload1.png"),
                                  ),
                                ),
                                IconButton(
                                  icon: Image(
                                    image: AssetImage("assets/Delete.png"),
                                  ),
                                  onPressed: () {
                                    showAlertDialog(context);
                                  },
                                ),
                                SizedBox(
                                  width: 4,
                                ),
                                TextButton(
                                  onPressed: () {
                                    saveAudio();
                                    navigation.changeScreen(Audio.routeName);
                                  },
                                  child: Text("Сохранить"),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 40.0),
                            child: TextField(
                              textAlign: TextAlign.center,
                              controller: audioName,
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
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
                              children: [
                                TextButton(
                                  child: Text("Отменить"),
                                  onPressed: () {
                                    navigation
                                        .changeScreen(MainScreen.routeName);
                                  },
                                ),
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
