import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sounds_good/core/utils/enums.dart';
import 'package:sounds_good/core/viewmodels/profile_viewmodel.dart';
import 'package:sounds_good/screens/widgets/profile/edit/how_to_reach_me.dart';
import 'package:sounds_good/screens/widgets/profile/shared/profile_mode_switch_button.dart';
import 'package:sounds_good/screens/widgets/profile/shared/profile_image.dart';
import 'package:sounds_good/screens/widgets/profile/edit/profile_image.dart';
import 'package:sounds_good/screens/widgets/profile/own/header.dart';
import 'package:sounds_good/screens/widgets/profile/edit/header.dart';

import 'dart:io';

import 'package:sounds_good/screens/widgets/profile/shared/section_title.dart';

class ProfileHeaderSection extends StatefulWidget {
  
  @override
  _ProfileHeaderSectionState createState() => _ProfileHeaderSectionState();
}

class _ProfileHeaderSectionState extends State<ProfileHeaderSection> {

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileViewModel>(
      builder: (context, mode, child) => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _modeSwitchHelper(mode.getMode),
      ),
    );
  }

  List<Widget> _modeSwitchHelper(profileMode) {
    List<Widget> widgetsList = [];
    switch (profileMode) {
      case ProfileMode.User:
        widgetsList = _userModeWidgetsList();
        break;

      case ProfileMode.Own:
        widgetsList = _ownModeWidgetsList();
        break;

      case ProfileMode.Edit:
        widgetsList = _editModeWidgetsList();
        break;
    }

    return widgetsList;
  }

  List<Widget> _userModeWidgetsList() {
    return <Widget>[
      _headerHelper(
        buttonHeader: ProfileModeSwitchButton(),
        headerContent: UserProfileHeader(),
      ),
      ProfileImage(),
    ];
  }

  List<Widget> _ownModeWidgetsList() {
    return <Widget>[
      _headerHelper(
        buttonHeader: ProfileModeSwitchButton(),
        headerContent: UserProfileHeader(),
      ),
      ProfileImage(),
    ];
  }

  List<Widget> _editModeWidgetsList() {
    return <Widget>[
      _headerHelper(
        buttonHeader: Container(),
        headerContent: EditProfileHeader(),
      ),
      EditProfileImage(),
      ProfileSectionTitle(sectionTitle: 'How to reach me'),
      HowToReachMeSelector(),
    ];
  }

  Widget _headerHelper({Widget buttonHeader, Widget headerContent}) {
    return Stack(
      children: <Widget>[
        buttonHeader,
        headerContent,
      ],
    );
  }
}
