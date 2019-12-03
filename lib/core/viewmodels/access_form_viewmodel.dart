import 'package:sounds_good/core/services/api.dart';
import 'package:sounds_good/core/utils/enums.dart';
import 'base_viewmodel.dart';
import 'package:sounds_good/locator.dart';

class AccessFormViewModel extends BaseViewModel {
  final Api _api = locator<Api>();

  Future<bool> signin(String email, String password) async {
    setState(ViewState.Busy);
    var success = await _api.createUser(email: email, password: password);
    setState(ViewState.Idle);
    return success;
  }

   Future<bool> login(String email, String password) async {
    setState(ViewState.Busy);
    var success = await _api.login(email, password);
    setState(ViewState.Idle);
    return success;
  }

  void updateUserName(name) {

  }
}
