import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sounds_good/core/utils/enums.dart';
import 'package:sounds_good/core/viewmodels/profile_viewmodel.dart';

class HowToReachMeSelector extends StatefulWidget {
  @override
  _HowToReachMeSelectorState createState() => _HowToReachMeSelectorState();
}

class _HowToReachMeSelectorState extends State<HowToReachMeSelector> {
  final Map<ContactMethodType, Widget> logoWidgets =
      const <ContactMethodType, Widget>{
    ContactMethodType.Email: Text('Mail'),
    ContactMethodType.Phone: Text('WhatsApp'),
  };

  String textFieldValue = '';
  ContactMethodType typeSelected;

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileViewModel>(
      builder: (context, model, child){ 
        print('Contact Method: ${model.profile.contactMethod}');
        return Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 50.0,
              width: 180.0,
              child: CupertinoSegmentedControl<ContactMethodType>(
                padding: EdgeInsets.all(0.0),
                borderColor: Colors.blueGrey,
                selectedColor: Colors.blueGrey,
                children: logoWidgets,
                onValueChanged: (selection) {
                  setState(() {
                    typeSelected = selection;

                    model.updateContactMethod(
                            type: selection, data: textFieldValue);
                  });
                },
                groupValue: typeSelected,
              ),
            ),
            SizedBox(
              width: 240.0,
              height: 32.0,
              child: TextField(
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                  hintText: typeSelected == ContactMethodType.Phone
                      ? 'Insert your Phone Number'
                      : 'Insert your Email Address',
                  hintStyle: TextStyle(
                    fontSize: 14.0,
                    color: Colors.blueGrey.shade200,
                  ),
                  border: new OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      const Radius.circular(5.0),
                    ),
                  ),
                ),
                onChanged: (fieldContent) => {
                  setState(() {
                    textFieldValue = fieldContent;
                  })
                },
              ),
            ),
          ],
        ),
      );}
    );
  }
}
