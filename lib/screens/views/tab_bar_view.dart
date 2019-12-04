import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sounds_good/screens/views/app_icons.dart';
import 'package:sounds_good/screens/views/dummy_view.dart';
import 'package:sounds_good/screens/views/profile_view.dart';

class AppTabBar extends StatefulWidget {
  AppTabBar({Key key}) : super(key: key);

  @override
  _AppTabBarState createState() => _AppTabBarState();
}

class _AppTabBarState extends State<AppTabBar> {
  int _currentIndex;

  @override
  void initState() {
    setState(() {
      _currentIndex = 3;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
          currentIndex: _currentIndex,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(CustomIcons.home),
            ),
            BottomNavigationBarItem(
              icon: Icon(CustomIcons.search),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.chat_bubble_outline),
            ),
            BottomNavigationBarItem(
              icon: Icon(CustomIcons.profile),
            ),
          ],
          activeColor: Color.fromRGBO(131, 142, 222, 1.0),
        ),
        tabBuilder: (BuildContext context, int index) {
          _currentIndex = index;
          assert(index >= 0 && index <= 3);
          switch (index) {
            case 0:
              return CupertinoTabView(

                builder: (BuildContext context) => DummyView('Home'),
              );
              break;
            case 1:
              return CupertinoTabView(
                builder: (BuildContext context) => DummyView('Search'),
              );
              break;
            case 2:
              return CupertinoTabView(
                builder: (BuildContext context) => DummyView('Notificaciones?'),
              );
              break;
            case 3:
              return CupertinoTabView(
                builder: (BuildContext context) => ProfileView(),
              );
              break;
          }
          return null;
        },
      ),
    );
  }
}
