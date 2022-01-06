import 'package:audio_story/screens/audio_card/widget/add_list.dart';
import 'package:audio_story/screens/category/create_category.dart';
import 'package:audio_story/screens/category/widget/category_list.dart';
import 'package:audio_story/widgets/bottomnavbar.dart';
import 'package:audio_story/widgets/custom_paint.dart';
import 'package:audio_story/widgets/side_menu.dart';
import 'package:audio_story/Colors/colors.dart';
import 'package:flutter/material.dart';

class CustomCategory extends StatefulWidget {
  static const routeName = '/addToCategory';

  const CustomCategory({Key? key}) : super(key: key);

  @override
  State<CustomCategory> createState() => _CategoryState();
}

class _CategoryState extends State<CustomCategory> {
  @override
  void initState() {
    super.initState();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      drawer: const SideMenu(),
      bottomNavigationBar: const CustomNavigationBar(1),
      body: Stack(
        children: [
          const MyCustomPaint(
            color: CColors.green,
            size: 0.85,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 50.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(
                      height: 36,
                      width: 36,
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
                    child: CustomListCategory(),
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
