import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sounds_good/core/viewmodels/profile_mode_viewmodel.dart';
import 'package:sounds_good/core/viewmodels/profile_viewmodel.dart';
import 'package:sounds_good/screens/widgets/profile/shared/profile_close_button.dart';
import 'package:sounds_good/screens/widgets/profile/shared/profile_modes.dart';

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
    return Consumer<ProfileModeViewModel>(
      builder: (context, mode, child) => Container(
        child: Consumer<ProfileViewModel>(
          builder: (context, model, child) =>
              _modeSwitchHelper(context, mode, model),
        ),
      ),
    );
  }

  Widget _modeSwitchHelper(context, mode, model) {
    Widget buttons;
    switch (mode.getMode) {
      case ProfileMode.user:
        buttons = _userModeButtons();
        break;

      case ProfileMode.own:
        buttons = _ownModeButtons();
        break;

      case ProfileMode.edit:
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
              child: ProfileCloseButton(value: 'Cancel', onPressed: _dismiss),
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
