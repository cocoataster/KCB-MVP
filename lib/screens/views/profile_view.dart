import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sounds_good/core/utils/enums.dart';
import 'package:sounds_good/core/viewmodels/profile_viewmodel.dart';
import 'package:sounds_good/screens/widgets/profile/profile_bottom_buttons_section.dart';
import 'package:sounds_good/screens/widgets/profile/profile_header_section.dart';
import 'package:sounds_good/core/viewmodels/base_viewmodel.dart';
import 'base_view.dart';

import 'dart:io';


class ProfileView extends StatefulWidget {
  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  File _pickedImage;

  Future<bool> _captureAndroidBackButton() {
    /*
    if (profileMode == ProfileMode.edit) {
      setState(() {
        profileMode = ProfileMode.own;
      });
      return Future(() => false);
    } else {
      return Future(() => true);
    }*/
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<ProfileViewModel>(
      onModelReady: (model) {
        model.fetchProfile();
      },
      builder: (context, model, child) => WillPopScope(
        child: Scaffold(
            body: model.state == ViewState.Idle
                ? SafeArea(
                    child: ListView(
                      padding: const EdgeInsets.all(24),
                      children: <Widget>[
                        ProfileHeaderSection(image: _pickedImage),

                        /* InstrumentsSection(profileMode: mode),
                        ProfileVideosSection(profileMode: mode),
                        ProfileDescriptionSection(
                          profileMode: mode,
                          descriptionText: descriptionController.text,
                          controller: descriptionController,
                        ),*/
                        ProfileCTAButtons(),
                      ],
                    ),
                  )
                : Center(
                    child: CircularProgressIndicator(),
                  )),
        onWillPop: () => _captureAndroidBackButton(),
      ),
    );
  }
}
