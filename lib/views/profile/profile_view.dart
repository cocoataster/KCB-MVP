import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sounds_good/core/utils/enums.dart';
import 'package:sounds_good/core/viewmodels/profile_viewmodel.dart';
import 'package:sounds_good/views/profile/sections/follows_section.dart';
import 'package:sounds_good/views/profile/sections/instruments_section.dart';
import 'package:sounds_good/views/profile/sections/profile_bottom_buttons_section.dart';
import 'package:sounds_good/views/profile/sections/profile_description_section.dart';
import 'package:sounds_good/views/profile/sections/profile_header_section.dart';
import 'package:sounds_good/views/profile/sections/profile_videos_section.dart';

class ProfileView extends StatefulWidget {
  final String cuid;
  ProfileView([this.cuid]);

  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  ProfileViewModel profileViewModel = ProfileViewModel();

  Future<bool> _captureAndroidBackButton(ProfileViewModel profileViewModel) {
    switch (profileViewModel.getMode) {
      case ProfileMode.Edit:
        profileViewModel.setMode(ProfileMode.Own);
        return Future(() => false);
      case ProfileMode.Own:
        return Future(() => false);
      case ProfileMode.Member:
        return Future(() => true);
      default:
        return Future(() => false);
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.cuid == null) {
      profileViewModel.fetchProfile();
    } else {
      profileViewModel.fetchMemberProfile(widget.cuid);
      profileViewModel.setMode(ProfileMode.Member);
    }
  }

  @override
  Widget build(BuildContext context) {
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
                        if (profileViewModel.getMode == ProfileMode.Member)
                          FollowMembersSection(memberId: widget.cuid),
                        InstrumentsSection(),
                        ProfileVideosSection(),
                        ProfileDescriptionSection(),
                        ProfileCTAButtons(),
                      ],
                    ),
                  )
                : Center(
                    child: CircularProgressIndicator(),
                  ),
          ),
          onWillPop: () => _captureAndroidBackButton(profileViewModel),
        ),
      ),
    );
  }
}
