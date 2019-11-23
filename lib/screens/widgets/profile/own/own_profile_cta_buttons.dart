import 'package:flutter/material.dart';
import 'package:sounds_good/screens/widgets/profile/shared/profile_close_button.dart';

class OwnProfileCTAButtons extends StatelessWidget {
  const OwnProfileCTAButtons({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProfileCloseButton(
        // TODO LogOut()
        value: 'Close Session',
        onPressed: () => {});
  }
}
