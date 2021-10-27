import 'package:audio_story/screens/subscribe/subscribe.dart';
import 'package:flutter/material.dart';

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
          ListTile(
            visualDensity: VisualDensity(horizontal: 0, vertical: -4),
            leading: Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Image(
                image: AssetImage('assets/Home.png'),
              ),
            ),
            title: const Text("Главная"),
            onTap: () {},
          ),
          ListTile(
            visualDensity: VisualDensity(horizontal: 0, vertical: -4),
            leading: Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Image(
                image: AssetImage('assets/Profile.png'),
              ),
            ),
            title: const Text("Профиль"),
            onTap: () {},
          ),
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
          ),
        ],
      ),
    );
  }
}
