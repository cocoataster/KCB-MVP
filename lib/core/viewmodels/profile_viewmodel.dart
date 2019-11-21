

import '../../locator.dart';
import '../models/profile.dart';
import '../services/api.dart';
import 'base_model.dart';


class ProfileViewModel extends BaseViewModel {
  Api _api = locator<Api>();

  Profile profile;
  Set<String> instrumentsToRemoveList = {};

  Future getProfile() async {
    setState(ViewState.Busy);
    await Future.delayed(const Duration(seconds: 5), () {});
    profile = await _api.getProfile();
    setState(ViewState.Idle);
  }

  instrumentsToRemove({instrumentsSelected}) {
    setState(ViewState.Busy);
    instrumentsToRemoveList = instrumentsSelected;
    setState(ViewState.Idle);
  }

  updateInstrumentsList() {
    setState(ViewState.Busy);
    instrumentsToRemoveList
        .map((String instrument) => profile.instruments.remove(instrument))
        .toList();
    print(profile.instruments);
    setState(ViewState.Idle);
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
}
