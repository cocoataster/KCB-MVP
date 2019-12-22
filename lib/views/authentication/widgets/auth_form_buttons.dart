import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sounds_good/core/utils/colors.dart';
import 'package:sounds_good/core/utils/enums.dart';
import 'package:sounds_good/core/utils/text_strings.dart';
import 'package:sounds_good/core/utils/text_styles.dart';
import 'package:sounds_good/core/viewmodels/authentication_viewmodel.dart';
import 'package:sounds_good/views/shared_resources/full_width_button.dart';

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

  _handleLogin() async {
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

  _handleSignin() async {
    bool signinSuccess = false;
    bool loginSuccess = false;
    var providerOfAuth =
        Provider.of<AuthenticationViewModel>(context, listen: false);
    String email = providerOfAuth.getEmail();
    String password = providerOfAuth.getPassword();

    signinSuccess =
        await providerOfAuth.signin(email: email, password: password);

    if (signinSuccess) {
      loginSuccess =
          await providerOfAuth.login(email: email, password: password);
    }

    if (loginSuccess) {
      Navigator.pushNamed(context, 'profile');
    }
  }

  _handleClose() {
    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
  }

  _handleCancel() {
    Provider.of<AuthenticationViewModel>(context, listen: false)
        .setMode(AuthFormMode.Login);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthenticationViewModel>(
      builder: (context, authViewModel, child) => Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 20.0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width - 48.0,
              child: RaisedButton(
                color: AppColors.firstLevelCTAColor,
                child: authViewModel.getMode == AuthFormMode.Login
                    ? Text(
                        TextStrings.authentication_login_button_value,
                        style: TextStyles.buttons_value,
                      )
                    : Text(
                        TextStrings.authentication_signin_button_value,
                        style: TextStyles.buttons_value,
                      ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                onPressed: () => {
                  if (authViewModel.getMode == AuthFormMode.Login)
                    {
                      if (widget.formKey.currentState.validate())
                        {_handleLogin()}
                    }
                  else
                    {
                      if (widget.formKey.currentState.validate())
                        {_handleSignin()}
                    }
                },
              ),
            ),
          ),
          FullWidthButton(
            color: Colors.grey.shade200,
            value: authViewModel.getMode == AuthFormMode.Login
                ? TextStrings.authentication_close_app_button_value
                : TextStrings.authentication_cancel_button_value,
            onPressed: authViewModel.getMode == AuthFormMode.Login
                ? _handleClose
                : _handleCancel,
          )
        ],
      ),
    );
  }
}
