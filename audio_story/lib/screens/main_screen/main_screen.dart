import 'package:audio_story/widgets/custom_paint.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../widgets/side_menu.dart';
import '../../widgets/bottomnavbar.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: const CustomNavigationBar(0),
      drawer: const ClipRRect(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(25), bottomRight: Radius.circular(25)),
        child: SideMenu(),
      ),
      body: Stack(
        children: [
          const MyCustomPaint(),
          Padding(
            padding: const EdgeInsets.only(top: 50.0),
            child: Column(
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.menu,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        //Scaffold.of(context).openDrawer();
                        //TODO: "Fix";
                      },
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    children: const [
                      Text(
                        "Подборки",
                        style: TextStyle(fontSize: 24, color: Colors.white),
                      ),
                      Spacer(),
                      Text(
                        "Открыть все",
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    children: [
                      Flexible(
                        child: Container(
                          alignment: Alignment.center,
                          child: const Text(
                            "Здесь будет твой набор сказок",
                            style: TextStyle(fontSize: 24, color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xD971A59F),
                            border: Border.all(
                              color: const Color(0xD971A59F),
                            ),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 10,
                                blurRadius: 10,
                                offset:
                                    const Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          height: 200,
                        ),
                        flex: 1,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Flexible(
                        child: Column(
                          children: [
                            Container(
                              alignment: Alignment.center,
                              child: const Text(
                                "Тут",
                                style: TextStyle(
                                    fontSize: 24, color: Colors.white),
                                textAlign: TextAlign.center,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xD9F1B488),
                                border: Border.all(
                                  color: const Color(0xD9F1B488),
                                ),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(20)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    spreadRadius: 10,
                                    blurRadius: 10,
                                    offset: const Offset(
                                        0, 3), // changes position of shadow
                                  ),
                                ],
                              ),
                              height: 94,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              alignment: Alignment.center,
                              child: const Text(
                                "И тут",
                                style: TextStyle(
                                    fontSize: 24, color: Colors.white),
                                textAlign: TextAlign.center,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xD9678BD2),
                                border: Border.all(
                                  color: const Color(0xD9678BD2),
                                ),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(20)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    spreadRadius: 10,
                                    blurRadius: 10,
                                    offset: const Offset(
                                        0, 3), // changes position of shadow
                                  ),
                                ],
                              ),
                              height: 94,
                            ),
                          ],
                        ),
                        flex: 1,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                const CustomList(),
                /*Container(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Row(
                          children: const [
                            Text("Аудиозаписи", style: TextStyle(fontSize: 24)),
                            Spacer(),
                            Text("Открыть все", style: TextStyle(fontSize: 16)),
                          ],
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 60, horizontal: 30),
                          child: Text(
                            "Как только ты запишешь аудио, она появится здесь.",
                            style: TextStyle(
                                fontSize: 20, color: Color(0x993A3A55)),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const Image(
                          image: AssetImage('assets/Arrow - Down.png'),
                        ),
                      ],
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF6F6F6),
                    border: Border.all(
                      color: Colors.grey,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                  ),
                  height: 350,
                ),*/
              ],
            ),
          )
        ],
      ),
    );
  }
}

class CustomList extends StatelessWidget {
  const CustomList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  children: const [
                    Text("Аудиозаписи", style: TextStyle(fontSize: 24)),
                    Spacer(),
                    Text("Открыть все", style: TextStyle(fontSize: 16)),
                  ],
                ),
              ),
              Expanded(child: _buildListView()),
            ],
          ),
        ),
        decoration: BoxDecoration(
          color: const Color(0xFFF6F6F6),
          border: Border.all(
            color: Colors.grey,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 10,
              blurRadius: 10,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        height: 400,
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
        ),
      );
    },
  );
}
