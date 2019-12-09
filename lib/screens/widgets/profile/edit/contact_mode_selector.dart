import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sounds_good/core/utils/enums.dart';

class ContactModeSelector extends StatefulWidget {
  @override
  _ContactModeSelectorState createState() => _ContactModeSelectorState();
}

class _ContactModeSelectorState extends State<ContactModeSelector> {
  final Map<ContactMethodType, Widget> logoWidgets =
      const <ContactMethodType, Widget>{
    ContactMethodType.Email: Text('Mail'),
    ContactMethodType.Phone: Text('WhatsApp'),
  };

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.0,
      width: 180.0,
      child: CupertinoSegmentedControl<ContactMethodType>(
        padding: EdgeInsets.all(0.0),
        borderColor: Colors.blueGrey,
        selectedColor: Colors.blueGrey,
        children: logoWidgets,
        onValueChanged: (selection) {},
        //groupValue: typeSelected,
      ),
    );
  }
}
