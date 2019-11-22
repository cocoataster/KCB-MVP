import 'package:sounds_good/core/models/videos_model.dart';
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

  Videos videos;
  
  var videosArray = [
    {
      "id": "41DH065Lfeo",
      "video": "https://www.youtube.com/watch?v=41DH065Lfeo",
      "embedVideo":
          "https://www.youtube.com/embed/41DH065Lfeo?ecver=1&amp;iv_load_policy=1&amp;yt:stretch=16:9&amp;autohide=1&amp;color=red&amp;",
      "thumbnail": "https://img.youtube.com/vi/41DH065Lfeo/hqdefault.jpg"
    },
    {
      "id": "41DH065Lfeo",
      "video": "https://www.youtube.com/watch?v=41DH065Lfeo",
      "embedVideo":
          "https://www.youtube.com/embed/41DH065Lfeo?ecver=1&amp;iv_load_policy=1&amp;yt:stretch=16:9&amp;autohide=1&amp;color=red&amp;",
      "thumbnail": "https://img.youtube.com/vi/41DH065Lfeo/hqdefault.jpg"
    },
    {
      "id": "41DH065Lfeo",
      "video": "https://www.youtube.com/watch?v=41DH065Lfeo",
      "embedVideo":
          "https://www.youtube.com/embed/41DH065Lfeo?ecver=1&amp;iv_load_policy=1&amp;yt:stretch=16:9&amp;autohide=1&amp;color=red&amp;",
      "thumbnail": "https://img.youtube.com/vi/41DH065Lfeo/hqdefault.jpg"
    },
  ];

}