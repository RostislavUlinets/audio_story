import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:audio_story/models/audio.dart';
import 'package:audio_story/models/sounds.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
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
      'name': 'User',
      'phone': FirebaseAuth.instance.currentUser!.phoneNumber,
    });
    Map<String, dynamic> myMap = {};
    await soundCollection.doc(uid).set(myMap);
  }

  Future updateUserData(String name, String? phonenumber) async {
    return await userCollection.doc(uid).set({
      'name': name,
      'phone': phonenumber,
    });
  }

  Future<void> deleteUser() async {
    try {
      userCollection.doc(uid).delete();
      soundCollection.doc(uid).delete();
    } catch (e) {}
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

  Future<void> addAudio(String destination, String name) async {
    Reference result = FirebaseStorage.instance.ref(destination);

    String url = await result.getDownloadURL();
    String audioId = const Uuid().v1().toString();

    Map<String, dynamic> audioInfo = {
      'id': audioId,
      'name': name,
      'url': url,
      'isDeleted': false
    };
    await soundCollection.doc(uid).update({audioId: audioInfo});
  }

  ListResult? getAudioList() {
    return audioList;
  }

  Future<void> createPlayList(String image, String name, String info,
      List<AudioModel>? soundList) async {
    DocumentSnapshot ds = await userCollection.doc(uid).get();
    List<dynamic> saveList;

    List<String> sounds = [];
    try {
      saveList = ds.get('saveList');
    } catch (e) {
      saveList = [];
    }

    for (int i = 0; i < soundList!.length; i++) {
      sounds.add(soundList[i].id);
    }
    Map<String, dynamic> playList = {
      'image': image,
      'name': name,
      'info': info,
      'sounds': sounds,
    };

    saveList.add(playList);
    await userCollection.doc(uid).update({
      'saveList': saveList,
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
    soundsIndex.forEach(
      (element) {
        sounds.removeAt(element);
      },
    );
    soundsList[index]['Sounds'] = sounds;
    await userCollection.doc(uid).update({
      'SaveList': soundsList,
    });
    log(sounds.toString());
  }

  Future<void> fullDeleteAudio(List<String> selected) async {
    for (int i = 0; i < selected.length; i++) {
      await soundCollection.doc(uid).update({selected[i]: FieldValue.delete()});
    }
  }

  Future<List<AudioModel>> getPlayListAudio(List<dynamic> sounds) async {
    if (sounds.isEmpty) return [];
    List<AudioModel> audioFromModel = [];
    DocumentSnapshot document = await soundCollection.doc(uid).get();
    Map<String, dynamic> map = document.data() as Map<String, dynamic>;
    for (int i = 0; i < sounds.length; i++) {
      if (map[sounds[i]] == null || map[sounds[i]]['isDeleted']) continue;

      audioFromModel.add(
        AudioModel(
          id: map[sounds[i]]['id'],
          name: map[sounds[i]]['name'],
          url: map[sounds[i]]['url'],
        ),
      );
    }
    return audioFromModel;
  }

  Future<List<AudioModel>> audioListDB() async {
    if (FirebaseAuth.instance.currentUser!.isAnonymous) return [];

    List<AudioModel> audioFromModel = [];
    String uid = FirebaseAuth.instance.currentUser!.uid;
    DocumentSnapshot document = await soundCollection.doc(uid).get();
    Map<String, dynamic> map = document.data() as Map<String, dynamic>;
    for (var key in map.keys) {
      if (map[key]['isDeleted'] == false) {
        audioFromModel.add(
          AudioModel(
            id: map[key]['id'],
            name: map[key]['name'],
            url: map[key]['url'],
          ),
        );
      }
    }
    return audioFromModel;
  }

  Future<void> deleteAudio(String id) async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    DocumentSnapshot document = await soundCollection.doc(uid).get();
    Map<String, dynamic> doc = document.get(id);
    doc['isDeleted'] = true;
    await soundCollection.doc(uid).update({
      id: doc,
    });
  }

  Future<void> recoverAudio(String id) async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    DocumentSnapshot document = await soundCollection.doc(uid).get();
    Map<String, dynamic> doc = document.get(id);
    doc['isDeleted'] = false;
    await soundCollection.doc(uid).update({
      id: doc,
    });
  }

  Future<List<AudioModel>> getDeletedAudio() async {
    List<AudioModel> audioFromModel = [];
    String uid = FirebaseAuth.instance.currentUser!.uid;
    DocumentSnapshot document = await soundCollection.doc(uid).get();
    Map<String, dynamic> map = document.data() as Map<String, dynamic>;
    for (var key in map.keys) {
      if (map[key]['isDeleted'] == true) {
        audioFromModel.add(
          AudioModel(
            id: map[key]['id'],
            name: map[key]['name'],
            url: map[key]['url'],
          ),
        );
      }
    }
    return audioFromModel;
  }

  Image imageFromBase64String(String base64String) {
    return Image.memory(base64Decode(base64String));
  }

  Future<SoundModel> getSaveList(int index) async {
    DocumentSnapshot ds =
        await userCollection.doc(FirebaseAuth.instance.currentUser!.uid).get();
    var sounds = ds.get('saveList');
    sounds = sounds[index];
    String bytes = sounds['image'];
    SoundModel audioBase = SoundModel(
      sounds: sounds['sounds'],
      name: sounds['name'],
      info: sounds['info'],
      image: imageFromBase64String(bytes),
    );
    return audioBase;
  }

  Future<List<Map<String, dynamic>>> getPlayListImages() async {
    try {
      DocumentSnapshot ds = await userCollection
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();

      List<Map<String, dynamic>> res = [];
      List<dynamic> playList = ds.get('saveList');
      if (playList.length > 2) {
        for (int i = 0; i < 3; i++) {
          String bytes = playList[i]['image'];
          res.add({
            'name': playList[i]['name'],
            'image': imageFromBase64String(bytes)
          });
        }
        return res;
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }

  Future<List<String>> getPlayListNames() async {
    DocumentSnapshot ds =
        await userCollection.doc(FirebaseAuth.instance.currentUser!.uid).get();

    List<dynamic> playList = ds.get('saveList');
    List<String> result = [];
    if (playList.length > 2) {
      for (int i = 0; i < 3; i++) {
        result.add(playList[i]['name']);
      }
      return result;
    } else {
      return [];
    }
  }
}
