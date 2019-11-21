import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sounds_good/core/viewmodels/profile_mode_viewmodel.dart';
import 'package:sounds_good/screens/widgets/profile/shared/profile_modes.dart';

class ProfileModeSwitchButton extends StatelessWidget {
  void _switchMode(mode) {
    //var mode = Provider.of<ProfileModeViewModel>(context, listen: false);
    ProfileMode profileMode = mode.getMode;
    profileMode == ProfileMode.own ? mode.setMode(ProfileMode.edit) : mode.setMode(ProfileMode.own);
  }

  Icon _icon(profileMode) {
    return profileMode == ProfileMode.own
        ? Icon(Icons.edit, color: Colors.black, semanticLabel: 'Edit Profile')
        : Icon(Icons.close, color: Colors.black, semanticLabel: 'Close Profile');
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileModeViewModel>(
      builder: (context, mode, child) => Positioned(
        top: 0,
        right: 0,
        child: Container(
          width: 40.0,
          height: 40.0,
          child: FloatingActionButton(
            backgroundColor: Colors.white,
            elevation: 4,
            shape: CircleBorder(),
            child: _icon(mode.getMode),
            onPressed: () => _switchMode(mode),
          ),
        ),
      ),
    );
  }
}
