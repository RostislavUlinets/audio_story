import 'dart:developer';
import 'dart:io';

import 'package:audio_story/blocs/record/record_bloc.dart';
import 'package:audio_story/blocs/record/record_event.dart';
import 'package:audio_story/provider/navigation_provider.dart';
import 'package:audio_story/resources/app_colors.dart';
import 'package:audio_story/resources/app_icons.dart';
import 'package:audio_story/widgets/custom_paint.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import 'widget/animation.dart';

typedef _Fn = void Function();

class Recorder extends StatefulWidget {
  const Recorder({
    Key? key,
  }) : super(key: key);

  @override
  _RecorderState createState() => _RecorderState();
}

class _RecorderState extends State<Recorder> {
  String? pathToSaveAudio;
  String? pathToSaveTemp;
  FlutterSoundRecorder? _mRecorder = FlutterSoundRecorder();
  bool _mRecorderIsInited = false;
  TextEditingController audioName =
      TextEditingController(text: 'Аудиозапись 1');
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
    _initPathForFiles();
  }

  @override
  void dispose() {
    stopRecorder();
    _mRecorder!.closeAudioSession();
    _mRecorder = null;
    super.dispose();
  }

  void record() async {
    log(pathToSaveTemp!);
    await _mRecorder!.startRecorder(
      toFile: pathToSaveTemp,
    );
    setState(() {});
  }

  Future<void> _initPathForFiles() async {
    Directory? path = await getExternalStorageDirectory();
    pathToSaveAudio = path!.path + '/audio.mp3';
    pathToSaveTemp = path.path + '/temp.aac';
  }

  Future<void> stopRecorder() async {
    await _mRecorder!.stopRecorder();
    await FlutterSoundHelper().convertFile(
      pathToSaveTemp,
      Codec.aacADTS,
      pathToSaveAudio!,
      Codec.mp3,
    );
  }

  _Fn? getRecorderFn() {
    if (!_mRecorderIsInited) {
      return null;
    }
    return _mRecorder!.isStopped
        ? record
        : () {
            stopRecorder()
                .then((value) => context.read<MyBloc>().add(EventB()));
          };
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const MyCustomPaint(
          color: AppColors.purpule,
          size: 0.85,
        ),
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.menu,
                      color: Colors.white,
                      size: 36,
                    ),
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
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
                          child: const Text("Отменить"),
                          onPressed: () {
                            final nav = context.read<NavigationProvider>();
                            nav.changeScreen(0);
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
                    child: SizedBox(
                      child: MusicVisualizer(),
                      height: 60,
                    ),
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
                borderRadius: const BorderRadius.all(Radius.circular(20)),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget buildStart() {
    final isRecording = _mRecorder!.isRecording;
    final image = isRecording
        ? Image(
            image: AppIcons.pause,
            color: AppColors.orange,
          )
        : Image(
            image: AppIcons.record,
            color: AppColors.orange,
          );

    return GestureDetector(
      onTap: getRecorderFn(),
      child: image,
    );

    // return ElevatedButton.icon(
    //   onPressed: getRecorderFn(),
    //   icon: Icon(icon),
    //   label: Text(text),
    //   style: ElevatedButton.styleFrom(
    //     primary: primary,
    //     onPrimary: onPrimary,
    //   ),
    // );
  }
}
