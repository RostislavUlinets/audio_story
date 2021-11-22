import 'package:audio_story/Colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:audio_story/provider/navigation_provider.dart';

/*
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
                                const BorderRadius.all(Radius.circular(20)),
                          ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Image(
                        color: Colors.white,
                        
                        image: AssetImage('assets/Voice.png'),
                      ),
                    ),
                  ),
                  label: 'Запись'
                  ),
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
*/

class CustomNavigationBar extends StatelessWidget {
  final int activeButtonIndex;

  const CustomNavigationBar(this.activeButtonIndex, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    NavigationController navigation =
        Provider.of<NavigationController>(context, listen: false);

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
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.black,
          currentIndex: activeButtonIndex,
          onTap: (buttonIndex) {
            switch (buttonIndex) {
              case 0:
                navigation.changeScreen('/');
                break;
              case 1:
                navigation.changeScreen('/category');
                break;
              case 2:
                navigation.changeScreen('/record');
                break;
              case 3:
                navigation.changeScreen('/audio');
                break;
              case 4:
                navigation.changeScreen('/profile');
                break;
            }
          },
          type: BottomNavigationBarType.fixed,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: const Image(
                  image: AssetImage('assets/Home.png'),
                  color: Colors.black,
                ),
                activeIcon: Image(
                  image: const AssetImage('assets/Home.png'),
                  color: CColors.purpule,
                ),
                label: "Главная"),
            BottomNavigationBarItem(
                icon: const Image(
                  image: AssetImage('assets/Category.png'),
                  color: Colors.black,
                ),
                activeIcon: Image(
                  image: const AssetImage('assets/Category.png'),
                  color: CColors.purpule,
                ),
                label: 'Подборки'),
            BottomNavigationBarItem(
                icon: Container(
                  decoration: const BoxDecoration(
                    color: Color(0xBFF1B488),
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Image(
                      color: Colors.white,
                      image: AssetImage('assets/Voice.png'),
                    ),
                  ),
                ),
                activeIcon: Container(
                  decoration: const BoxDecoration(
                    color: Color(0xBFF1B488),
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(22.0),
                  ),
                ),
                label: 'Запись'),
            BottomNavigationBarItem(
                icon: const Image(
                  image: AssetImage('assets/Paper.png'),
                  color: Colors.black,
                ),
                activeIcon: Image(
                  image: const AssetImage('assets/Paper.png'),
                  color: CColors.purpule,
                ),
                label: 'Аудиозаписи'),
            BottomNavigationBarItem(
                icon: const Image(
                  image: AssetImage('assets/Profile.png'),
                  color: Colors.black,
                ),
                activeIcon: Image(
                  image: const AssetImage('assets/Profile.png'),
                  color: CColors.purpule,
                ),
                label: 'Профиль'),
          ],
        ),
      ),
    );
  }
}
