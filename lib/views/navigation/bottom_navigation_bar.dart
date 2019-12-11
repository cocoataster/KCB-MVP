import 'package:flutter/material.dart';
import 'package:sounds_good/views/navigation/app_icons.dart';
import 'package:sounds_good/views/dummy_view.dart';
import 'package:sounds_good/views/profile/profile_view.dart';

class BottomTabBar extends StatefulWidget {
  BottomTabBar({Key key}) : super(key: key);

  @override
  _BottomTabBarState createState() => _BottomTabBarState();
}

class _BottomTabBarState extends State<BottomTabBar> {
  int _selectedIndex = 0;
 
 static List<Widget> _widgetOptions = <Widget>[
    DummyView('Home'),
    DummyView('Search'),
    DummyView('Notificaciones'),
    ProfileView(),
  ];

  @override
  void initState() {
    super.initState();
    _selectedIndex = 3;
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(CustomIcons.home),
              title: Padding(padding: EdgeInsets.all(0))),
          BottomNavigationBarItem(
              icon: Icon(CustomIcons.search),
              title: Padding(padding: EdgeInsets.all(0))),
          BottomNavigationBarItem(
              icon: Icon(Icons.chat_bubble_outline),
              title: Padding(padding: EdgeInsets.all(0))),
          BottomNavigationBarItem(
              icon: Icon(CustomIcons.profile),
              title: Padding(padding: EdgeInsets.all(0))),
        ],
        currentIndex: _selectedIndex,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Color.fromRGBO(131, 142, 222, 1.0),
        onTap: _onItemTapped,
      ),
    );
  }
}
