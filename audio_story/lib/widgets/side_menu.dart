import 'package:audio_story/models/navigation_item.dart';
import 'package:audio_story/provider/navigation_provider.dart';
import 'package:audio_story/screens/main_screen/main_screen.dart';
import 'package:audio_story/screens/profile/profile.dart';
import 'package:audio_story/screens/subscribe/subscribe.dart';
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
                  image: AssetImage('assets/Home.png'),
                ),
                buildMenuItem(
                  context,
                  item: NavigationItem.profile,
                  text: 'Профиль',
                  image: AssetImage('assets/Profile.png'),
                ),
                buildMenuItem(
                  context,
                  item: NavigationItem.profile,
                  text: 'Подборки',
                  image: AssetImage('assets/Category.png'),
                ),
                buildMenuItem(
                  context,
                  item: NavigationItem.profile,
                  text: 'Все аудиозаписи',
                  image: AssetImage('assets/Paper.png'),
                ),
                buildMenuItem(
                  context,
                  item: NavigationItem.profile,
                  text: 'Поиск',
                  image: AssetImage('assets/Search.png'),
                ),
                buildMenuItem(
                  context,
                  item: NavigationItem.profile,
                  text: 'Недавно удаленные',
                  image: AssetImage('assets/Delete.png'),
                ),
                SizedBox(height: 30,),
                buildMenuItem(
                  context,
                  item: NavigationItem.subscribe,
                  text: 'Подписка',
                  image: AssetImage('assets/Wallet.png'),
                ),
                SizedBox(height: 30,),
                buildMenuItem(
                  context,
                  item: NavigationItem.profile,
                  text: 'Написать в\nподдержку',
                  image: AssetImage('assets/Edit.png'),
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

    final provider = Provider.of<NavigationProvider>(context);
    final currentIteam = provider.navigationIteam;
    final isSelected = item == currentIteam;

    final color = isSelected ? Colors.red :Color(0xFF3A3A55);

    return Material(
      color: Colors.transparent,
      child: ListTile(
        visualDensity: VisualDensity(horizontal: 0, vertical: -2),
        selected: isSelected,
        selectedTileColor: Colors.white24,
        leading: Image(
          image: image,
          color: color,
        ),
        title: Text(text, style: TextStyle(color: color)),
        onTap: () => selectItem(context, item),
      ),
    );
  }
  void selectItem(BuildContext context, NavigationItem item) {
  final provider = Provider.of<NavigationProvider>(context,listen: false);
  provider.setNavigationIteam(item);
}
}

