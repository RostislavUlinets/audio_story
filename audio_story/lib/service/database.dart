
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

   Future<String> getCurrentUserData() async{
    try {
      DocumentSnapshot ds = await userCollection.doc(uid).get();
      String  name = ds.get('Name');
      //CustomUser.fromJson(ds.data());
      return name;
    }catch(e){
      print(e.toString());
      return "DEFAULT";
    }
  }
}