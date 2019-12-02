import 'package:flutter/material.dart';

class LoginTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool isSensitive;

  LoginTextField(this.controller, this.hintText, this.isSensitive);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextFormField(
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
    );
  }
}
