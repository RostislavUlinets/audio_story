import 'dart:developer';
import 'dart:io';

import 'package:audio_story/models/audio.dart';
import 'package:audio_story/models/sounds.dart';
import 'package:audio_story/screens/category/card_info.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class DatabaseService {
  String uid;

  DatabaseService(this.uid);

  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');
  final CollectionReference soundCollection = 
      FirebaseFirestore.instance.collection('sounds');
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
              createUserData(),
            }
        });
  }
  Future<void> createUserData() async {
    await userCollection.doc(uid).set({
      'name' : 'User',
      'phone' : FirebaseAuth.instance.currentUser!.phoneNumber,
    });
    Map<String,dynamic> myMap ={};
    await soundCollection.doc(uid).set(myMap);
  }

  Future updateUserData(String name, String? phonenumber) async {
    return await userCollection.doc(uid).set({
      'name': name,
      'phone': phonenumber,
    });
  }

  Future updateUserName(String name) async {
    return await userCollection.doc(uid).update(
      {
        'name': name,
      },
    );
  }

  Future updateUserPhoneNumber(String phoneNumber) async {
    return await userCollection.doc(uid).update({
      'phone': phoneNumber,
    });
  }

  Future<String> getCurrentUserData() async {
    try {
      DocumentSnapshot ds = await userCollection.doc(uid).get();
      String name = ds.get('name');
      return name;
    } catch (e) {
      log(e.toString());
      return "User";
    }
  }

  Future<String> getCurrentUserPhoneNumber() async {
    try {
      DocumentSnapshot ds = await userCollection.doc(uid).get();
      String phoneNumber = ds.get('phone');
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

  Future<void> addAudio(String destination,String name) async {
    Reference result =
         FirebaseStorage.instance.ref(destination);
    Map<String,dynamic> audioInfo = {
      'name' : name,
      'url' : result.getDownloadURL(),
      'isDeleted' : false
    };
    Uuid().
    await soundCollection.doc(uid).set({
      audioId : audioInfo
    });
  }

  ListResult? getAudioList() {
    return audioList;
  }

  Future<void> createPlayList(
      String image, String name, String info, var soundList) async {
    var playList = {
      'image': image,
      'name': name,
      'info': info,
      'sounds': soundList,
    };
    log(soundList.toString());
    DocumentSnapshot ds = await userCollection.doc(uid).get();
    var temp = ds.get('saveList');
    temp.add(playList);
    await userCollection.doc(uid).update({
      'saveList': temp,
    });
  }

  Future<void> deletePlayList(int index) async {
    DocumentSnapshot ds = await userCollection.doc(uid).get();
    List<dynamic> saveList = ds.get('saveList');
    saveList.removeAt(index);
    await userCollection.doc(uid).update({
      'saveList': saveList,
    });
    log("YEAH!");
  }

  Future<void> deleteSounds(int index, List<int> soundsIndex) async {
    DocumentSnapshot ds = await userCollection.doc(uid).get();
    List<dynamic> soundsList = ds.get('SaveList');
    var sounds = soundsList[index]['Sounds'];
    soundsIndex.forEach((element) {
      sounds.removeAt(element);
    });
    soundsList[index]['Sounds'] = sounds;
    await userCollection.doc(uid).update({
      'SaveList': soundsList,
    });
    log(sounds.toString());
  }

  Future<List<AudioModel>> audioListDB() async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    ListResult result =
        await FirebaseStorage.instance.ref('Sounds/$uid/').listAll();
    List<Map<String, dynamic>> audio = [];
    List<AudioModel> audioFromModel = [];

    for (int i = 0; i < result.items.length; i++) {
      List<String> temp = result.items[i].name.split('_');
      temp.removeLast();

      audioFromModel.add(
        AudioModel(
          name: temp.join('_'),
          url: await result.items[i].getDownloadURL(),
        ),
      );
    }
    return audioFromModel;
  }

  Future<SoundModel> getSaveList(int index) async {
    DocumentSnapshot ds =
        await userCollection.doc(FirebaseAuth.instance.currentUser!.uid).get();
    var sounds = ds.get('saveList');
    sounds = sounds[index];
    String bytes = sounds['image'];
    SoundModel audioBase = SoundModel(
      sounds: ds.get('saveList'),
      audioList: sounds['sounds'],
      name: sounds['name'],
      info: sounds['info'],
      image: imageFromBase64String(bytes),
    );
    return audioBase;
  }


}
