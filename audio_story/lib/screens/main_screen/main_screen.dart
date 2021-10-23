import 'package:audio_story/widgets/custom_paint.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

GlobalKey<ScaffoldState> _scaffoldKEY = GlobalKey<ScaffoldState>();

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(30), topLeft: Radius.circular(30)),
          boxShadow: [
            BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                  icon: Icon(Icons.house_rounded), label: "Главная"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.auto_awesome_mosaic_outlined),
                  label: 'Подборки'),
              BottomNavigationBarItem(icon: Icon(Icons.mic), label: 'Запись'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.notes), label: 'Аудиозаписи'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.account_circle_outlined), label: 'Профиль'),
            ],
          ),
        ),
      ),
      drawer: Drawer(),
      body: Stack(
        children: [
          MyCustomPaint(),
          Padding(
            padding: const EdgeInsets.only(top: 50.0),
            child: Column(
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.menu,
                        color: Colors.black,
                      ),
                      onPressed: () => null,
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
                          child: Text(
                            "Здесь будет твой набор сказок",
                            style: TextStyle(fontSize: 24, color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                          decoration: BoxDecoration(
                            color: Color(0xD971A59F),
                            border: Border.all(
                              color: Color(0xD971A59F),
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(20)),
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
                              child: Text(
                                "Тут",
                                style: TextStyle(
                                    fontSize: 24, color: Colors.white),
                                textAlign: TextAlign.center,
                              ),
                              decoration: BoxDecoration(
                                color: Color(0xD9F1B488),
                                border: Border.all(
                                  color: Color(0xD9F1B488),
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                              ),
                              height: 94,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              alignment: Alignment.center,
                              child: Text(
                                "И тут",
                                style: TextStyle(
                                    fontSize: 24, color: Colors.white),
                                textAlign: TextAlign.center,
                              ),
                              decoration: BoxDecoration(
                                color: Color(0xD9678BD2),
                                border: Border.all(
                                  color: Color(0xD9678BD2),
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
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
                SizedBox(height: 10),
                Container(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text("Аудиозаписи",style: TextStyle(fontSize: 24)),
                            Spacer(),
                            Text("Открыть все",style: TextStyle(fontSize: 16)),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 60,horizontal: 30),
                          child: Text("Как только ты запишешь аудио, она появится здесь.",style: TextStyle(fontSize: 20,color: Color(0x993A3A55)),textAlign: TextAlign.center,),
                        ),
                        Icon(Icons.arrow_downward,size: 64,color: Color(0x993A3A55)),
                      ],
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: Color(0xFFF6F6F6),
                    border: Border.all(
                      color: Colors.grey,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                  ),
                  height: 350,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
