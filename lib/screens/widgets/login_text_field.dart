import 'package:flutter/material.dart';

class LoginTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool isSensitive;

  LoginTextField(this.controller, this.hintText, this.isSensitive);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextField(
        obscureText: isSensitive,
        decoration: InputDecoration(
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.blueGrey,
              ),
              borderRadius: BorderRadius.circular(15.0),
            ),
            hintText: hintText),
        controller: controller,
      ),
    );
  }
}
