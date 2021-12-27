import 'dart:developer';
import 'dart:io';

import 'package:audio_story/models/audio.dart';
import 'package:audio_story/models/sounds.dart';
import 'package:audio_story/screens/category/card_info.dart';
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
    return await userCollection.doc(uid).update(
      {
        'Name': name,
      },
    );
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

  Future<void> updatePlayList(String image, String name, String info) async {
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

  Future<void> createPlayList(
      String image, String name, String info, var soundList) async {
    var playList = {
      'Image': image,
      'Name': name,
      'Info': info,
      'Sounds': soundList,
    };
    log(soundList.toString());
    DocumentSnapshot ds = await userCollection.doc(uid).get();
    var temp = ds.get('SaveList');
    temp.add(playList);
    await userCollection.doc(uid).update({
      'SaveList': temp,
    });
  }

  Future<void> deletePlayList(int index) async {
    DocumentSnapshot ds = await userCollection.doc(uid).get();
    List<dynamic> saveList = ds.get('SaveList');
    saveList.removeAt(index);
    await userCollection.doc(uid).update({
      'SaveList': saveList,
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

      audio.add({
        'name': temp.join('_'),
        'url': await result.items[i].getDownloadURL(),
      });

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
    var sounds = ds.get('SaveList');
    sounds = sounds[index];
    String bytes = sounds['Image'];
    SoundModel audioBase = SoundModel(
      sounds: ds.get('SaveList'),
      audioList: sounds['Sounds'],
      name: sounds['Name'],
      info: sounds['Info'],
      image: imageFromBase64String(bytes),
    );
    return audioBase;
  }

  // Future<void>sendMetaData(String name, bool isDeleted) async {
  //   Map<String, dynamic> newMetadata = {
  //     'name': name,
  //     'isDeleted': isDeleted
  //   };
  //   Database
  // }
}
