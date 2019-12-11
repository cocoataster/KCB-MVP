import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sounds_good/core/utils/enums.dart';
import 'package:sounds_good/core/viewmodels/profile_viewmodel.dart';

class ProfileModeSwitchButton extends StatelessWidget {
  void _switchMode(mode) {
    //var mode = Provider.of<ProfileModeViewModel>(context, listen: false);
    ProfileMode profileMode = mode.getMode;
    profileMode == ProfileMode.Own ? mode.setMode(ProfileMode.Edit) : mode.setMode(ProfileMode.Own);
  }

  Icon _icon(profileMode) {
    return profileMode == ProfileMode.Own
        ? Icon(Icons.edit, color: Colors.black, semanticLabel: 'Edit Profile')
        : Icon(Icons.close, color: Colors.black, semanticLabel: 'Close Profile');
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileViewModel>(
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
