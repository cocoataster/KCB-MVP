import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sounds_good/core/utils/enums.dart';
import 'package:sounds_good/core/viewmodels/profile_viewmodel.dart';
import 'package:sounds_good/screens/widgets/profile/edit/how_to_reach_me.dart';
import 'package:sounds_good/screens/widgets/profile/own/profile_image.dart';
import 'package:sounds_good/screens/widgets/profile/shared/profile_mode_switch_button.dart';
import 'package:sounds_good/screens/widgets/profile/edit/profile_image.dart';
import 'package:sounds_good/screens/widgets/profile/own/header.dart';
import 'package:sounds_good/screens/widgets/profile/edit/header.dart';
import 'package:sounds_good/screens/widgets/profile/shared/section_title.dart';
import 'package:sounds_good/screens/widgets/profile/user/profile_image.dart';

class ProfileHeaderSection extends StatefulWidget {
  @override
  _ProfileHeaderSectionState createState() => _ProfileHeaderSectionState();
}

class _ProfileHeaderSectionState extends State<ProfileHeaderSection> {
  @override
  void initState() {
    var profile = Provider.of<ProfileViewModel>(context, listen: false);
    if (profile.getAvatar() == null) profile.initializeAvatar();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileViewModel>(builder: (context, profile, child) {
      switch (profile.getMode) {
        case ProfileMode.Own:
          return OwnModeWidgetsList();
          break;

        case ProfileMode.Edit:
          return EditModeWidgetsList();
          break;

        default:
          return UserModeWidgetsList();
      }
    });
  }
}

class UserModeWidgetsList extends StatelessWidget {
  const UserModeWidgetsList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        HeaderHelper(
          buttonHeader: ProfileModeSwitchButton(),
          headerContent: UserProfileHeader(),
        ),
        ProfileImage(),
      ],
    );
  }
}

class OwnModeWidgetsList extends StatelessWidget {
  const OwnModeWidgetsList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        HeaderHelper(
          buttonHeader: ProfileModeSwitchButton(),
          headerContent: UserProfileHeader(),
        ),
        OwnProfileImage(),
      ],
    );
  }
}

class EditModeWidgetsList extends StatelessWidget {
  const EditModeWidgetsList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          HeaderHelper(
            buttonHeader: Container(),
            headerContent: EditProfileHeader(),
          ),
          EditProfileImage(),
          ProfileSectionTitle(sectionTitle: 'How to reach me'),
          HowToReachMeSelector(),
        ]);
  }
}

class HeaderHelper extends StatelessWidget {
  final Widget buttonHeader;
  final Widget headerContent;

  HeaderHelper({this.buttonHeader, this.headerContent});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        buttonHeader,
        headerContent,
      ],
    );
  }
}
