import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sounds_good/core/models/instruments.dart';
import 'package:sounds_good/core/models/location.dart';
import 'package:sounds_good/core/models/my_band.dart';
import 'package:sounds_good/core/services/storage.dart';
import 'package:sounds_good/core/utils/enums.dart';
import 'package:sounds_good/core/models/profile.dart';
import 'package:sounds_good/core/models/contact_method.dart';
import 'package:sounds_good/core/services/api.dart';
import 'base_viewmodel.dart';

class ProfileViewModel extends BaseViewModel {
  Api _api = Api();
  Profile profile;
  ProfileMode _profileMode = ProfileMode.Own;
  ContactMethod contactMethod;
  Set<String> instrumentsToRemoveList = {};
  Set<String> videosToRemoveList = {};
  ImageProvider<dynamic> profileAvatar;
  File profileAvatarToUpdate;
  Instruments availableInstruments;
  List<String> instrumentsToDisableFromPicker = [];
  

  /*
  *   Profile Data
  */

  Future fetchProfile() async {
    setState(ViewState.Busy);
    profile = await _api.getProfile();
    setState(ViewState.Idle);
  }
  
  Future fetchMemberProfile(String id) async {
    setState(ViewState.Busy);
    profile = await _api.getProfileWithId(id);
    setState(ViewState.Idle);
  }

  Future updateProfile() async {
    await _api.updateProfile(profile);
  }

    
  /*
  *   Profile Mode
  *   Own | Edit | User
  */

  
  ProfileMode get getMode {
    return _profileMode;
  }

  void setMode(ProfileMode profileMode) {
    _profileMode = profileMode;
    notifyListeners();
  }

   /*
  *   Avatar
  */

  ImageProvider<dynamic> getAvatar() => profileAvatar;

  void initializeAvatar() {
    if(profile.photo.isNotEmpty){
      profileAvatar = NetworkImage('${Api.endpoint}/${profile.photo}?v=${DateTime.now().millisecondsSinceEpoch}');
    } else {
      if(_profileMode != ProfileMode.Member){
        setMode(ProfileMode.Edit);
      }
    }
  }

  void avatarToUpdate({File imageFile}) {
    profileAvatarToUpdate = imageFile;
  }

  void updateAvatar() {
    if (profileAvatarToUpdate != null) {
      profileAvatar = FileImage(profileAvatarToUpdate);
      notifyListeners();
      _api.updateAvatar(profileAvatarToUpdate.path);
    }
  }

  /*
  *   Instruments
  */

  /* Edit Instruments */

  List<String> getInstrumentsOnProfile() => profile.instruments;

  void addInstrument({instrument}) {
    profile.instruments.add(instrument);
    notifyListeners();
  }

  void instrumentsToRemove({instrumentsSelected}) {
    instrumentsToRemoveList = instrumentsSelected;
  }

  void updateInstrumentsList() {
    instrumentsToRemoveList.map((String instrument) {
      profile.instruments.remove(instrument);
    }).toList();
    notifyListeners();
  }

  // For avoid duplicates on Instruments Picker
  void disableInstrumentsFromProfile() =>
      profile.instruments
          .map((instrument) => disableAvailableInstrument(instrument))
          .toList();

  void enableAvailableInstrument(instrument) =>
      instrumentsToDisableFromPicker.remove(instrument);

  void disableAvailableInstrument(instrument) =>
      instrumentsToDisableFromPicker.add(instrument);

  List<String> getInstrumentsToDisableFromPicker() => instrumentsToDisableFromPicker; 
     
    

  /*
  *   Videos
  */

  List<dynamic> getVideos() {
    var thumbnailsList = profile.videos.map((video) => video).toList();
    return thumbnailsList;
  }

  void videosToRemove({videosSelected}) {
    videosToRemoveList = videosSelected;
  }

  void updateVideosList() {
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

  void addNewVideo(videoURL) {
    String videoId = videoURL.split('?v=')[1];
    Map<String, dynamic> videoURLtoJson() {
      final data = Map<String, dynamic>();
      data['id'] = videoId;
      data['video'] = videoURL;
      data['embedVideo'] =
          'https://www.youtube.com/embed/$videoId?ecver=1&amp;iv_load_policy=1&amp;yt:stretch=16:9&amp;autohide=1&amp;color=red&amp;';
      data['thumbnail'] = 'https://img.youtube.com/vi/$videoId/hqdefault.jpg';
      return data;
    }

    var newVideoItem = videoURLtoJson();
    profile.videos.add(newVideoItem);
  }

  /*
  *   Update Profile Data TextFields
  */

  void updateProfileName({name}) {
    profile.name = name;
    print(name);
    notifyListeners();
  }

  void updateProfileLocation({friendlyLocation}) {
    profile.friendlyLocation = friendlyLocation;
    print(friendlyLocation);
    notifyListeners();
  }

  void updateDescription({description}) {
    profile.description = description;
    notifyListeners();
  }

  /*
  *   ContactMethod
  */

  ContactMethodType getContactMethodType() => profile.contactMethod.type;

  String getContactMethodData() => profile.contactMethod.data;

  void updateContactMethodType(ContactMethodType type) =>
      profile.contactMethod.type = type;

  void updateContactMethodData(String data) =>
      profile.contactMethod.data = data;

  /*
  *   GeoLocation
  */

  void updateLocation({double lat, double long}) {
    profile.location = Location(lat: lat, long: long);
  }

  /*
  * Update Followers List on Storage
  */

  getMyFollowers() async {
    MyBand allTheBand = await _api.getMyBand(0, 0);
    List<String> followers = List<String>();

    allTheBand.profiles
        .map((element) => followers.add('${element.id}'))
        .toList();

    var ownProfileEncodedFollowers = jsonEncode(followers);

    Storage.saveFollowers(ownProfileEncodedFollowers);
  }
}
