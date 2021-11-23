import 'dart:io';

import 'package:audio_story/Colors/colors.dart';
import 'package:audio_story/service/auth.dart';
import 'package:audio_story/repositories/database.dart';
import 'package:audio_story/widgets/bottomnavbar.dart';
import 'package:audio_story/widgets/custom_paint.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

File? file;
User? currentUser = FirebaseAuth.instance.currentUser;
String uid = FirebaseAuth.instance.currentUser!.uid;

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _ProfileState();
}

class _ProfileState extends State<EditProfile> {
  DatabaseService dataBase =
      DatabaseService(FirebaseAuth.instance.currentUser!.uid);
  final _userName = TextEditingController();
  final _phoneController = TextEditingController();
  var maskFormatter = MaskTextInputFormatter(
      mask: '+## (###) ###-##-##', filter: {"#": RegExp(r'[0-9]')});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: const CustomNavigationBar(4),
      body: Stack(
        children: [
          MyCustomPaint(
            color: CColors.purpule,
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 40,
              right: 10,
              left: 10,
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          color: Colors.white,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Image.asset('assets/ArrowBack.png'),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 55,
                      ),
                      const Text(
                        "Подписка",
                        style: TextStyle(
                            fontSize: 36,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const Text(
                    "Твоя частичка",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      child: IconButton(
                        onPressed: () {
                          selectFile();
                        },
                        icon: Image.asset('assets/Camera.png'),
                      ),
                      height: 200,
                      width: 200,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: const AssetImage(
                            "assets/selfi.jpg",
                          ),
                          colorFilter: ColorFilter.mode(
                              Colors.black.withOpacity(0.6), BlendMode.dstATop),
                          fit: BoxFit.cover,
                        ),
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 100.0, vertical: 30),
                    child: TextField(
                      readOnly: false,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 24),
                      controller: _userName,
                      decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 30, bottom: 10, right: 50, left: 50),
                    child: Material(
                      borderRadius: BorderRadius.circular(60.0),
                      elevation: 5,
                      shadowColor: Colors.grey,
                      child: TextField(
                        readOnly: false,
                        inputFormatters: [maskFormatter],
                        textAlign: TextAlign.center,
                        controller: _phoneController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(60.0),
                          ),
                        ),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      if(file != null){
                        uploadFile();
                      }                    
                      //final phone = _phoneController.text.trim();
                      //dataBase.updateUserData(_userName.text, phone);
                      if (_userName.text.trim().isNotEmpty) {
                        dataBase.updateUserName(_userName.text.trim());
                      }
                      //AuthService.instance.loginUser(phone, context);
                      //navigation.changeScreen('/profile');
                      if (_phoneController.text.trim().isNotEmpty) {
                        const _auth = AuthService.instance;
                        _auth.loginUser(_phoneController.text.trim(), context);
                        dataBase.updateUserPhoneNumber(
                            _phoneController.text.trim());
                      }
                    },
                    child: Text(
                      "Сохранить",
                      style: TextStyle(color: CColors.black),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Future<Widget> userName() async {
  DatabaseService dataBase =
      DatabaseService(FirebaseAuth.instance.currentUser!.uid);
  return Text(
    await dataBase.getCurrentUserData(),
    style: const TextStyle(fontSize: 24),
  );
}

Future selectFile() async {
  final result = await FilePicker.platform.pickFiles(allowMultiple: false);

  if (result == null) return;

  final path = result.files.single.path;

  file = File(path!);
}

Future uploadFile() async {
  DatabaseService dataBase =
      DatabaseService(FirebaseAuth.instance.currentUser!.uid);
  final destination = 'Avatars/$uid/avatar.jpg';
  dataBase.uploadFile(destination, file!);
}
