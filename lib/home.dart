import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Home extends StatelessWidget {
  const Home({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Material(
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.grey.shade200, width: 8),
      ),
      child: Column(
        children: [
          _MainBar(),
          Expanded(
            child: Row(
              children: [_SideMenu(), Expanded(child: child)],
            ),
          )
        ],
      ),
    );
  }
}

class _MainBar extends StatelessWidget {
  const _MainBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(color: Colors.grey.shade200, width: 8))),
      child: SizedBox(
        height: 75,
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.only(end: 12),
                child: CircleAvatar(backgroundColor: Colors.grey.shade200),
              ),
              Text('Muhammad'),
              Spacer(),
              Padding(
                padding: const EdgeInsetsDirectional.only(end: 12),
                child: IconButton(
                    splashRadius: 24,
                    onPressed: () {},
                    icon: Icon(Icons.notifications)),
              ),
              ElevatedButton(onPressed: () {}, child: Text('Logout'))
            ],
          ),
        ),
      ),
    );
  }
}

class _SideMenu extends StatefulWidget {
  const _SideMenu({Key? key}) : super(key: key);

  @override
  State<_SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<_SideMenu> {
  var currentTab = 'home';

  @override
  Widget build(BuildContext context) {
    item(iconData, title, value) {
      final child = InkWell(
        onTap: () {
          context.goNamed('home', params: {'tab': value});
          setState(() {
            currentTab = value;
          });
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 6),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.only(end: 12),
                child: Icon(iconData),
              ),
              Text(title),
            ],
          ),
        ),
      );

      if (value == currentTab) {
        return Material(color: Colors.white, child: child);
      }

      return child;
    }

    return Material(
      color: Colors.grey.shade200,
      child: SizedBox(
        width: 300,
        child: Padding(
          padding: const EdgeInsets.only(top: 36),
          child: Column(children: [
            item(Icons.home, 'Home', 'home'),
            item(Icons.settings, 'Settings', 'settings')
          ]),
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Material(
      child: Center(
        child: Text('HomeScreen'),
      ),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Material(
      child: Center(
        child: Text('SettingsScreen'),
      ),
    );
  }
}
