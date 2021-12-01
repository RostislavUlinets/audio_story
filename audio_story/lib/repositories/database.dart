
import 'dart:developer';
import 'dart:io';

import 'package:audio_story/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class DatabaseService{

  String uid;

  DatabaseService(this.uid);
  
  final CollectionReference userCollection = FirebaseFirestore.instance.collection('users');

  Future<void> initUserData() async {
    var document = userCollection.doc(uid);
    document.get().then((doc) => {
      if(doc.exists){
        log("Document exist"),
      }else{
        updateUserData('User',FirebaseAuth.instance.currentUser!.phoneNumber)
      }
    });
  }

  Future updateUserData(String name,String? phonenumber) async {
    return await userCollection.doc(uid).set({
      'Name': name,
      'Phone number': phonenumber,
    });
  }

  Future updateUserName(String name)async {
    return await userCollection.doc(uid).update({
      'Name': name,
    });
  }

  Future updateUserPhoneNumber(String phoneNumber)async {
    return await userCollection.doc(uid).update({
      'Phone number': phoneNumber,
    });
  }

   Future<String> getCurrentUserData() async{
    try {
      DocumentSnapshot ds = await userCollection.doc(uid).get();
      String  name = ds.get('Name');
      return name;
    }catch(e){
      log(e.toString());
      return "User";
    }
  }

  Future<String> getCurrentUserPhoneNumber() async{
    try {
      DocumentSnapshot ds = await userCollection.doc(uid).get();
      String  phoneNumber = ds.get('Phone number');
      return phoneNumber;
    }catch(e){
      log(e.toString());
      return "User";
    }
  }

  UploadTask? uploadFile(String destination, File file) {
    try {
      final ref = FirebaseStorage.instance.ref(destination);
      return ref.putFile(file);
    } on FirebaseException {
      return null;
    }
  }
}