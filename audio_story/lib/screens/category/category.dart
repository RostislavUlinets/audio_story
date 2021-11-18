import 'package:audio_story/screens/category/create_category.dart';
import 'package:audio_story/widgets/bottomnavbar.dart';
import 'package:audio_story/widgets/custom_paint.dart';
import 'package:audio_story/widgets/side_menu.dart';
import 'package:audio_story/Colors/colors.dart';
import 'package:flutter/material.dart';

import 'widget/category_list.dart';

class Category extends StatelessWidget {
  const Category({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      drawer: const SideMenu(),
      bottomNavigationBar: const CustomNavigationBar(1),
      body: Stack(
        children: [
          MyCustomPaint(
            color: CColors.green,
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
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const CreateCategory()),
                        );
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
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: buildListView(),
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
