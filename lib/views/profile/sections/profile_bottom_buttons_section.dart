import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sounds_good/core/utils/enums.dart';
import 'package:sounds_good/core/viewmodels/profile_viewmodel.dart';
import 'package:sounds_good/views/profile/widgets/edit/edit_profile_cta_buttons.dart';
import 'package:sounds_good/views/profile/widgets/own/own_profile_cta_buttons.dart';
import 'package:sounds_good/views/profile/widgets/member/member_profile_cta_buttons.dart';

class ProfileCTAButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _profileMode = Provider.of<ProfileViewModel>(context).getMode;

    Widget ctaButtons;

    switch (_profileMode) {
      case ProfileMode.Own:
        ctaButtons = OwnProfileCTAButtons();
        break;

      case ProfileMode.Edit:
        ctaButtons = EditProfileCTAButtons();
        break;

      case ProfileMode.Member:
        ctaButtons = MemberProfileCTAButtons();
        break;
    }

    return ctaButtons;
  }
}
