import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sounds_good/core/utils/enums.dart';
import 'package:sounds_good/core/utils/text_strings.dart';
import 'package:sounds_good/core/viewmodels/profile_viewmodel.dart';
import 'package:sounds_good/views/profile/widgets/edit/how_to_reach_me.dart';
import 'package:sounds_good/views/profile/widgets/shared/header.dart';
import 'package:sounds_good/views/profile/widgets/shared/profile_image.dart';
import 'package:sounds_good/views/profile/widgets/shared/profile_mode_switch_button.dart';
import 'package:sounds_good/views/profile/widgets/edit/header.dart';
import 'package:sounds_good/views/shared_resources/section_title.dart';

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
    return Consumer<ProfileViewModel>(
      builder: (context, profileViewModel, child) => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Stack(
            children: <Widget>[
              if (profileViewModel.getMode != ProfileMode.Edit)
                ProfileModeSwitchButton(),
              profileViewModel.getMode == ProfileMode.Edit
                  ? EditProfileHeader()
                  : MemberProfileHeader(),
            ],
          ),
          ProfileImage(avatarURL: profileViewModel.profile.photo),
          if (profileViewModel.getMode == ProfileMode.Edit) ContactSection(),
        ],
      ),
    );
  }
}

class ContactSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SectionTitle(sectionTitle: TextStrings.profile_contact_section_title),
        HowToReachMeSelector()
      ],
    );
  }
}
