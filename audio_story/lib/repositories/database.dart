import 'dart:developer';
import 'dart:io';

import 'package:audio_story/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class DatabaseService {
  String uid;

  DatabaseService(this.uid);

  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');
  static ListResult? audioList;

  Future<void> initUserData() async {
    var document = userCollection.doc(uid);
    document.get().then((doc) async => {
          if (doc.exists)
            {
              log("Document exist"),
              audioList =
                  await FirebaseStorage.instance.ref('Sounds/$uid/').listAll()
            }
          else
            {
              updateUserData(
                  'User', FirebaseAuth.instance.currentUser!.phoneNumber)
            }
        });
  }

  Future updateUserData(String name, String? phonenumber) async {
    return await userCollection.doc(uid).set({
      'Name': name,
      'Phone number': phonenumber,
    });
  }

  Future updateUserName(String name) async {
    return await userCollection.doc(uid).update({
      'Name': name,
    });
  }

  Future updateUserPhoneNumber(String phoneNumber) async {
    return await userCollection.doc(uid).update({
      'Phone number': phoneNumber,
    });
  }

  Future<String> getCurrentUserData() async {
    try {
      DocumentSnapshot ds = await userCollection.doc(uid).get();
      String name = ds.get('Name');
      return name;
    } catch (e) {
      log(e.toString());
      return "User";
    }
  }

  Future<String> getCurrentUserPhoneNumber() async {
    try {
      DocumentSnapshot ds = await userCollection.doc(uid).get();
      String phoneNumber = ds.get('Phone number');
      return phoneNumber;
    } catch (e) {
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

  ListResult? getAudioList() {
    return audioList;
  }

  // Future<void> setBase64(String image) async {
  //   DocumentSnapshot ds = await userCollection.doc(uid).get();
  //   var temp = ds.get('SaveList');
  //   temp = temp[0];
  //   temp.update('Image', (dynamic val) => val = image);
  //   log(temp.toString());
  //   //TODO: deleted return
  //   await userCollection.doc(uid).update({
  //     'SaveList': [temp],
  //   });
  // }

  Future<void> updatePlayList(String image,String name,String info) async {
    DocumentSnapshot ds = await userCollection.doc(uid).get();
    var temp = ds.get('SaveList');
    temp = temp[0];
    temp.update('Image', (dynamic val) => val = image);
    temp.update('Name', (dynamic val) => val = name);
    temp.update('Info', (dynamic val) => val = info);
    await userCollection.doc(uid).update({
      'SaveList': [temp],
    });
  }

  Future<void> createPlayList(String image,String name,String info) async {
    var playLit = {
      'Image' : image,
      'Name' : name,
      'Info' : info,
      'Sounds' : [
        {
          'Name' : "AudioName",
          'URL' : "https://firebasestorage.googleapis.com/v0/b/audiostorysl.appspot.com/o/Sounds%2FvlzG8jhQYWVx7dVkeiMdLrzbYpp1%2FSecond_Test_On_Split_2021-12-02%2020%3A39%3A51.904729.mp3?alt=media&token=bfc3e4e6-d206-4b2c-97c9-404129a037f2"
        }
      ]
    };
    DocumentSnapshot ds = await userCollection.doc(uid).get();
    var temp = ds.get('SaveList');
    temp.add(playLit);
    log(temp.toString());
    await userCollection.doc(uid).update({
      'SaveList': temp,
    });
  }
}
