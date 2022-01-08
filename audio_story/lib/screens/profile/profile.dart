import 'dart:developer';

import 'package:audio_story/Colors/colors.dart';
import 'package:audio_story/screens/login_screen/welcome_screen.dart';
import 'package:audio_story/screens/profile/edit_profile.dart';
import 'package:audio_story/screens/profile/widgets/dialog.dart';
import 'package:audio_story/repositories/database.dart';
import 'package:audio_story/widgets/bottomnavbar.dart';
import 'package:audio_story/widgets/custom_paint.dart';
import 'package:audio_story/widgets/side_menu.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:audio_story/service/auth.dart';
import 'package:provider/provider.dart';

String downloadURL = 'https://picsum.photos/250?image=9';

class Profile extends StatefulWidget {
  static const routeName = '/profile';

  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final user = FirebaseAuth.instance.currentUser;
  final AuthService _auth = AuthService.instance;
  DatabaseService dataBase =
      DatabaseService(FirebaseAuth.instance.currentUser!.uid);

  String phoneNumber = '', userName = "USER";
  Image image = Image.asset('assets/anon_ava.jpg');

  var maskFormatter = MaskTextInputFormatter(
      mask: '+## (###) ###-##-##', filter: {"#": RegExp(r'[0-9]')});

  @override
  void initState() {
    getUserName();
    getUserPhoneNumber();
    downloadURLExample();
    super.initState();
  }

  Future<void> downloadURLExample() async {
    if (user!.isAnonymous == false) {
      try {
        downloadURL = await FirebaseStorage.instance
            .ref('Avatars/$uid/avatar.jpg')
            .getDownloadURL();
        setState(() {
          image = Image.network(
            downloadURL,
            fit: BoxFit.cover,
          );
        });
      } catch (e) {
        log("DownloadURL error");
      }
    }
  }

  Future<void> getUserName() async {
    if (user!.isAnonymous == false) {
      try {
        String? temp = await dataBase.getCurrentUserData();
        setState(() {
          userName = temp;
        });
      } catch (e) {
        log("getUserName error");
      }
    }
  }

  Future<void> getUserPhoneNumber() async {
    if (user!.isAnonymous == false) {
      phoneNumber = user!.phoneNumber!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      drawer: const SideMenu(),
      bottomNavigationBar: const CustomNavigationBar(4),
      body: Stack(
        children: [
          const MyCustomPaint(
            color: CColors.purpule,
            size: 0.85,
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 40,
              right: 10,
              left: 10,
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Builder(
                      builder: (ctx) => IconButton(
                        icon: const Icon(
                          Icons.menu,
                          color: Colors.white,
                          size: 36,
                        ),
                        onPressed: () {
                          Scaffold.of(ctx).openDrawer();
                        },
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
                  child: SizedBox(
                    child: image,
                    height: 200,
                    width: 200,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Builder(builder: (context) {
                    return Text(
                      userName,
                      style: const TextStyle(fontSize: 24),
                    );
                  }),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50.0),
                  child: Material(
                    borderRadius: BorderRadius.circular(60.0),
                    elevation: 5,
                    shadowColor: Colors.grey,
                    child: TextField(
                      readOnly: true,
                      inputFormatters: [maskFormatter],
                      textAlign: TextAlign.center,
                      controller: TextEditingController(text: phoneNumber),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(60.0),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextButton(
                      child: const Text(
                        "Редактировать",
                        style: TextStyle(fontSize: 14),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EditProfile(
                                    image: image,
                                  )),
                        );
                      }),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: Text(
                    "Подписки",
                    style: TextStyle(fontSize: 14),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 20.0, bottom: 10, right: 30, left: 30),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: const LinearProgressIndicator(
                      color: Color(0xFFF1B488),
                      value: 20,
                      semanticsLabel: 'Linear progress indicator',
                      minHeight: 20,
                    ),
                  ),
                ),
                const Text(
                  "150/500мб",
                ),
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    children: [
                      TextButton(
                        onPressed: () {
                          FirebaseAuth.instance.signOut();
                          Navigator.pushNamed(context, WelcomeScreen.routeName);
                        },
                        child: const Text("Выйти из приложения",
                            style: TextStyle(
                              color: CColors.black,
                            )),
                      ),
                      const Spacer(),
                      TextButton(
                        onPressed: () {
                          showAlertDialog(context);
                        },
                        child: const Text(
                          "Удалить аккаунт",
                          style: TextStyle(color: Color(0xFFE27777)),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
