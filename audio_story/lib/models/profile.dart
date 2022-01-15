import 'package:flutter/material.dart';

class ProfileModel {
  String name;
  String phoneNumber;
  Image avatar;

  ProfileModel({
    required this.name,
    required this.phoneNumber,
    required this.avatar,
  });

  @override
  String toString() {
    return "User data:\nUserName: $name,\nPhoneNumber: $phoneNumber,\n Avatar: ${avatar.toString()}}";
  }
}
