import 'package:sounds_good/core/models/user.dart';
import 'package:sounds_good/core/services/api.dart';
import 'package:sounds_good/core/utils/enums.dart';
import 'base_viewmodel.dart';

class AuthenticationViewModel extends BaseViewModel {
  final Api _api = Api();
  User user;

  void authInit() {
    user = User.initial();
  } 

  AuthFormMode _authMode = AuthFormMode.Login;

  Future<bool> signin({String email, String password}) async {
    setState(ViewState.Busy);
    var success = await _api.createUser(email: email, password: password);
    setState(ViewState.Idle);
    return success;
  }


  Future<bool> login({String email, String password}) async {
    setState(ViewState.Busy);    
    var success = await _api.login(user.email, user.password);
    setState(ViewState.Idle);
    return success;
  }

  AuthFormMode get getMode => _authMode;

  void setMode(AuthFormMode authMode) {
    _authMode = authMode;
    notifyListeners();
  }

  void updateName(String name) {
    user.name = name;
    notifyListeners();
  }

  void updateEmail(String email) {
    user.email = email;
    notifyListeners();
  }

  void updatePassword(String password) {
    user.password = password;
    notifyListeners();
  }

  String getName() => user.name;
  String getEmail() => user.email;
  String getPassword() => user.password;
}
