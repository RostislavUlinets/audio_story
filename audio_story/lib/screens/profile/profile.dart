import 'package:audio_story/Colors/colors.dart';
import 'package:audio_story/models/user.dart';
import 'package:audio_story/provider/navigation_provider.dart';
import 'package:audio_story/screens/profile/edit_profile.dart';
import 'package:audio_story/screens/profile/widgets/dialog.dart';
import 'package:audio_story/service/database.dart';
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
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  
  final AuthService _auth = AuthService.instance;
  User? currentUser = FirebaseAuth.instance.currentUser;
  DatabaseService dataBase =
      DatabaseService(FirebaseAuth.instance.currentUser!.uid);
  late String phone;
  String uid = FirebaseAuth.instance.currentUser!.uid;
  String _userName = "";

  var maskFormatter = MaskTextInputFormatter(
      mask: '+## (###) ###-##-##', filter: {"#": RegExp(r'[0-9]')});

  @override
  void initState() {
    downloadURLExample();
    super.initState();
  }

  Future<void> downloadURLExample() async {
    try {
      downloadURL = await FirebaseStorage.instance
          .ref('Avatars/$uid/avatar.jpg')
          .getDownloadURL();
    } catch (e) {
      Exception e;
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CustomUser?>(context);
    NavigationController navigation =
        Provider.of<NavigationController>(context, listen: false);
    return Scaffold(
      extendBody: true,
      drawer: const SideMenu(),
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
                          //TODO: "Fix";
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
                    child: Image.network(
                      downloadURL,
                      fit: BoxFit.cover,
                    ),
                    height: 200,
                    width: 200,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    provider!.name,
                    style: TextStyle(fontSize: 24),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50.0),
                  child: Material(
                    borderRadius: BorderRadius.circular(60.0),
                    elevation: 5,
                    shadowColor: Colors.grey,
                    child: TextField(
                      inputFormatters: [maskFormatter],
                      textAlign: TextAlign.center,
                      controller:
                          TextEditingController(text: currentUser?.phoneNumber),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(60.0),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: TextButton(
                      child: Text(
                        "Редактировать",
                        style: TextStyle(fontSize: 14),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EditProfile()),
                        );
                      }),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 40.0),
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
                          _auth.signOut();
                          navigation.changeScreen('');
                        },
                        child: Text("Выйти из приложения",
                            style: TextStyle(
                              color: CColors.black,
                            )),
                      ),
                      Spacer(),
                      TextButton(
                        onPressed: () {
                          showAlertDialog(context);
                        },
                        child: Text(
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
