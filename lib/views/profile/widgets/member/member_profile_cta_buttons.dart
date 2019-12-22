import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:flutter_open_whatsapp/flutter_open_whatsapp.dart';
import 'package:provider/provider.dart';
import 'package:sounds_good/core/utils/enums.dart';
import 'package:sounds_good/core/utils/text_strings.dart';
import 'package:sounds_good/core/viewmodels/profile_viewmodel.dart';

class MemberProfileCTAButtons extends StatelessWidget {
  const MemberProfileCTAButtons({Key key}) : super(key: key);

 Future _sendEmail(emailAddress) async{
    

final Email email = Email(
  body: 'Email body',
  subject: 'Email subject',
  recipients: [emailAddress],
  isHTML: false,
);

await FlutterEmailSender.send(email);

}
 

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
            onPressed: () => {
              if (profileViewModel.profile.contactMethod.type ==
                  ContactMethodType.Email)
                {_sendEmail(profileViewModel.profile.contactMethod.data)}
              else
                {
                  FlutterOpenWhatsapp.sendSingleMessage(
                      profileViewModel.profile.contactMethod.data,
                      "Greetings from Tuned")
                }
            },
          ),
        );
      },
    );
  }
}

