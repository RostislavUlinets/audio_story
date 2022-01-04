import 'package:audio_story/models/navigation_item.dart';
import 'package:audio_story/provider/navigation_provider.dart';
import 'package:audio_story/screens/audio/audio.dart';
import 'package:audio_story/screens/category/category.dart';
import 'package:audio_story/screens/deleted/delete_screen.dart';
import 'package:audio_story/screens/deleted/deleted.dart';
import 'package:audio_story/screens/main_screen/main_screen.dart';
import 'package:audio_story/screens/profile/profile.dart';
import 'package:audio_story/screens/search/search.dart';
import 'package:audio_story/screens/subscribe/subscribe.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SideMenu extends StatelessWidget with RouteAware {
  const SideMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            child: Column(
              children: const [
                Text(
                  "Аудиосказки",
                  style: TextStyle(fontSize: 24, color: Color(0xFF3A3A55)),
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  "Меню",
                  style: TextStyle(fontSize: 24, color: Color(0x803A3A55)),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                buildMenuItem(
                  context,
                  item: NavigationItem.home,
                  text: 'Главная',
                  image: const AssetImage('assets/Home.png'),
                ),
                buildMenuItem(
                  context,
                  item: NavigationItem.profile,
                  text: 'Профиль',
                  image: const AssetImage('assets/Profile.png'),
                ),
                buildMenuItem(
                  context,
                  item: NavigationItem.category,
                  text: 'Подборки',
                  image: const AssetImage('assets/Category.png'),
                ),
                buildMenuItem(
                  context,
                  item: NavigationItem.audio,
                  text: 'Все аудиозаписи',
                  image: const AssetImage('assets/Paper.png'),
                ),
                buildMenuItem(
                  context,
                  item: NavigationItem.search,
                  text: 'Поиск',
                  image: const AssetImage('assets/Search.png'),
                ),
                buildMenuItem(
                  context,
                  item: NavigationItem.delete,
                  text: 'Недавно удаленные',
                  image: const AssetImage('assets/Delete.png'),
                ),
                const SizedBox(
                  height: 30,
                ),
                buildMenuItem(
                  context,
                  item: NavigationItem.subscribe,
                  text: 'Подписка',
                  image: const AssetImage('assets/Wallet.png'),
                ),
                const SizedBox(
                  height: 30,
                ),
                buildMenuItem(
                  context,
                  item: NavigationItem.help,
                  text: 'Написать в\nподдержку',
                  image: const AssetImage('assets/Edit.png'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildMenuItem(
    BuildContext context, {
    required NavigationItem item,
    required String text,
    required AssetImage image,
  }) {
    final isSelected = checker(item, ModalRoute.of(context)!.settings.name);

    final color = isSelected ? Colors.red : const Color(0xFF3A3A55);

    return Material(
      color: Colors.transparent,
      child: ListTile(
        visualDensity: const VisualDensity(horizontal: 0, vertical: -2),
        selected: isSelected,
        selectedTileColor: Colors.white24,
        leading: Image(
          image: image,
          color: color,
        ),
        title: Text(text, style: TextStyle(color: color)),
        onTap: () {
          switch (item) {
            case NavigationItem.home:
              Navigator.pushNamed(context, MainScreen.routeName);
              break;
            case NavigationItem.profile:
              Navigator.pushNamed(context, Profile.routeName);
              break;
            case NavigationItem.subscribe:
              Navigator.pushNamed(context, Subscribe.routeName);
              break;
            case NavigationItem.category:
              Navigator.pushNamed(context, Category.routeName);
              break;
            case NavigationItem.audio:
              Navigator.pushNamed(context, Audio.routeName);
              break;
            case NavigationItem.search:
              Navigator.pushNamed(context, SearchScreen.routeName);
              break;
            case NavigationItem.delete:
              Navigator.pushNamed(context, DeleteScreen.routeName);
              break;
            case NavigationItem.help:
              Navigator.pushNamed(context, Subscribe.routeName);
              break;
          }
        },
      ),
    );
  }

  bool checker(NavigationItem item, String? navigation) {
    switch (item) {
      case NavigationItem.home:
        if (navigation == MainScreen.routeName) return true;
        break;
      case NavigationItem.profile:
        if (navigation == Profile.routeName) return true;
        break;
      case NavigationItem.subscribe:
        if (navigation == Subscribe.routeName) return true;
        break;
      case NavigationItem.category:
        if (navigation == Category.routeName) return true;
        break;
      case NavigationItem.audio:
        if (navigation == Audio.routeName) return true;
        break;
      case NavigationItem.search:
        if (navigation == SearchScreen.routeName) return true;
        break;
      case NavigationItem.help:
        if (navigation == Profile.routeName) return true;
        break;
      case NavigationItem.delete:
        if (navigation == DeleteScreen.routeName) return true;
        break;
    }
    return false;
  }

  /*void selectItem(BuildContext context, String item) {
    final provider = Provider.of<NavigationController>(context, listen: false);
    provider.changeScreen(item);
  }*/
}
