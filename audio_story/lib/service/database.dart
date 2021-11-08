
import 'package:audio_story/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class DatabaseService{

  final String uid;

  DatabaseService(this.uid);

  final CollectionReference userCollection = FirebaseFirestore.instance.collection('users');

  Future updateUserData(String name,String? phonenumber) async {
    return await userCollection.doc(uid).set({
      'Name': name,
      'Phone number': phonenumber,
    });
  }

  List<CustomUser> _userListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.docs.map((doc){
      return CustomUser(
        name: doc.get('Name') ?? '',
        phone: doc.get('Phone number') ?? 0
      );
    }).toList();
  }
  

  Stream<List<CustomUser>> get users {
    return userCollection.snapshots()
      .map(_userListFromSnapshot);
  }

  /*Future getUserName(String uid) async {
    return await userCollection.doc(uid).get();
  }*/


}