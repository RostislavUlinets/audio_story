import 'package:audio_story/models/audio.dart';
import 'package:flutter/material.dart';

class CardInfoModel {
  final List<AudioModel> sounds;
  final String name;
  final String info;
  final Image image;

  get getSounds => sounds;

  CardInfoModel({
    required this.sounds,
    required this.name,
    required this.info,
    required this.image,
  });
}
