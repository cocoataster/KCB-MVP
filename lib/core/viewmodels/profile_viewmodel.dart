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
  Set<String> videosToRemoveList = {};

  Future fetchProfile() async {
    setState(ViewState.Busy);
    profile = await _api.getProfile();
    setState(ViewState.Idle);
  }

  ProfileMode _profileMode = ProfileMode.Own;
  ProfileMode get getMode => _profileMode;

  void setMode(ProfileMode profileMode) {
    _profileMode = profileMode;
    notifyListeners();
  }

  instrumentsToRemove({instrumentsSelected}) =>
      instrumentsToRemoveList = instrumentsSelected;

  updateInstrumentsList() {
    instrumentsToRemoveList
        .map((String instrument) => profile.instruments.remove(instrument))
        .toList();
  }

  void addInstrument({instrument}) {
    profile.instruments.add(instrument);
    notifyListeners();
  }

  List<String> getVideos() =>
      profile.videos.map((video) => video['thumbnail'].toString()).toList();

  videosToRemove({videosSelected}) {
    videosToRemoveList = videosSelected;
  }

  updateVideosList() {
    videosToRemoveList.map(
      (String thumbnail) {
        profile.videos.map((video) {
          if (video['thumbnail'].contains(thumbnail)) {
            profile.videos.remove(video);
          }
        }).toList();
      },
    ).toList();
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
    notifyListeners();
  }

  updateContactMethod({ContactMethodType type, String data}) {
    profile.contactMethod = ContactMethod(type: type.toString(), data: data);
    notifyListeners();
  }
}
