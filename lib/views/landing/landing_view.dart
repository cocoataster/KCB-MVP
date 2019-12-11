import 'package:flutter/material.dart';
import 'package:sounds_good/views/landing/landing_locals_view.dart';
import 'package:sounds_good/views/landing/landing_members_view.dart';

class LandingView extends StatefulWidget {
  LandingView({Key key}) : super(key: key);

  @override
  _LandingViewState createState() => _LandingViewState();
}

class _LandingViewState extends State<LandingView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Container(
              child: LandingLocalsView(),
            ),
            Container(
              child: LandingMembersView(),
            ),
          ],
        ),
      ),
    );
  }
}
