import 'package:sounds_good/core/services/api.dart';
import 'package:sounds_good/core/utils/enums.dart';
import 'base_viewmodel.dart';

class LoginViewModel extends BaseViewModel {
  final Api _api = Api();

  Future<bool> login(String email, String password) async {
  
    setState(ViewState.Busy);
    var success = await _api.login(email, password);
    setState(ViewState.Idle);

    return success;
  }
}
