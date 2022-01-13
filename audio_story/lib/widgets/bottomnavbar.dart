import 'package:audio_story/provider/navigation_provider.dart';
import 'package:audio_story/resources/app_colors.dart';
import 'package:audio_story/resources/app_icons.dart';
import 'package:audio_story/routes/route.dart';
import 'package:audio_story/screens/audio/audio.dart';
import 'package:audio_story/screens/category/category.dart';
import 'package:audio_story/screens/main_screen/main_screen.dart';
import 'package:audio_story/screens/profile/profile.dart';
import 'package:audio_story/screens/record/record.dart';
import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';

class CustomNavigationBar extends StatelessWidget {
  const CustomNavigationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final navigationProvider = context.watch<NavigationProvider>();
    int activeButtonIndex = navigationProvider.screenIndex;

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
          currentIndex: activeButtonIndex < 5 ? activeButtonIndex : 0,
          onTap: (buttonIndex) {
            switch (buttonIndex) {
              case 0:
                RouteGenerator.navigationKey.currentState!
                    .pushNamed(MainScreen.routeName);
                navigationProvider.changeScreen(0);
                break;
              case 1:
                RouteGenerator.navigationKey.currentState!
                    .pushNamed(Category.routeName);
                navigationProvider.changeScreen(1);
                break;
              case 2:
                RouteGenerator.navigationKey.currentState!
                    .pushNamed(Records.routeName);
                navigationProvider.changeScreen(2);
                break;
              case 3:
                RouteGenerator.navigationKey.currentState!
                    .pushNamed(Audio.routeName);
                navigationProvider.changeScreen(3);
                break;
              case 4:
                RouteGenerator.navigationKey.currentState!
                    .pushNamed(Profile.routeName);
                navigationProvider.changeScreen(4);
                break;
              default:
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
