import 'dart:developer';

import 'package:audio_story/provider/navigation_provider.dart';
import 'package:audio_story/service/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Anonim extends StatefulWidget {
  const Anonim({Key? key}) : super(key: key);

  @override
  _AnonimState createState() => _AnonimState();
}

class _AnonimState extends State<Anonim> {

  final AuthService _auth = AuthService.instance;

  @override
  Widget build(BuildContext context) {
    NavigationController navigation =
        Provider.of<NavigationController>(context, listen: false);
    return GestureDetector(
      onTap: () async {
        User? res = await _auth.signInAnon();
        if (res != null) {
          navigation.changeScreen('/');
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