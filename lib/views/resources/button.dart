import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String value;
  final Function onPressed; 

  Button({this.value, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
        onPressed: onPressed,
        child: Text(this.value ?? 'button', style: TextStyle(fontSize: 18)),
        shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(10.0),
                          )
        );
  }
}