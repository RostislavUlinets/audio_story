import 'dart:developer';

import 'package:audio_story/models/user.dart';
import 'package:audio_story/route_bar.dart';
import 'package:audio_story/service/auth.dart';
import 'package:flutter/material.dart';

class Anonim extends StatefulWidget {
  const Anonim({Key? key}) : super(key: key);

  @override
  _AnonimState createState() => _AnonimState();
}

class _AnonimState extends State<Anonim> {
  final AuthService _auth = AuthService.instance;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        CustomUser? res = await _auth.signInAnon();
        if (res != null) {
          Navigator.of(context, rootNavigator: true).pushNamedAndRemoveUntil(
            Initilizer.routeName,
            (route) => false,
          );
        } else {
          log("Error with anonim auth");
        }
      },
      child: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Text(
          "Позже",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
