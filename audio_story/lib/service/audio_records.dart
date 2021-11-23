
import 'package:flutter_sound_lite/public/flutter_sound_recorder.dart';
import 'package:permission_handler/permission_handler.dart';

const pathToSaveAudio = '/sdcard/Download/temp.aac';

class AudioRecord {

  FlutterSoundRecorder? _audioRecorder;
  bool _isRecorderInitialised = false;

  bool get isRecording => _audioRecorder!.isRecording;

  Future init() async {
    _audioRecorder = FlutterSoundRecorder();
    final status = await Permission.microphone.request();
    final secondStatus = await Permission.storage.request();
    if (status != PermissionStatus.granted && secondStatus != PermissionStatus.granted) {
      throw RecordingPermissionException('Microphone permission error');
    }

    await _audioRecorder!.openAudioSession();
    _isRecorderInitialised = true;
  }

  void dispose() {
    if (!_isRecorderInitialised) return;

    _audioRecorder!.closeAudioSession();
    _audioRecorder = null;
    _isRecorderInitialised = false;
  }

  Future record() async {
    if (!_isRecorderInitialised) return;

    await _audioRecorder!.startRecorder(toFile: pathToSaveAudio);
  }

  Future stop() async {
    if (!_isRecorderInitialised) return;

    await _audioRecorder!.stopRecorder();
  }

  Future toggleRecording() async {
    if (_audioRecorder!.isStopped) {
      await record();
    } else {
      await stop();
    }
  }
}