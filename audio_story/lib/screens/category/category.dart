import 'package:audio_story/resources/app_colors.dart';
import 'package:audio_story/screens/category/create_category.dart';
import 'package:audio_story/service/auth.dart';
import 'package:audio_story/widgets/anon_message.dart';
import 'package:audio_story/widgets/bottomnavbar.dart';
import 'package:audio_story/widgets/custom_paint.dart';
import 'package:audio_story/widgets/side_menu.dart';
import 'package:flutter/material.dart';

import 'widget/category_list.dart';

class Category extends StatefulWidget {
  static const routeName = '/category';

  const Category({Key? key}) : super(key: key);

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  @override
  void initState() {
    super.initState();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return AuthService.isAnonymous()
        ? const AnonMessage()
        : Scaffold(
            extendBody: true,
            drawer: const SideMenu(),
            bottomNavigationBar: const CustomNavigationBar(1),
            body: Stack(
              children: [
                const MyCustomPaint(
                  color: AppColors.green,
                  size: 0.85,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 50.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon: const Image(
                              image: AssetImage('assets/PlusIcon.png'),
                              color: Colors.white,
                              width: 36,
                              height: 36,
                            ),
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, CreateCategory.routeName);
                              //Scaffold.of(context).openDrawer();
                            },
                          ),
                          const Text(
                            "Подборки",
                            style: TextStyle(
                                fontSize: 36,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.more_horiz,
                              color: Colors.white,
                              size: 36,
                            ),
                            onPressed: () {},
                          ),
                        ],
                      ),
                      const Text(
                        "Все в одном месте",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                      const SizedBox(height: 30),
                      Container(
                        child: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          child: PlayList(),
                        ),
                        height: 580,
                        color: const Color(0x0071A59F),
                      ),
                      //_buildListView(),
                    ],
                  ),
                )
              ],
            ),
          );
  }
}
