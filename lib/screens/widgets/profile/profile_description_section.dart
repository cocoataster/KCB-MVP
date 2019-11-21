import 'package:flutter/material.dart';
import 'package:sounds_good/screens/widgets/profile/shared/profile_modes.dart';
import 'package:sounds_good/screens/widgets/profile/shared/section_title.dart';

class ProfileDescriptionSection extends StatelessWidget {
  final ProfileMode profileMode;
  final String descriptionText;
  final TextEditingController controller;

  ProfileDescriptionSection(
      {this.profileMode, this.descriptionText, this.controller});

  // TODO Edit mode for About Me

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Padding(
        padding: const EdgeInsets.only(top: 10.0, bottom: 30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ProfileSectionTitle(sectionTitle: 'About me'),
            _modeSwitchHelper(),
          ],
        ),
      ),
    ]);
  }

  Widget _modeSwitchHelper() {
    switch (profileMode) {
      case ProfileMode.edit:
        return _editModeWidget();
        break;

      default:
        return _plainWidget();
        break;
    }
  }

  Widget _editModeWidget() {
    return TextField(
      maxLines: null,
      decoration: InputDecoration.collapsed(
        hintText: descriptionText,
      ),
      controller: controller,
    );
  }

  Widget _plainWidget() {
    return Text(descriptionText);
  }

}
