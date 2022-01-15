import 'package:flutter/material.dart';

class Profile {
  String name;
  String phoneNumber;
  Image avatar;

  Profile({
    required this.name,
    required this.phoneNumber,
    required this.avatar,
  });

  @override
  String toString() {
    return "User data:\nUserName: $name,\nPhoneNumber: $phoneNumber";
  }
}
