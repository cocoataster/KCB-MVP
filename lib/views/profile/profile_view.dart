import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:sounds_good/core/utils/enums.dart';
import 'package:sounds_good/core/viewmodels/profile_viewmodel.dart';
import 'package:sounds_good/views/profile/widgets/instruments_section.dart';
import 'package:sounds_good/views/profile/profile_bottom_buttons_section.dart';
import 'package:sounds_good/views/profile/profile_description_section.dart';
import 'package:sounds_good/views/profile/profile_header_section.dart';
import 'package:sounds_good/views/profile/profile_videos_section.dart';


class ProfileView extends StatefulWidget {
  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  
  ProfileViewModel profileViewModel = ProfileViewModel();

  /* Para meter en la página de inicio y hacer llamada cada vez que haga falta 
   Position _currentPosition;*/

   _getCurrentLocation() {
    final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;

    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      // print('Current position: $position');
    }).catchError((e) {
      print(e);
    });
  }

  Future<bool> _captureAndroidBackButton(profileMode) {
    if (profileMode == ProfileMode.Edit) {
      setState(() {
        profileMode = ProfileMode.Own;
      });
      return Future(() => false);
    } else {
      return Future(() => true);
    }
  }

  

  @override
  void initState() {
    super.initState();
    profileViewModel.fetchProfile();
    profileViewModel.fetchAvailableInstruments();
  }



  @override
  Widget build(BuildContext context) {
    _getCurrentLocation();
    return ChangeNotifierProvider<ProfileViewModel>(
      builder: (context) => profileViewModel,
      child: Consumer<ProfileViewModel>(
        builder: (context, profileViewModel, child) => WillPopScope(
          child: Scaffold(
              body: profileViewModel.state == ViewState.Idle
                  ? SafeArea(
                      child: ListView(
                        padding: const EdgeInsets.all(24),
                        children: <Widget>[
                          ProfileHeaderSection(),
                          InstrumentsSection(),
                          ProfileVideosSection(),
                          ProfileDescriptionSection(),
                          ProfileCTAButtons(),
                        ],
                      ),
                    )
                  : Center(
                      child: CircularProgressIndicator(),
                    )),
          onWillPop: () => _captureAndroidBackButton(profileViewModel.getMode),
        ),
      ),
    );
  }
}
