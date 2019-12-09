import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sounds_good/screens/views/app_icons.dart';
import 'package:sounds_good/screens/views/dummy_view.dart';
import 'package:sounds_good/screens/views/profile_view.dart';
import 'package:sounds_good/screens/views/search_view.dart';

class AppTabBar extends StatefulWidget {
  AppTabBar({Key key}) : super(key: key);

  @override
  _AppTabBarState createState() => _AppTabBarState();
}

class _AppTabBarState extends State<AppTabBar> {
  
  bool isLoggedIn = false;
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    setState(() {
      _selectedIndex = 3;
    });
    super.initState();
  }

  static List<Widget> _widgetOptions = <Widget>[
    DummyView('Home'),
    SearchView(),
    DummyView('Notificaciones'),
    ProfileView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: CupertinoTabBar(
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
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
