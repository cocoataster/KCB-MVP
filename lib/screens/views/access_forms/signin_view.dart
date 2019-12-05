import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sounds_good/core/viewmodels/authentication_viewmodel.dart';
import 'package:sounds_good/screens/widgets/access_forms/access_form_field.dart';
import 'package:sounds_good/screens/widgets/access_forms/validators.dart';

class SigninView extends StatefulWidget {
  _SigninViewState createState() => _SigninViewState();
}

class _SigninViewState extends State<SigninView> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  _handleSignin(AuthenticationViewModel viewModel) async {
    bool signinSuccess = false;
    bool loginSuccess = false;

    signinSuccess =
        await viewModel.signin(emailController.text, passwordController.text);

    if (signinSuccess) {
      loginSuccess =
          await viewModel.login(emailController.text, passwordController.text);
    }

    if (loginSuccess) {
      Navigator.pushNamed(context, 'profile');
    }

    return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: true,
        body: ListView(
          children: <Widget>[
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 24.0, vertical: 30.0),
              child: Builder(
                builder: (context) => Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      AppAccessFormField(
                          label: 'Name',
                          controller: nameController,
                          hintText: 'Enter a Nickname',
                          isSensitive: false,
                          validator: nameValidator,
                          errorMessage: 'Please enter a name'),
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
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 40.0),
              child: Column(
                children: <Widget>[
                  RaisedButton(
                    color: Theme.of(context).accentColor,
                    child: Text('Create Account',
                        style: TextStyle(fontSize: 16, color: Colors.white)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    onPressed: () {
                      final form = _formKey.currentState;
                      if (form.validate()) {
                        _handleSignin(Provider.of<AuthenticationViewModel>(context, listen: false));
                      }
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      
    );
  }
}
