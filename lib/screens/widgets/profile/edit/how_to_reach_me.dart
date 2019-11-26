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
  
  
  String hintContent;
  String textFieldValue;
  ContactMethodType typeSelected;
  String phoneHint = 'Insert your Phone Number';
  String emailHint = 'Insert your Email Address';

  @override
  void initState() {
    
    setState(() {
    hintContent = 'Hola';  
    });
    
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileViewModel>(builder: (context, model, child) {
     textFieldValue = model.getContactMethodData();
    typeSelected =  model.getContactMethodType();
switch(typeSelected){
      case ContactMethodType.Email:
      textFieldValue == '' ? hintContent = emailHint : hintContent = textFieldValue;
      break;
      case ContactMethodType.Phone:
      textFieldValue == '' ? hintContent = phoneHint : hintContent = textFieldValue;
      break;
   
      
          }

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
                    model.updateContactMethodType(selection);
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
                  hintText: hintContent,
                  hintStyle: TextStyle(
                    fontSize: 14.0,
                    color: Colors.blueGrey,
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
                    model.updateContactMethodData(fieldContent);
                  })
                },
              ),
            ),
          ],
        ),
      );
    });
  }
}
