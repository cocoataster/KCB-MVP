import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sounds_good/core/utils/enums.dart';
import 'package:sounds_good/core/utils/text_strings.dart';
import 'package:sounds_good/core/viewmodels/authentication_viewmodel.dart';
import 'package:sounds_good/views/authentication/widgets/auth_form_buttons.dart';
import 'package:sounds_good/views/authentication/widgets/auth_form_field.dart';
import 'package:sounds_good/views/authentication/widgets/auth_form_validators.dart';

class AuthFormView extends StatefulWidget {
  _AuthFormViewState createState() => _AuthFormViewState();
}

class _AuthFormViewState extends State<AuthFormView> {
  final _formKey = GlobalKey<FormState>();
  AuthenticationViewModel authViewModel = AuthenticationViewModel();

  @override
  void initState() {
    super.initState();
    authViewModel.authInit();
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
        resizeToAvoidBottomInset: false,
        body: Builder(
          builder: (context) {
            String email = authViewModel.getEmail() ?? '';
            String password = authViewModel.getPassword() ?? '';

            return Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 24.0, vertical: 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(top: 50),
                          child: Center(
                            child: Image.asset('assets/images/logo.png',
                                width: 150, fit: BoxFit.cover),
                          ),
                        ),
                        if (authViewModel.getMode == AuthFormMode.Signin)
                          SigninFields(),
                        AuthFormField(
                          initialValue: email,
                          label: TextStrings.authentication_email_label,
                          hintText: TextStrings.authentication_email_hint,
                          isSensitive: false,
                          validator: emailValidator,
                          errorMessage: TextStrings.authentication_email_error,
                          action: _updateEmail,
                        ),
                        AuthFormField(
                          initialValue: password,
                          label: TextStrings.authentication_password_label,
                          hintText: TextStrings.authentication_password_hint,
                          isSensitive: true,
                          validator: notEmptyValidator,
                          errorMessage:
                              TextStrings.authentication_password_error,
                          action: _updatePassword,
                        ),
                        if (authViewModel.getMode == AuthFormMode.Login)
                          Padding(
                            padding: EdgeInsets.only(top: 40.0),
                            child: InkWell(
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(TextStrings
                                        .authentication_register_message),
                                    Text(
                                      TextStrings
                                          .authentication_register_message_highlited,
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  ]),
                              onTap: () => Provider.of<AuthenticationViewModel>(
                                      context,
                                      listen: false)
                                  .setMode(AuthFormMode.Signin),
                            ),
                          )
                      ],
                    ),
                    AccessFormButtons(formKey: _formKey),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class SigninFields extends StatefulWidget {
  @override
  _SigninFieldsState createState() => _SigninFieldsState();
}

class _SigninFieldsState extends State<SigninFields> {
  void _updateName(String value) {
    setState(() {
      Provider.of<AuthenticationViewModel>(context, listen: false)
          .updateName(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        AuthFormField(
          initialValue: '',
          label: TextStrings.authentication_name_label,
          hintText: TextStrings.authentication_name_hint,
          isSensitive: false,
          validator: notEmptyValidator,
          errorMessage: TextStrings.authentication_name_error,
          action: _updateName,
        ),
      ],
    );
  }
}
