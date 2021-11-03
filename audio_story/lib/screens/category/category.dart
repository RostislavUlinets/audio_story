import 'package:audio_story/widgets/bottomnavbar.dart';
import 'package:audio_story/widgets/custom_paint.dart';
import 'package:audio_story/widgets/side_menu.dart';
import 'package:audio_story/Colors/colors.dart';
import 'package:flutter/material.dart';

class Category extends StatelessWidget {
  const Category({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      drawer: const SideMenu(),
      //TODO: FIX;
      bottomNavigationBar: const CustomNavigationBar(1),
      body: Stack(
        children: [
          const MyCustomPaint(color: CColors.green),
          Padding(
            padding: const EdgeInsets.only(top: 50.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.exposure_plus_1,
                        color: Colors.white,
                        size: 36,
                      ),
                      onPressed: () {
                        //Scaffold.of(context).openDrawer();
                        //TODO: "Fix";
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
                      onPressed: () {
                        //Scaffold.of(context).openDrawer();
                        //TODO: "Fix";
                      },
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
                    child: _buildListView(),
                  ),
                  height: 580,
                  color: Color(0x0071A59F),
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

ListView _buildListView() {
  return ListView.builder(
    itemCount: 10,
    itemBuilder: (_, index) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            child: Text(
                              "Сказка \nо малыше Кокки",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                                height: 1,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            width: 90,
                          ),
                          Spacer(),
                          Container(
                            child: Text(
                              "n аудио\n1:30 часа",
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.white,
                              ),
                              
                            ),
                            width: 70,
                          ),
                        ],
                      ),
                    ),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          "assets/story.jpg",
                        ),
                        colorFilter: new ColorFilter.mode(
                            Colors.black.withOpacity(0.8), BlendMode.dstATop),
                        fit: BoxFit.cover,
                      ),
                      color: Colors.black,
                    ),
                    height: 210,
                    width: 180,
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            child: Text(
                              "Сказка \nо малыше Кокки",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                                height: 1,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            width: 90,
                          ),
                          Spacer(),
                          Container(
                            child: Text(
                              "n аудио\n1:30 часа",
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.white,
                              ),
                              
                            ),
                            width: 70,
                          ),
                        ],
                      ),
                    ),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          "assets/seconStory.jpg",
                        ),
                        colorFilter: new ColorFilter.mode(
                            Colors.black.withOpacity(0.8), BlendMode.dstATop),
                        fit: BoxFit.cover,
                      ),
                      color: Colors.black,
                    ),
                    height: 210,
                    width: 180,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}
