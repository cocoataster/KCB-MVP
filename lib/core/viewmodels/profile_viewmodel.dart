import 'package:sounds_good/core/models/location.dart';
import 'package:sounds_good/core/utils/enums.dart';
import 'package:sounds_good/locator.dart';
import 'package:sounds_good/core/models/profile.dart';
import 'package:sounds_good/core/models/contact_method.dart';
import 'package:sounds_good/core/services/api.dart';
import 'base_viewmodel.dart';

class ProfileViewModel extends BaseViewModel {
  Api _api = locator<Api>();

  Profile profile;
  ContactMethod contactMethod;
  Set<String> instrumentsToRemoveList = {};
  Set<String> videosToRemoveList = {};
  Map<String, dynamic> updatedProfile = Map<String, dynamic>();


  Future fetchProfile() async {
    setState(ViewState.Busy);
    profile = await _api.getProfile();
    setState(ViewState.Idle);
  }

  updateProfile() async{
    setState(ViewState.Busy);
    await _api.updateProfile(profile);  
    setState(ViewState.Idle);   
  }

  ProfileMode _profileMode = ProfileMode.Own;
  ProfileMode get getMode => _profileMode;

  void setMode(ProfileMode profileMode) {
    _profileMode = profileMode;
    notifyListeners();
  }

  void updateProfileField({String key, dynamic value}){
    updatedProfile[key] = value;
  }

  instrumentsToRemove({instrumentsSelected}) =>
      instrumentsToRemoveList = instrumentsSelected;

  updateInstrumentsList() {
    instrumentsToRemoveList
        .map((String instrument) => profile.instruments.remove(instrument))
        .toList();
        updateProfileField(key: 'instruments', value: profile.instruments);
  }

  void addInstrument({instrument}) {
    profile.instruments.add(instrument);
    notifyListeners();
  }

  List<String> getVideos() { 
    var thumbnailsList = profile.videos.map<String>((video) => video['thumbnail']).toList();
    return thumbnailsList;   
    }

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
    updateProfileField(key: 'videos', value: profile.videos);
  }

 addNewVideo(videoURL) {
    String videoId = videoURL.split('?v=')[1];  
    Map<String, dynamic> videoURLtoJson() {
      final data = Map<String, dynamic>();
          data['id'] = videoId;
          data['video'] = videoURL;
          data['embedVideo'] = 'https://www.youtube.com/embed/$videoId?ecver=1&amp;iv_load_policy=1&amp;yt:stretch=16:9&amp;autohide=1&amp;color=red&amp;';
          data['thumbnail'] = 'https://img.youtube.com/vi/$videoId/hqdefault.jpg';
        return data;
    }

  var newVideoItem = videoURLtoJson();
  profile.videos.add(newVideoItem);
  }

  updateProfileLocation({friendlyLocation}) {
    profile.friendlyLocation = friendlyLocation;
    updateProfileField(key: 'fiendlyLocation', value: profile.friendlyLocation);
    notifyListeners();
  }

  updateProfileName({name}) {
    profile.name = name;
    updateProfileField(key: 'name', value: profile.name);
    notifyListeners();
  }

  updateDescription({description}) {
    profile.description = description;
    updateProfileField(key: 'description', value: profile.description);
    notifyListeners();
  }
  
  ContactMethodType getContactMethodType() => profile.contactMethod.type;
  String getContactMethodData() => profile.contactMethod.data;
  updateContactMethodType(ContactMethodType type) => profile.contactMethod.type = type;
  updateContactMethodData(String data) => profile.contactMethod.data = data;

  updateLocation({double lat, double long}) {
      profile.location = Location(lat: lat, long: long);
  }
}
