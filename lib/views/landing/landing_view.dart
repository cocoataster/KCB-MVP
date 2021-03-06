import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:sounds_good/core/services/locator.dart';
import 'package:sounds_good/core/utils/text_strings.dart';
import 'package:sounds_good/core/utils/text_styles.dart';
import 'package:sounds_good/core/viewmodels/landing_viewmodel.dart';
import 'package:sounds_good/views/landing/sections/landing_locals_view.dart';
import 'package:sounds_good/views/landing/sections/landing_members_view.dart';

class LandingView extends StatefulWidget {
  LandingView({Key key}) : super(key: key);

  @override
  _LandingViewState createState() => _LandingViewState();
}

class _LandingViewState extends State<LandingView> {
  final LandingViewModel landingViewModel = LandingViewModel();

  Position _currentPosition;

  Position _getCurrentLocation() {
    final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;

    Locator.getCurrentLocation();

    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      return geolocator;
      // print('Current position: $position');
    }).catchError((e) {
      print(e);
    });
  }

  @override
  void initState() {
    _currentPosition = _getCurrentLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LandingViewModel>(
      builder: (context) => landingViewModel,
      child: WillPopScope(
        onWillPop: () => Future(() => false),
        child: Scaffold(
          body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.symmetric(vertical: 5),
                  height: 40,
                  child: Center(
                    child: Image.asset(
                      'assets/images/logo.png',
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 5.0, left: 14),
                  child: Text(
                    TextStrings.landing_first_headline,
                    style: TextStyles.landing_headline,
                  ),
                ),
                Container(
                  height: (MediaQuery.of(context).size.height - 190) / 2,
                  child: LandingLocalsView(),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 5.0, left: 14),
                  child: Text(
                    TextStrings.landing_second_headline,
                    style: TextStyles.landing_headline,
                  ),
                ),
                Container(
                  height: (MediaQuery.of(context).size.height - 190) / 2,
                  child: LandingMembersView(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
