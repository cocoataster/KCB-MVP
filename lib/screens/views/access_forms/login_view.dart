import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sounds_good/core/viewmodels/login_viewmodel.dart';
import 'package:sounds_good/screens/views/base_view.dart';
import 'package:sounds_good/screens/views/tab_bar_view.dart';
import 'package:sounds_good/screens/widgets/access_forms/access_form_field.dart';
import 'package:sounds_good/screens/widgets/access_forms/validators.dart';

class LoginView extends StatefulWidget {
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController emailController =
      TextEditingController(text: "cocoataster@gmail.com");
  final TextEditingController passwordController =
      TextEditingController(text: "soundsgood");

  _handleLogin(model) async {
    bool loginSuccess = false;
    loginSuccess =
        await model.login(emailController.text, passwordController.text);
    if (loginSuccess) {
      Navigator.push(
          context, CupertinoPageRoute(builder: (context) => AppTabBar()));
    }
    return;
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<LoginViewModel>(
      onModelReady: (model) {},
      builder: (context, model, child) => Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 24.0, vertical: 0.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  AppAccessFormField(
                      label: 'Email',
                      controller: emailController,
                      hintText: 'Enter a valid Email',
                      isSensitive: false,
                      validator: emailValidator,
                      errorMessage: 'Please enter a valid email'),
                  AppAccessFormField(
                      label: 'Password',
                      controller: passwordController,
                      hintText: 'Choose your Password',
                      isSensitive: true,
                      validator: passwdValidator,
                      errorMessage: 'Please enter a password'),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20.0),
              child: RaisedButton(
                color: Theme.of(context).accentColor,
                child: Text('Login',
                    style: TextStyle(fontSize: 16, color: Colors.white)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                onPressed: () => _handleLogin(model),
              ),
            ),
            Divider(
              height: 30.0,
            ),
            Text('- OR -'),
            Padding(
              padding: EdgeInsets.only(top: 20.0),
              child: RaisedButton(
                color: Theme.of(context).accentColor,
                child: Text('Create an Account',
                    style: TextStyle(fontSize: 16, color: Colors.white)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                onPressed: () => Navigator.pushNamed(context, 'signin'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
