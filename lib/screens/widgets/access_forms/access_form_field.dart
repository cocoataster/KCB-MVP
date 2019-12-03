import 'package:flutter/material.dart';

typedef String TextFieldValidator({String value, String errorMessage});

class AppAccessFormField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final String hintText;
  final bool isSensitive;
  final TextFieldValidator validator;
  final String errorMessage;

  AppAccessFormField(
      {this.label,
      this.controller,
      this.hintText,
      this.isSensitive,
      this.validator,
      this.errorMessage});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 20.0, bottom: 5.0),
            child: Text(label),
          ),
          TextFormField(
            validator: (value) => validator(value: value, errorMessage: errorMessage),
            obscureText: isSensitive,
            decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                labelStyle: TextStyle(fontSize: 20),
                border: new OutlineInputBorder(
                  borderRadius: const BorderRadius.all(
                    const Radius.circular(5.0),
                  ),
                ),
                hintText: hintText),
            style: TextStyle(color: Colors.blueGrey.shade300),
            controller: controller,
          ),
        ],
      ),
    );
  }
}
