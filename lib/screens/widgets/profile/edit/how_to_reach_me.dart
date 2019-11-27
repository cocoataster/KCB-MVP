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
  
  String textFieldValue;
  ContactMethodType typeSelected;
  String phoneHint = 'Insert your Phone Number';
  String emailHint = 'Insert your Email Address';
  TextEditingController _textFieldController;

  String getfieldValue(String data) {
    String value;
    
    if(textFieldValue == ''){
        typeSelected == ContactMethodType.Email ? value = emailHint : value = phoneHint; 
    } else {
      value = textFieldValue;
    }

    return value;
  }

  @override
  void initState() {
    typeSelected = Provider.of<ProfileViewModel>(context, listen: false).profile.contactMethod.type;
    _textFieldController = TextEditingController(text: Provider.of<ProfileViewModel>(context, listen: false).profile.contactMethod.data);
    super.initState();
  }

  _clearTextField() {
    _textFieldController = TextEditingController(text: ''); 
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileViewModel>(builder: (context, model, child) {
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
                    _clearTextField();
                    model.updateContactMethodType(selection);
                  });
                },
                groupValue: typeSelected,
              ),
            ),
            SizedBox(
              width: 240.0,
              height: 32.0,
              
              child: TextFormField(
                controller: _textFieldController,
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                
                  border: new OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      const Radius.circular(5.0),
                    ),
                  ),
                ),
                style: TextStyle(color: Colors.blueGrey.shade300),
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
