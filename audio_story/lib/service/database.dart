import 'package:cloud_firestore/cloud_firestore.dart';

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

}