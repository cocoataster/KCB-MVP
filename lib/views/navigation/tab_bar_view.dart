import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sounds_good/core/services/api.dart';
import 'package:sounds_good/core/services/storage.dart';
import 'package:sounds_good/views/navigation/app_icons.dart';
import 'package:sounds_good/views/landing/landing_view.dart';
import 'package:sounds_good/views/notifications/notifications_view.dart';
import 'package:sounds_good/views/profile/profile_view.dart';
import 'package:sounds_good/views/search/search_view.dart';

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

  static List<Widget> _widgetOptions = <Widget>[
    LandingView(),
    SearchView(),
    NotificationsView(),
    ProfileView(),
  ];

  @override
  void initState() {
    super.initState();
    // Save on Storage Available Instruments for later use on profile and filters
    Api().getInstruments()
        .then((res) {
          print('Res TabBar: $res');
      var availableInstruments = jsonEncode(res);
      print('Encoded: $availableInstruments');
      Storage.saveAvailableInstruments(availableInstruments);
    });

    _selectedIndex = 1;
  }

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
