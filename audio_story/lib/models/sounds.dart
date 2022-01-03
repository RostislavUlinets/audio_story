import 'package:flutter/material.dart';

class SoundModel {
  final List<dynamic> sounds;
  final String name;
  final String info;
  final Image image;

  get getSounds => sounds;

  SoundModel({
    required this.sounds,
    required this.name,
    required this.info,
    required this.image,
  });
}
