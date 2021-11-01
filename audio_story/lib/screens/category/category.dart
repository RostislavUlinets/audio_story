import 'package:audio_story/widgets/bottomnavbar.dart';
import 'package:audio_story/widgets/custom_paint.dart';
import 'package:audio_story/widgets/side_menu.dart';
import 'package:flutter/material.dart';

class Category extends StatelessWidget {
  const Category({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const SideMenu(),
      //TODO: FIX;
      bottomNavigationBar: const CustomNavigationBar(1),
      body: Stack(
        children: [
          const MyCustomPaint(),
          Padding(
            padding: const EdgeInsets.only(top: 50.0,right: 10,left: 10),
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
        child: Container(
          child: const ListTile(
            title: Text(
              "Малышь Кокки 1",
              style: TextStyle(color: Color(0xFF3A3A55)),
            ),
            subtitle: Text(
              "30 минут",
              style: TextStyle(color: Color(0x803A3A55)),
            ),
            leading: Image(
              image: AssetImage("assets/Play.png"),
            ),
            trailing: Icon(Icons.more_horiz),
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(75),
            border: Border.all(
              color: Colors.grey,
            ),
          ),
          width: 100,
          height: 150,
        ),
      );
    },
  );
}