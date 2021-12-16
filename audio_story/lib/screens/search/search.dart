import 'package:audio_story/screens/audio/custompaint.dart';
import 'package:audio_story/widgets/audio_list.dart';
import 'package:audio_story/widgets/bottomnavbar.dart';
import 'package:audio_story/widgets/side_menu.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  static const routeName = '/search';
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const SideMenu(),
      extendBody: true,
      bottomNavigationBar: const CustomNavigationBar(3),
      body: Stack(
        children: [
          const CustomP(),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 60.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    const Text(
                      "Поиск",
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.more_horiz,
                        color: Colors.white,
                        size: 36,
                      ),
                      onPressed: () {},
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 40.0),
                  child: Container(
                    child: TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(45)),
                        labelText: 'Поиск',
                        suffixIcon: const Icon(Icons.search),
                      ),
                    ),
                    height: 50,
                    width: double.infinity - 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(45),
                    ),
                  ),
                ),
                SizedBox(
                  width: 350,
                  height: 420,
                  child: ListWidget(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
