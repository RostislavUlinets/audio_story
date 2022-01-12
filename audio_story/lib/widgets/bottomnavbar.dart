import 'package:audio_story/resources/app_colors.dart';
import 'package:audio_story/resources/app_icons.dart';
import 'package:audio_story/screens/audio/audio.dart';
import 'package:audio_story/screens/category/category.dart';
import 'package:audio_story/screens/main_screen/main_screen.dart';
import 'package:audio_story/screens/profile/profile.dart';
import 'package:audio_story/screens/record/record.dart';
import 'package:flutter/material.dart';

class CustomNavigationBar extends StatelessWidget {
  final int activeButtonIndex;

  const CustomNavigationBar(this.activeButtonIndex, {Key? key})
      : super(key: key);

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
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.black,
          currentIndex: activeButtonIndex,
          onTap: (buttonIndex) {
            switch (buttonIndex) {
              case 0:
                Navigator.pushNamed(context, MainScreen.routeName);
                break;
              case 1:
                Navigator.pushNamed(context, Category.routeName);
                break;
              case 2:
                Navigator.pushNamed(context, Records.routeName);
                break;
              case 3:
                Navigator.pushNamed(context, Audio.routeName);
                break;
              case 4:
                Navigator.pushNamed(context, Profile.routeName);
                break;
            }
          },
          type: BottomNavigationBarType.fixed,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Image(
                  image: AppIcons.home,
                  color: Colors.black,
                ),
                activeIcon: Image(
                  image: AppIcons.home,
                  color: AppColors.purpule,
                ),
                label: "Главная"),
            BottomNavigationBarItem(
                icon: Image(
                  image: AppIcons.category,
                  color: Colors.black,
                ),
                activeIcon: Image(
                  image: AppIcons.category,
                  color: AppColors.purpule,
                ),
                label: 'Подборки'),
            BottomNavigationBarItem(
                icon: Container(
                  decoration: const BoxDecoration(
                    color: Color(0xBFF1B488),
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Image(
                      color: Colors.white,
                      image: AppIcons.voice,
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
                icon: Image(
                  image: AppIcons.paper,
                  color: Colors.black,
                ),
                activeIcon: Image(
                  image: AppIcons.paper,
                  color: AppColors.purpule,
                ),
                label: 'Аудиозаписи'),
            BottomNavigationBarItem(
                icon: Image(
                  image: AppIcons.profile,
                  color: Colors.black,
                ),
                activeIcon: Image(
                  image: AppIcons.profile,
                  color: AppColors.purpule,
                ),
                label: 'Профиль'),
          ],
        ),
      ),
    );
  }
}
