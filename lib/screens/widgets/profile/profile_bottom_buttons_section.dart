import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sounds_good/core/utils/enums.dart';
import 'package:sounds_good/core/viewmodels/profile_viewmodel.dart';
import 'package:sounds_good/screens/widgets/profile/edit/edit_profile_cta_buttons.dart';
import 'package:sounds_good/screens/widgets/profile/own/own_profile_cta_buttons.dart';
import 'package:sounds_good/screens/widgets/profile/shared/profile_close_button.dart';
import 'package:sounds_good/screens/widgets/profile/user/user_profile_cta_buttons.dart';

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

      case ProfileMode.User:
        ctaButtons = UserProfileCTAButtons();
        break;
    }

    return ctaButtons;
  }
}

/*
// TODO Esto hay que rehacerlo entero

class ProfileBottomButtonsSection extends StatefulWidget {
  @override
  _ProfileBottomButtonsSectionState createState() =>
      _ProfileBottomButtonsSectionState();
}

class _ProfileBottomButtonsSectionState
    extends State<ProfileBottomButtonsSection> {
  void _handleEdit(model) {
    model.updateInstrumentsList();
    Navigator.pushNamed(context, 'profile');
  }

  void _dismiss() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileViewModel>(
      builder: (context, model, child) => _modeSwitchHelper(context, model),
    );
  }

  Widget _modeSwitchHelper(context, model) {
    Widget buttons;
    switch (model.getMode) {
      case ProfileMode.User:
        buttons = _userModeButtons();
        break;

      case ProfileMode.Own:
        buttons = _ownModeButtons();
        break;

      case ProfileMode.Edit:
        buttons = _editModeButtons(context, model);
        break;
    }
    return buttons;
  }

  Widget _editModeButtons(context, model) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            SizedBox(
              width: MediaQuery.of(context).size.width - 50.0,
              child: RaisedButton(
                onPressed: () {
                  model.updateInstrumentsList();
                  Navigator.pushNamed(context, 'profile');
                },
                color: Colors.red.shade400,
                child: Text('Accept', style: TextStyle(fontSize: 18)),
                shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(10.0),
                ),
              ),
            ),
          ],
        ),
        Row(
          children: <Widget>[
            SizedBox(
              width: MediaQuery.of(context).size.width - 50.0,
              child: ProfileCloseButton(
                  value: 'Cancel', onPressed: model.setMode(ProfileMode.Own)),
            ),
          ],
        ),
      ],
    );
  }

  Widget _ownModeButtons() {
    return ProfileCloseButton(
        // TODO LogOut()
        value: 'Close Session',
        onPressed: _dismiss);
  }

  Widget _userModeButtons() {
    return Container();
  }
}
*/
