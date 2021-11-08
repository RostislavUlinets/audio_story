import 'package:audio_story/Colors/colors.dart';
import 'package:audio_story/provider/navigation_provider.dart';
import 'package:audio_story/widgets/bottomnavbar.dart';
import 'package:audio_story/widgets/custom_paint.dart';
import 'package:audio_story/widgets/side_menu.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:audio_story/models/auth.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final AuthService _auth = AuthService();
  User? currentUser = FirebaseAuth.instance.currentUser;

  late String phone;
  var maskFormatter = MaskTextInputFormatter(
      mask: '+## (###) ###-##-##', filter: {"#": RegExp(r'[0-9]')});

  @override
  void initState() {
    super.initState();
    getPhone();
  }

  getPhone() async {
    
    setState(() {
      try {
        phone = currentUser!.phoneNumber!;
      } catch (e) {
        phone = "380xxxxxxxxx";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
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
                    IconButton(
                      icon: const Icon(
                        Icons.menu,
                        color: Colors.white,
                        size: 36,
                      ),
                      onPressed: () {
                        Scaffold.of(context).openDrawer();
                        //TODO: "Fix";
                      },
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
                  child: const SizedBox(
                    child: Image(
                      image: AssetImage(
                        "assets/selfi.jpg",
                      ),
                      fit: BoxFit.cover,
                    ),
                    height: 200,
                    width: 200,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    "Аня",
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
                      controller: TextEditingController(text: currentUser?.phoneNumber),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(60.0),
                        ),
                      ),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    "Редактировать",
                    style: TextStyle(fontSize: 14),
                  ),
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

showAlertDialog(BuildContext context) {
  NavigationController navigation =
        Provider.of<NavigationController>(context, listen: false);
  // set up the buttons
  Widget cancelButton = TextButton(
    child: Text(
      "Нет",
      style: TextStyle(color: CColors.purpule),
    ),
    style: ButtonStyle(
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
          side: BorderSide(color: CColors.purpule),
        ),
      ),
    ),
    onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
  );
  Widget continueButton = TextButton(
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Text(
        "Удалить",
        style: TextStyle(color: Colors.white),
      ),
    ),
    style: ButtonStyle(
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
        ),
      ),
      backgroundColor: MaterialStateProperty.all(CColors.red),
    ),
    onPressed: () {
      User? currentUser = FirebaseAuth.instance.currentUser;
      currentUser?.delete();
      Navigator.of(context, rootNavigator: true).pop();
      navigation.changeScreen('');
    },
  );

  // set up the AlertDialog
  Widget alert = AlertDialog(
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20.0))),
    content: Container(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Text("Точно удалить аккаунт?",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: CColors.black)),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                "Все аудиофайлы исчезнут и восстановить аккаунт будет невозможно",
                style: TextStyle(
                    fontSize: 14, color: CColors.black.withOpacity(0.5)),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35.0),
              child: Row(
                children: [
                  continueButton,
                  Spacer(),
                  cancelButton,
                ],
              ),
            ),
          ],
        ),
      ),
      height: 180,
      width: 300,
    ),
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
