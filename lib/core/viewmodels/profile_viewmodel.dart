import 'package:sounds_good/core/utils/enums.dart';
import 'package:sounds_good/locator.dart';
import 'package:sounds_good/core/models/profile.dart';
import 'package:sounds_good/core/services/api.dart';
import 'base_viewmodel.dart';


class ProfileViewModel extends BaseViewModel {
  Api _api = locator<Api>();

  Profile profile;
  Set<String> instrumentsToRemoveList = {};

  Future fetchProfile() async {
    setState(ViewState.Busy);
    
    // TODO Remove delay
    //await Future.delayed(const Duration(seconds: 2), () {});
    
    profile = await _api.getProfile();
    setState(ViewState.Idle);
  }

  instrumentsToRemove({instrumentsSelected}) {
    setState(ViewState.Busy);
    instrumentsToRemoveList = instrumentsSelected;
    setState(ViewState.Idle);
  }

  updateInstrumentsList() {
    instrumentsToRemoveList
        .map((String instrument) => profile.instruments.remove(instrument))
        .toList();
    print(profile.instruments);
  }

  updateProfileLocation({friendlyLocation}) {
    profile.friendlyLocation = friendlyLocation;
    print('Location: ' + friendlyLocation);
    notifyListeners();
  }

  updateProfileName({name}) {
    profile.name = name;

    print('Name: ' + name);
    notifyListeners();
  }

  ProfileMode _profileMode = ProfileMode.Own;

  ProfileMode get getMode => _profileMode;

  void setMode(ProfileMode profileMode) {
    _profileMode = profileMode;
    print(_profileMode);
    notifyListeners();
  }
}
