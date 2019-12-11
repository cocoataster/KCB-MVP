import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sounds_good/core/utils/enums.dart';
import 'package:sounds_good/core/viewmodels/authentication_viewmodel.dart';

class AccessFormButtons extends StatefulWidget {
  final GlobalKey<FormState> formKey;

  AccessFormButtons({this.formKey});

  @override
  _AccessFormButtonsState createState() => _AccessFormButtonsState();
}

class _AccessFormButtonsState extends State<AccessFormButtons> {
  AuthFormMode formMode;

  @override
  void initState() {
    formMode =
        Provider.of<AuthenticationViewModel>(context, listen: false).getMode;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthenticationViewModel>(
      builder: (context, authViewModel, child) =>
          authViewModel.getMode == AuthFormMode.Login
              ? LoginButtons(formKey: widget.formKey)
              : SigninButtons(formKey: widget.formKey),
    );
  }
}

class LoginButtons extends StatelessWidget {
  final GlobalKey<FormState> formKey;

  LoginButtons({this.formKey});

  final AuthenticationViewModel viewModel = AuthenticationViewModel();

  _handleLogin(context) async {
    bool loginSuccess = false;
    var providerOfAuth =
        Provider.of<AuthenticationViewModel>(context, listen: false);
    String email = providerOfAuth.getEmail();
    String password = providerOfAuth.getPassword();

    loginSuccess = await providerOfAuth.login(email: email, password: password);

    if (loginSuccess) {
      Navigator.pushNamed(context, 'cupertinoTabBar');
    }
    return;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 20.0),
          child: RaisedButton(
            color: Theme.of(context).accentColor,
            child: Text('Login',
                style: TextStyle(fontSize: 16, color: Colors.white)),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            onPressed: () => _handleLogin(context),
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
            onPressed: () =>
                Provider.of<AuthenticationViewModel>(context, listen: false)
                    .setMode(AuthFormMode.Signin),
          ),
        ),
      ],
    );
  }
}

class SigninButtons extends StatelessWidget {
  final AuthenticationViewModel viewModel = AuthenticationViewModel();

  final GlobalKey<FormState> formKey;
  SigninButtons({this.formKey});

  @override
  Widget build(BuildContext context) {
    _handleSignin() async {
      bool signinSuccess = false;
      bool loginSuccess = false;
      var providerOfAuth =
          Provider.of<AuthenticationViewModel>(context, listen: false);
      String email = providerOfAuth.getEmail();
      String password = providerOfAuth.getPassword();

      signinSuccess = await viewModel.signin(email: email, password: password);

      if (signinSuccess) {
        loginSuccess = await viewModel.login(email: email, password: password);
      }

      if (loginSuccess) {
        Navigator.pushNamed(context, 'profile');
      }
    }

    return Padding(
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
              final form = formKey.currentState;
              if (form.validate()) {
                _handleSignin();
              }
            },
          ),
        ],
      ),
    );
  }
}
