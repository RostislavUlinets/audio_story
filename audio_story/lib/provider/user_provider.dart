import 'package:audio_story/models/user.dart';
import 'package:audio_story/service/auth.dart';
import 'package:audio_story/service/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

/*class UserProvider extends ChangeNotifier {
  
  CustomUser user = CustomUser(uid: FirebaseAuth.instance.currentUser!.uid,name: "User",phoneNumber: "");

  void changeData(String uid,String name,String phoneNumber){
    user = CustomUser(uid: uid,name: name,phoneNumber: phoneNumber);
    notifyListeners();
  }*/

  class CodeProvider extends ChangeNotifier {
  
  String code = "";

  void changeCode(String code){
    code = code;
    notifyListeners();
  }


}