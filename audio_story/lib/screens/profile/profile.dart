import 'package:audio_story/Colors/colors.dart';
import 'package:audio_story/widgets/bottomnavbar.dart';
import 'package:audio_story/widgets/custom_paint.dart';
import 'package:audio_story/widgets/side_menu.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  late String phone;
  var maskFormatter = MaskTextInputFormatter(mask: '+## (###) ###-##-##', filter: { "#": RegExp(r'[0-9]') });

  @override
  void initState() {
    super.initState();
    getPhone();
  }

  getPhone() async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    setState(() {
      try{
        phone = currentUser!.phoneNumber!;
      }catch(e){
        phone = "380xxxxxxxxx";
      }
      
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const SideMenu(),
      bottomNavigationBar: const CustomNavigationBar(4),
      body: Stack(
        children: [
          const MyCustomPaint(
            color: CColors.purpule,
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 60,
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
                      controller: TextEditingController(text: phone),
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
                  padding: EdgeInsets.only(top: 50.0),
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
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    children: const [
                      Text("Выйти из приложения"),
                      Spacer(),
                      Text(
                        "Удалить аккаунт",
                        style: TextStyle(color: Color(0xFFE27777)),
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
