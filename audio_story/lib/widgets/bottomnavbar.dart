import 'package:audio_story/screens/main_screen/main_screen.dart';
import 'package:audio_story/screens/profile/profile.dart';
import 'package:flutter/material.dart';
class CustomNavigation extends StatefulWidget {
  const CustomNavigation({Key? key}) : super(key: key);

  @override
  State<CustomNavigation> createState() => _CustomNavigationState();
}

class _CustomNavigationState extends State<CustomNavigation> {

  int _pageIndex = 0;

  List<Widget>pageList =  [
    MainScreen(),
    MainScreen(),
    MainScreen(),
    MainScreen(),
    Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
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
            currentIndex: _pageIndex,
            onTap: (value){
              setState(() {
                _pageIndex = value;
              });             
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => pageList[_pageIndex],
                ),
              );
            },
            type: BottomNavigationBarType.fixed,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                  icon: Image(
                    image: AssetImage('assets/Home.png'),
                  ),
                  label: "Главная"),
              BottomNavigationBarItem(
                  icon: Image(
                    image: AssetImage('assets/Category.png'),
                  ),
                  label: 'Подборки'),
              BottomNavigationBarItem(
                  icon: Container(
                    decoration: BoxDecoration(
                            color: Color(0xBFF1B488),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(15)),
                          ),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Image(
                        color: Colors.black,
                        image: AssetImage('assets/Voice.png'),
                      ),
                    ),
                  ),
                  label: 'Запись'),
              BottomNavigationBarItem(
                  icon: Image(
                    image: AssetImage('assets/Paper.png'),
                  ),
                  label: 'Аудиозаписи'),
              BottomNavigationBarItem(
                  icon: Image(
                    image: AssetImage('assets/Profile.png'),
                  ),
                  label: 'Профиль'),
            ],
          ),
        ),
      );
  }
}