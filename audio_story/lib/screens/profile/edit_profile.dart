import 'dart:io';
import 'package:audio_story/models/profile.dart';
import 'package:audio_story/resources/app_colors.dart';
import 'package:audio_story/resources/app_icons.dart';
import 'package:audio_story/service/auth.dart';
import 'package:audio_story/repositories/database.dart';
import 'package:audio_story/widgets/bottomnavbar.dart';
import 'package:audio_story/widgets/custom_paint.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

File? file;
User? currentUser = FirebaseAuth.instance.currentUser;
String uid = FirebaseAuth.instance.currentUser!.uid;

class EditProfile extends StatefulWidget {
  final Profile user;

  const EditProfile({Key? key, required this.user}) : super(key: key);

  @override
  State<EditProfile> createState() => _ProfileState();
}

class _ProfileState extends State<EditProfile> {
  DatabaseService dataBase =
      DatabaseService(FirebaseAuth.instance.currentUser!.uid);

  late final Profile user;
  TextEditingController _userName = TextEditingController();
  TextEditingController _phoneController = TextEditingController();

  var maskFormatter = MaskTextInputFormatter(
    mask: '+## (###) ###-##-##',
    filter: {"#": RegExp(r'[0-9]')},
  );

  final _auth = AuthService.instance;

  @override
  void initState() {
    user = widget.user;
    _userName.text = user.name;
    _phoneController.text = user.phoneNumber;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const MyCustomPaint(
          color: AppColors.purpule,
          size: 0.85,
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
                          icon: Image(
                            image: AppIcons.arrowLeftInCircle,
                          ),
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
                      icon: Image(
                        image: AppIcons.camera,
                      ),
                    ),
                    height: 200,
                    width: 200,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: user.avatar.image,
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
                      onEditingComplete: () => _auth.loginUser(
                          _phoneController.text.trim(), context),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    dataBase.updataUserData(
                      name: _userName.text,
                      phoneNumber: _phoneController.text,
                      avatar: file,
                    );
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "Сохранить",
                    style: TextStyle(color: AppColors.black),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

Future selectFile() async {
  final result = await ImagePicker.platform.pickImage(
      source: ImageSource.gallery,
      imageQuality: 25,
      maxHeight: 300,
      maxWidth: 400);

  if (result == null) return;

  file = File(result.path);
}
