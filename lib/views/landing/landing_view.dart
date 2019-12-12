import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sounds_good/core/viewmodels/search_viewmodel.dart';
import 'package:sounds_good/views/landing/landing_members_view.dart';

class LandingView extends StatefulWidget {
  LandingView({Key key}) : super(key: key);

  @override
  _LandingViewState createState() => _LandingViewState();
}

class _LandingViewState extends State<LandingView> {
  final SearchViewModel searchViewModel = SearchViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider<SearchViewModel>(
        builder: (context) => searchViewModel,
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 130),
                  child: Image.asset(
                    'assets/images/logo.png',
                  )),
              Padding(
                padding: EdgeInsets.only(top: 5.0, left: 14),
                child: Text(
                  'Where to play near to you',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                  ),
                ),
              ),
              Container(
                height: (MediaQuery.of(context).size.height - 175) / 2,
                child: LandingMembersView(),
              ),
              Padding(
                padding: EdgeInsets.only(top: 5.0, left: 14),
                child: Text(
                  'Your band',
                  style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w700,
                      color: Colors.black87),
                ),
              ),
              Container(
                height: (MediaQuery.of(context).size.height - 175) / 2,
                child: LandingMembersView(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
