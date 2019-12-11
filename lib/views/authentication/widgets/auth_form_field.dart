import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sounds_good/core/utils/enums.dart';
import 'package:sounds_good/core/viewmodels/authentication_viewmodel.dart';

typedef String TextFieldValidator({String value, String errorMessage});
typedef void ViewModelMethodCallback(String value);

class AuthFormField extends StatelessWidget {
  final String initialValue;
  final String label;
  final String hintText;
  final bool isSensitive;
  final TextFieldValidator validator;
  final String errorMessage;
  final ViewModelMethodCallback action;

  AuthFormField(
      {this.initialValue,
      this.label,
      this.hintText,
      this.isSensitive,
      this.validator,
      this.errorMessage,
      this.action});

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
            initialValue: Provider.of<AuthenticationViewModel>(context, listen: false).getMode == AuthFormMode.Login ? initialValue : '',
            validator: (value) =>
                validator(value: value, errorMessage: errorMessage),
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
              hintText: hintText,
            ),
            style: TextStyle(color: Colors.blueGrey.shade300),
            onChanged: (value) => action(value),
          ),
        ],
      ),
    );
  }
}
