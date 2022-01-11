import 'package:audio_story/Colors/colors.dart';
import 'package:audio_story/repositories/database.dart';
import 'package:audio_story/screens/category/category.dart';
import 'package:audio_story/screens/main_screen/widget/anon_containers.dart';
import 'package:audio_story/screens/main_screen/widget/logged_containers.dart';
import 'package:audio_story/widgets/custom_paint.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../widgets/side_menu.dart';
import '../../widgets/bottomnavbar.dart';
import 'widget/custom_list.dart';

class MainScreen extends StatefulWidget {
  static const routeName = '/mainScreen';

  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  DatabaseService dataBase =
      DatabaseService(FirebaseAuth.instance.currentUser!.uid);

  bool emptyList = true;

  @override
  void initState() {
    super.initState();
    dataBase.getPlayListImages().then(
          (value) => setState(
            () {
              emptyList = value.isEmpty;
            },
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,
      bottomNavigationBar: const CustomNavigationBar(0),
      drawer: const ClipRRect(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(25), bottomRight: Radius.circular(25)),
        child: SideMenu(),
      ),
      body: Stack(
        children: [
          const MyCustomPaint(
            color: CColors.purpule,
            size: 0.85,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 50.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Builder(builder: (context) {
                      return IconButton(
                        icon: const Icon(
                          Icons.menu,
                          color: Colors.white,
                          size: 36,
                        ),
                        onPressed: () {
                          Scaffold.of(context).openDrawer();
                        },
                      );
                    }),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    children: [
                      const Text(
                        "Подборки",
                        style: TextStyle(fontSize: 24, color: Colors.white),
                      ),
                      const Spacer(),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, Category.routeName);
                        },
                        child: const Text(
                          "Открыть все",
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
                emptyList ? const AnonimContainers() : const LoggedContainers(),
                const SizedBox(height: 10),
                CustomList(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
