import 'package:flutter/material.dart';
import 'package:sounds_good/core/utils/enums.dart';
import 'package:sounds_good/core/viewmodels/instruments_viewmodel.dart';
import 'package:sounds_good/core/viewmodels/profile_viewmodel.dart';
import 'package:sounds_good/screens/widgets/profile/instruments_section.dart';
import 'package:sounds_good/screens/widgets/profile/profile_bottom_buttons_section.dart';
import 'package:sounds_good/screens/widgets/profile/profile_description_section.dart';
import 'package:sounds_good/screens/widgets/profile/profile_header_section.dart';
import 'package:sounds_good/screens/widgets/profile/profile_videos_section.dart';
import '../../locator.dart';
import 'base_view.dart';

class ProfileView extends StatefulWidget {
  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {

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
  Widget build(BuildContext context) {
    return BaseView<ProfileViewModel>(
      onModelReady: (model) {
        model.fetchProfile();
      },
      builder: (context, model, child) => BaseView<InstrumentsViewModel>(
      onModelReady: (modelInstruments) {
        modelInstruments.fetchInstruments();
      },
      builder: (context, modelInstruments, child) => WillPopScope(
        child: Scaffold(
            body: model.state == ViewState.Idle
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
        onWillPop: () => _captureAndroidBackButton(model.getMode),
      ),
    ),);
  }
}
