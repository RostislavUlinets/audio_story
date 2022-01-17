import 'package:audio_story/resources/app_colors.dart';
import 'package:audio_story/screens/login_screen/welcome_screen.dart';
import 'package:audio_story/screens/profile/edit_profile.dart';
import 'package:audio_story/screens/profile/widgets/dialog.dart';
import 'package:audio_story/repositories/database.dart';
import 'package:audio_story/service/auth.dart';
import 'package:audio_story/widgets/custom_paint.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  static const routeName = '/profile';

  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  DatabaseService dataBase =
      DatabaseService(FirebaseAuth.instance.currentUser!.uid);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: dataBase.getUserData(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return const SizedBox(
              height: 250,
              width: 250,
              child: Center(
                child: CircularProgressIndicator(
                  color: AppColors.purpule,
                  strokeWidth: 1.5,
                ),
              ),
            );
          default:
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
                        child: SizedBox(
                          child: snapshot.data.avatar,
                          height: 200,
                          width: 200,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Builder(builder: (context) {
                          return Text(
                            snapshot.data.name,
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
                            textAlign: TextAlign.center,
                            controller: TextEditingController(
                              text: snapshot.data.phoneNumber,
                            ),
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
                              style: TextStyle(
                                fontSize: 14,
                                color: AppColors.black,
                              ),
                            ),
                            onPressed: () {
                              AuthService.isAnonymous()
                                  ? ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          'Данная функция станет\nдоступной после авторизации',
                                        ),
                                      ),
                                    )
                                  : Navigator.pushReplacementNamed(
                                      context,
                                      EditProfile.routeName,
                                      arguments: snapshot.data,
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
                                Navigator.of(context, rootNavigator: true)
                                    .pushReplacementNamed(
                                        WelcomeScreen.routeName);
                              },
                              child: const Text("Выйти из приложения",
                                  style: TextStyle(
                                    color: AppColors.black,
                                  )),
                            ),
                            const Spacer(),
                            TextButton(
                              onPressed: () {
                                if(AuthService.isAnonymous()){
                                  FirebaseAuth.instance.signOut();
                                Navigator.of(context, rootNavigator: true)
                                    .pushReplacementNamed(
                                        WelcomeScreen.routeName);
                                }else{
                                showAlertDialog(context);
                                }
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
            );
        }
      },
    );
  }
}
