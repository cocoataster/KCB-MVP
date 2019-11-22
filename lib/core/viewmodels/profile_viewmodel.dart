import 'package:sounds_good/core/utils/enums.dart';
import 'package:sounds_good/locator.dart';
import 'package:sounds_good/core/models/profile.dart';
import 'package:sounds_good/core/models/contact_method.dart';
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

  void addInstrument({instrument}) {
    profile.instruments.add(instrument);
    print(instrument);
    notifyListeners();
  }

  ProfileMode _profileMode = ProfileMode.Own;

  ProfileMode get getMode => _profileMode;

  void setMode(ProfileMode profileMode) {
    _profileMode = profileMode;
    print(_profileMode);
    notifyListeners();
  }

  // TODO Meter todos los métodos en un único Map

  updateProfileLocation({friendlyLocation}) {
    profile.friendlyLocation = friendlyLocation;
    notifyListeners();
  }

  updateProfileName({name}) {
    profile.name = name;
    notifyListeners();
  }

  updateDescription({description}) {
    profile.description = description;
    print(description);
    notifyListeners();
  }

  updateContactMethod({ContactMethodType type, String data}) {
    profile.contactMethod = ContactMethod(type: type.toString(), data: data);
    print(profile.contactMethod);
    notifyListeners();
  }
}
