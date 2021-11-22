import 'dart:async';

import 'package:audio_story/service/audio_records.dart';
import 'package:flutter/material.dart';

class AudioTimer extends StatefulWidget {

  const AudioTimer({Key? key}) : super(key: key);

  @override
  _AudioTimerState createState() => _AudioTimerState();
}

class _AudioTimerState extends State<AudioTimer> {

  final recorder = AudioRecord();
  Duration duration = const Duration();

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void addTimer(){
    const addSeconds = 1;
    setState(() {
      final seconds = duration.inSeconds + addSeconds;

      duration = Duration(seconds: seconds);
    });
  }

  void startTimer(){
    var timer = Timer.periodic(const Duration(seconds: 1), (_) => addTimer());
  }

  @override
  Widget build(BuildContext context) {
    String twoDigits(int n) => n.toString().padLeft(2,'0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return Text(
      '$minutes:$seconds',
      style: TextStyle(fontSize: 14,color: Colors.black),
    );
  }
}