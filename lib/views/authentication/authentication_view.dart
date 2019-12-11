import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sounds_good/core/utils/enums.dart';
import 'package:sounds_good/core/viewmodels/authentication_viewmodel.dart';
import 'package:sounds_good/views/authentication/widgets/auth_form_buttons.dart';
import 'package:sounds_good/views/authentication/widgets/auth_form_field.dart';
import 'package:sounds_good/views/authentication/widgets/auth_form_validators.dart';

class AuthFormView extends StatefulWidget {
  _AuthFormViewState createState() => _AuthFormViewState();
}

class _AuthFormViewState extends State<AuthFormView> {
  final _formKey = GlobalKey<FormState>();

/*
  @override
  void initState() async {
    // TODO: implement initState
    super.initState();

    var token = await Storage.getToken();

    if (token != null) {
      Navigator.pushNamed(context, 'cupertinoTabBar');
    }
  } */

  AuthenticationViewModel viewModel = AuthenticationViewModel();

  void _updateName(String value) {
    setState(() {
      Provider.of<AuthenticationViewModel>(context, listen: false)
          .updateName(value);
    });
  }

  void _updateEmail(String value) {
    Provider.of<AuthenticationViewModel>(context, listen: false)
        .updateEmail(value);
  }

  void _updatePassword(String value) {
    Provider.of<AuthenticationViewModel>(context, listen: false)
        .updatePassword(value);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthenticationViewModel>(
      builder: (context, authViewModel, child) => Scaffold(
        body: Builder(
          builder: (context) => Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 24.0, vertical: 0.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      if (authViewModel.getMode == AuthFormMode.Signin)
                        AuthFormField(
                          initialValue: '',
                          label: 'Name',
                          hintText: 'Please enter your name',
                          isSensitive: false,
                          validator: notEmptyValidator,
                          errorMessage: 'Please enter a name',
                          action: _updateName,
                        ),
                      Text(authViewModel.getName()),
                      AuthFormField(
                        initialValue: authViewModel.getEmail(),
                        label: 'Email',
                        hintText: 'Enter a valid Email',
                        isSensitive: false,
                        validator: emailValidator,
                        errorMessage: 'Please enter a valid email',
                        action: _updateEmail,
                      ),
                      AuthFormField(
                        initialValue: authViewModel.getPassword(),
                        label: 'Password',
                        hintText: 'Choose your Password',
                        isSensitive: true,
                        validator: notEmptyValidator,
                        errorMessage: 'Please enter a password',
                        action: _updatePassword,
                      ),
                    ],
                  ),
                ),
                AccessFormButtons(formKey: _formKey)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
