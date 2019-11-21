import 'package:sounds_good/core/viewmodels/profile_viewmodel.dart';
import 'package:sounds_good/screens/widgets/profile/shared/profile_modes.dart';

class ProfileModeViewModel extends ProfileViewModel {
  ProfileMode _profileMode = ProfileMode.own;

  ProfileMode get getMode => _profileMode;

  void setMode(ProfileMode profileMode) {
    _profileMode = profileMode;
    print(_profileMode);
    notifyListeners();
  }
}
