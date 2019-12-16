import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sounds_good/core/utils/enums.dart';
import 'package:sounds_good/core/utils/text_strings.dart';
import 'package:sounds_good/core/viewmodels/profile_viewmodel.dart';

class MemberProfileCTAButtons extends StatelessWidget {
  const MemberProfileCTAButtons({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileViewModel>(
      builder: (context, profileViewModel, child) {
        return Container(
          alignment: Alignment(1, 0),
          width: 40.0,
          height: 40.0,
          child: FloatingActionButton(
            backgroundColor: Colors.white,
            elevation: 4,
            shape: CircleBorder(),
            child: profileViewModel.profile.contactMethod.type ==
                    ContactMethodType.Email
                ? Icon(Icons.email,
                    color: Colors.black,
                    semanticLabel: TextStrings.profile_contact_action_mail)
                : Image.asset('assets/images/whatsapp.png',
                    semanticLabel: TextStrings.profile_contact_action_whatsapp),
            onPressed: () => {},
          ),
        );
      },
    );
  }
}
