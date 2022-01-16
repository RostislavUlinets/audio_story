import 'package:audio_story/models/navigation_item.dart';
import 'package:audio_story/provider/navigation_provider.dart';
import 'package:audio_story/resources/app_icons.dart';
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
                  image: AppIcons.home,
                ),
                buildMenuItem(
                  context,
                  item: NavigationItem.profile,
                  text: 'Профиль',
                  image: AppIcons.profile,
                ),
                buildMenuItem(
                  context,
                  item: NavigationItem.category,
                  text: 'Подборки',
                  image: AppIcons.category,
                ),
                buildMenuItem(
                  context,
                  item: NavigationItem.audio,
                  text: 'Все аудиозаписи',
                  image: AppIcons.paper,
                ),
                buildMenuItem(
                  context,
                  item: NavigationItem.search,
                  text: 'Поиск',
                  image: AppIcons.search,
                ),
                buildMenuItem(
                  context,
                  item: NavigationItem.delete,
                  text: 'Недавно удаленные',
                  image: AppIcons.delete,
                ),
                const SizedBox(
                  height: 30,
                ),
                buildMenuItem(
                  context,
                  item: NavigationItem.subscribe,
                  text: 'Подписка',
                  image: AppIcons.wallet,
                ),
                const SizedBox(
                  height: 30,
                ),
                buildMenuItem(
                  context,
                  item: NavigationItem.help,
                  text: 'Написать в\nподдержку',
                  image: AppIcons.edit,
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
    NavigationProvider navigation = context.watch<NavigationProvider>();

    final isSelected = checker(item, navigation);

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
              Navigator.pop(context);
              navigation.changeScreen(0);
              break;
            case NavigationItem.profile:
              Navigator.pop(context);
              navigation.changeScreen(4);

              break;
            case NavigationItem.subscribe:
              Navigator.pop(context);
              navigation.changeScreen(7);

              break;
            case NavigationItem.category:
              Navigator.pop(context);
              navigation.changeScreen(1);

              break;
            case NavigationItem.audio:
              Navigator.pop(context);
              navigation.changeScreen(3);

              break;
            case NavigationItem.search:
              Navigator.pop(context);
              navigation.changeScreen(5);
              break;
            case NavigationItem.delete:
              Navigator.pop(context);
              navigation.changeScreen(6);

              break;
            case NavigationItem.help:
              Navigator.pop(context);
              break;
          }
        },
      ),
    );
  }

  bool checker(NavigationItem item, NavigationProvider navigation) {
    switch (item) {
      case NavigationItem.home:
        if (navigation.screenIndex == 0) return true;
        break;
      case NavigationItem.profile:
        if (navigation.screenIndex == 4) return true;
        break;
      case NavigationItem.subscribe:
        if (navigation.screenIndex == 7) return true;
        break;
      case NavigationItem.category:
        if (navigation.screenIndex == 1) return true;
        break;
      case NavigationItem.audio:
        if (navigation.screenIndex == 3) return true;
        break;
      case NavigationItem.search:
        if (navigation.screenIndex == 5) return true;
        break;
      case NavigationItem.help:
        if (navigation.screenIndex == 10) return true;
        break;
      case NavigationItem.delete:
        if (navigation.screenIndex == 6) return true;
        break;
    }
    return false;
  }

  /*void selectItem(BuildContext context, String item) {
    final provider = Provider.of<NavigationController>(context, listen: false);
    provider.changeScreen(item);
  }*/
}
