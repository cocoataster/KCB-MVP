import 'package:sounds_good/core/services/api.dart';
import 'package:sounds_good/core/utils/enums.dart';
import 'base_viewmodel.dart';
import 'package:sounds_good/locator.dart';


class LoginViewModel extends BaseViewModel {
  final Api _api = locator<Api>();

  Future<bool> login(String email, String password) async {
    setState(ViewState.Busy);

    if (email.isEmpty || password.isEmpty) {
      setState(ViewState.Idle);

      return false;
    }

    var success = await _api.login(email, password);

    setState(ViewState.Idle);

    return success;
  }
}
