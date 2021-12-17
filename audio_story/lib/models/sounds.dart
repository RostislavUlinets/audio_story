
import 'package:flutter/material.dart';

class SoundModel {
  final sounds;
  final audioList;
  final String name;
  final String info;
  final Image image;

  get getSounds => sounds;

  SoundModel({
    required this.sounds,
    required this.audioList,
    required this.name,
    required this.info,
    required this.image,
  });
}