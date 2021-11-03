import 'dart:developer';

import 'package:audio_story/provider/navigation_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthService {
  
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // sign in anon
  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      return user;
    } catch (e) {
      log(e.toString());
      return null;
    }

  }

  Future loginUser(String phone, BuildContext context) async {

    final _codeController = TextEditingController();

    _auth.verifyPhoneNumber(
      phoneNumber: phone,
      timeout: const Duration(seconds: 60),
      verificationCompleted: (AuthCredential credential) async {
        UserCredential res = await _auth.signInWithCredential(credential);
        User? user = res.user;

        if (user != null) {
          NavigationController navigation =
              Provider.of<NavigationController>(context, listen: false);
          navigation.changeScreen('/');
        } else {
          log("Error");
        }
      },
      verificationFailed: (FirebaseAuthException exception) {
        log(exception.toString());
      },
      codeSent: (String verificationId, int? resendToken) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return AlertDialog(
              title: const Text("Give the code?"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TextField(
                    controller: _codeController,
                  ),
                ],
              ),
              actions: <Widget>[
                FlatButton(
                  child: const Text("Confirm"),
                  textColor: Colors.white,
                  color: Colors.blue,
                  onPressed: () async {
                    final code = _codeController.text.trim();
                    AuthCredential credential = PhoneAuthProvider.credential(
                        verificationId: verificationId, smsCode: code);

                    UserCredential result =
                        await _auth.signInWithCredential(credential);

                    User? user = result.user;

                    if (user != null) {
                      Navigator.pop(context, result);
                      NavigationController navigation =
                          Provider.of<NavigationController>(context,
                              listen: false);
                      navigation.changeScreen('/splash');
                    } else {
                      log("Error");
                    }
                  },
                )
              ],
            );
          },
        );
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }
}
