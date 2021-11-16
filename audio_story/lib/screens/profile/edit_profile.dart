import 'dart:developer';
import 'dart:io';

import 'package:audio_story/Colors/colors.dart';
import 'package:audio_story/models/user.dart';
import 'package:audio_story/provider/navigation_provider.dart';
import 'package:audio_story/screens/profile/widgets/dialog.dart';
import 'package:audio_story/service/database.dart';
import 'package:audio_story/widgets/bottomnavbar.dart';
import 'package:audio_story/widgets/custom_paint.dart';
import 'package:audio_story/widgets/side_menu.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:audio_story/service/auth.dart';
import 'package:provider/provider.dart';
import 'package:path/path.dart';

late File file;
User? currentUser = FirebaseAuth.instance.currentUser;
String uid = FirebaseAuth.instance.currentUser!.uid;

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _ProfileState();
}

class _ProfileState extends State<EditProfile> {
  final AuthService _auth = AuthService.instance;
  DatabaseService dataBase =
      DatabaseService(FirebaseAuth.instance.currentUser!.uid);
  final _userName = TextEditingController();
  final _phoneController = TextEditingController();
  var maskFormatter = MaskTextInputFormatter(
      mask: '+## (###) ###-##-##', filter: {"#": RegExp(r'[0-9]')});

  @override
  Widget build(BuildContext context) {
    NavigationController navigation =
        Provider.of<NavigationController>(context, listen: false);
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: const CustomNavigationBar(4),
      body: Stack(
        children: [
          const MyCustomPaint(
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
                          image: AssetImage(
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
                    padding:
                        EdgeInsets.symmetric(horizontal: 100.0, vertical: 30),
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
                      /*final _codeController = TextEditingController();
                      if (_phoneController.toString() != null) {
                        FirebaseAuth.instance.verifyPhoneNumber(
                            phoneNumber: _phoneController.toString(),
                            timeout: const Duration(minutes: 2),
                            verificationCompleted: (credential) async {
                              await (await FirebaseAuth.instance.currentUser!)
                                  .updatePhoneNumber(credential);
                              // either this occurs or the user needs to manually enter the SMS code
                            },
                            verificationFailed:
                                (FirebaseAuthException exception) {
                              log(exception.toString());
                            },
                            codeSent:
                                (String verificationId, int? resendToken) {
                              showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (context) {
                                  return AlertDialog(
                                    title: const Text("Give the code?"),
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        TextField(
                                          controller: _codeController,
                                        ),
                                      ],
                                    ),
                                    actions: <Widget>[
                                      FlatButton(
                                        child: const Text("Confirm"),
                                        textColor: Colors.white,
                                        color: Colors.blue,
                                        onPressed: () async {
                                          final code =
                                              _codeController.text.trim();
                                          AuthCredential credential =
                                              PhoneAuthProvider.credential(
                                                  verificationId:
                                                      verificationId,
                                                  smsCode: code);
                                        },
                                      )
                                    ],
                                  );
                                },
                              );
                            },
                            codeAutoRetrievalTimeout: (String verificationId) {});
                      }*/
                      //final phone = _phoneController.text.trim();
                      //dataBase.updateUserData(_userName.text, phone);
                      uploadFile();
                      //AuthService.instance.loginUser(phone, context);
                      //navigation.changeScreen('/profile');
                    },
                    child: const Text(
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
    style: TextStyle(fontSize: 24),
  );
}

Future selectFile() async {
  final result = await FilePicker.platform.pickFiles(allowMultiple: false);

  if (result == null) return;

  final path = result.files.single.path;

  file = File(path!);
}

Future uploadFile() async {
  if (file == null) return;

  final fileName = basename(file.path);

  final destination = 'Avatars/$uid/avatar.jpg';

  FirebaseApi.uploadFile(destination, file);
}

class FirebaseApi {
  static UploadTask? uploadFile(String destination, File file) {
    try {
      final ref = FirebaseStorage.instance.ref(destination);
      return ref.putFile(file);
    } on FirebaseException catch (e) {
      return null;
    }
  }
}

Future<void> downloadURLExample() async {
  String downloadURL = await FirebaseStorage.instance
      .ref('Avatars/$uid/avatar.jpg')
      .getDownloadURL();
}
