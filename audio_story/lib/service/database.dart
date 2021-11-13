
import 'dart:developer';

import 'package:audio_story/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class DatabaseService{

  String uid;

  DatabaseService(this.uid);
  
  final CollectionReference userCollection = FirebaseFirestore.instance.collection('users');

  Future updateUserData(String name,String? phonenumber) async {
    return await userCollection.doc(uid).set({
      'Name': name,
      'Phone number': phonenumber,
    });
  }
/*
  Future<void> getUsersCollectionFromFirebase() async {

    DocumentSnapshot snapshot = await userCollection.doc(uid).get();
    Map data = snapshot.data() as Map;
    var userData = data as List;

    userData.forEach((users) {
      CustomUser user = CustomUser.fromJson(users);
      _users.add(users);
      print(_users);
     });
  }*/

   Future<String> getCurrentUserData() async{
    try {
      DocumentSnapshot ds = await userCollection.doc(uid).get();
      String  name = ds.get('Name');
      return name;
    }catch(e){
      print(e.toString());
      return "DEFAULT";
    }
  }
}


  /*Future getUserName(String uid) async {
    return await userCollection.doc(uid).get();
  }*/
