import 'dart:developer';

import 'package:audio_story/models/user.dart';
import 'package:audio_story/screens/login_screen/code_sent.dart';
import 'package:audio_story/repositories/database.dart';
import 'package:audio_story/screens/login_screen/final_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  const AuthService._();

  static const AuthService instance = AuthService._();

  CustomUser? _userFromFirebaseUser(User user) {
    return CustomUser(uid: user.uid, name: "User", phoneNumber: "");
  }

  Stream<CustomUser?> get user {
    return _auth
        .authStateChanges()
        .map((User? user) => _userFromFirebaseUser(user!));
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  static bool isAnonymous() {
    return _auth.currentUser!.isAnonymous;
  }

  // sign in anon
  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      return _userFromFirebaseUser(user!);
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  Future loginUser(String phone, BuildContext context) async {
    _auth.verifyPhoneNumber(
      phoneNumber: phone,
      timeout: const Duration(seconds: 60),
      verificationCompleted: (AuthCredential credential) async {
        UserCredential res = await _auth.signInWithCredential(credential);
        User? user = res.user;

        if (user != null) {
          _userFromFirebaseUser(user);
          DatabaseService _dataBase = DatabaseService(user.uid);
          _dataBase.initUserData();
          Navigator.pushNamed(context, FinalScreen.routeName);
        } else {
          log("Error");
        }
      },
      verificationFailed: (FirebaseAuthException exception) {
        log(exception.toString());
      },
      codeSent: (String verificationId, int? resendToken) async {
        try {
          final code = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CodeSent(),
              ));
          AuthCredential credential = PhoneAuthProvider.credential(
              verificationId: verificationId, smsCode: code);

          UserCredential result = await _auth.signInWithCredential(credential);

          User? user = result.user;

          if (user != null) {
            _userFromFirebaseUser(user);
            DatabaseService _dataBase = DatabaseService(user.uid);
            _dataBase.initUserData();
            Navigator.pop(context, result);
            Navigator.pushNamed(context, FinalScreen.routeName);
          } else {
            log("Error");
          }
        } catch (e) {
          log('Failed with error code: ${e.toString()}');
        }
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }
}
