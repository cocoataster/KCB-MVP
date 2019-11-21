import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HowToReachMeSelector extends StatefulWidget {
  @override
  _HowToReachMeSelectorState createState() => _HowToReachMeSelectorState();
}

class _HowToReachMeSelectorState extends State<HowToReachMeSelector> {
  final Map<int, Widget> logoWidgets = const <int, Widget>{
    0: Text('Mail'),
    1: Text('WhatsApp'),
  };

  int sharedValue = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 50.0,
            width: 180.0,
            child: CupertinoSegmentedControl<int>(
              padding: EdgeInsets.all(0.0),
              borderColor: Colors.blueGrey,
              selectedColor: Colors.blueGrey,
              children: logoWidgets,
              onValueChanged: (int val) {
                setState(() {
                  sharedValue = val;
                });
              },
              groupValue: sharedValue,
            ),
          ),
          SizedBox(
            width: 180.0,
            height: 32.0,
            child: TextField(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 0),
               hintText: 'Add your email address:',
               hintStyle: TextStyle(fontSize: 14.0),
                border: new OutlineInputBorder(
                  borderRadius: const BorderRadius.all(
                    const Radius.circular(5.0),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
