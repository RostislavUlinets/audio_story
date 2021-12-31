import 'package:audio_story/models/navigation_item.dart';
import 'package:audio_story/provider/navigation_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SideMenu extends StatelessWidget {
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
          /*
          ListTile(
            visualDensity: VisualDensity(horizontal: 0, vertical: -4),
            leading: Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Image(
                image: AssetImage('assets/Category.png'),
              ),
            ),
            title: const Text("Подборки"),
            onTap: () {},
          ),
          ListTile(
            visualDensity: VisualDensity(horizontal: 0, vertical: -4),
            leading: Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Image(
                image: AssetImage('assets/Paper.png'),
              ),
            ),
            title: const Text("Все аудиозаписи"),
            onTap: () {},
          ),
          ListTile(
            visualDensity: VisualDensity(horizontal: 0, vertical: -4),
            leading: Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Image(
                image: AssetImage('assets/Search.png'),
              ),
            ),
            title: const Text("Поиск"),
            onTap: () {},
          ),
          ListTile(
            visualDensity: VisualDensity(horizontal: 0, vertical: -4),
            leading: Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Image(
                image: AssetImage('assets/Delete.png'),
              ),
            ),
            title: const Text("Недавно удаленные"),
            onTap: () {},
          ),
          SizedBox(height: 25),
          ListTile(
            leading: Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Image(
                image: AssetImage('assets/Wallet.png'),
              ),
            ),
            title: const Text("Подписка"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Subscribe(),
                ),
              );
            },
          ),
          SizedBox(height: 25),
          ListTile(
            leading: Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Image(
                image: AssetImage('assets/Edit.png'),
              ),
            ),
            title: const Text("Написать в\nподдержку"),
            onTap: () {},
          ),*/
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
    NavigationController navigation =
        Provider.of<NavigationController>(context, listen: false);
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
              navigation.changeScreen('/');
              break;
            case NavigationItem.profile:
              navigation.changeScreen('/profile');
              break;
            case NavigationItem.subscribe:
              navigation.changeScreen('/subscribe');
              break;
            case NavigationItem.category:
              navigation.changeScreen('/category');
              break;
            case NavigationItem.audio:
              navigation.changeScreen('/audio');
              break;
            case NavigationItem.search:
              navigation.changeScreen('/search');
              break;
            case NavigationItem.delete:
              navigation.changeScreen('/deleted');
              break;
            case NavigationItem.help:
              navigation.changeScreen('/subscribe');
              break;
          }
        },
      ),
    );
  }

  bool checker(NavigationItem item, NavigationController navigation) {
    switch (item) {
      case NavigationItem.home:
        if (navigation.screenName == '/') return true;
        break;
      case NavigationItem.profile:
        if (navigation.screenName == '/profile') return true;
        break;
      case NavigationItem.subscribe:
        if (navigation.screenName == '/subscribe') return true;
        break;
      case NavigationItem.category:
        if (navigation.screenName == '/category') return true;
        break;
      case NavigationItem.audio:
        if (navigation.screenName == '/audio') return true;
        break;
      case NavigationItem.search:
        if (navigation.screenName == '/search') return true;
        break;
      case NavigationItem.help:
        if (navigation.screenName == '/profile') return true;
        break;
      case NavigationItem.delete:
        if (navigation.screenName == '/deleted') return true;
        break;
    }
    return false;
  }

  /*void selectItem(BuildContext context, String item) {
    final provider = Provider.of<NavigationController>(context, listen: false);
    provider.changeScreen(item);
  }*/
}
