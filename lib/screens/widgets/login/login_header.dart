import 'package:flutter/material.dart';
import 'login_text_field.dart';

class LoginHeader extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;

  LoginHeader(this.emailController, this.passwordController);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(bottom: 5.0),
              child: Text('Email'),
            ),
            LoginTextField(emailController, 'johnandyoko@soundsgood.jp', false),
            Padding(
              padding: EdgeInsets.only(top: 20.0, bottom: 5.0),
              child: Text('Password'),
            ),
            LoginTextField(passwordController, '******', true),
          ],
        ),
      ),
    );
  }
}
