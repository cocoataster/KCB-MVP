import 'package:flutter/material.dart';
import 'login_text_field.dart';

class LoginHeader extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;

  LoginHeader(this.emailController, this.passwordController);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: <Widget>[
          Text('Email'),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: LoginTextField(
                emailController, 'johnandyoko@soundsgood.jp', false),
          ),
          Text('Password'),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: LoginTextField(passwordController, '******', true),
          )
        ],
      ),
    );
  }
}
