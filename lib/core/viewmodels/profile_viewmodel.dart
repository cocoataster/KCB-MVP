import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sounds_good/core/models/instruments.dart';
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
  ProfileMode _profileMode = ProfileMode.Own;
  ContactMethod contactMethod;
  Set<String> instrumentsToRemoveList = {};
  Set<String> videosToRemoveList = {};
  ImageProvider<dynamic> profileAvatar;
  File profileAvatarToUpdate;
  Instruments availableInstruments;
  Set<String> disabledAvailableInstruments = {};

  Future fetchProfile() async {
    setState(ViewState.Busy);
    profile = await _api.getProfile();
    setState(ViewState.Idle);
    profileAvatar = NetworkImage('${Api.endpoint}/${profile.photo}');
  }

  updateProfile() async {
    setState(ViewState.Busy);
    await _api.updateProfile(profile);
    setState(ViewState.Idle);
  }
  
  ProfileMode get getMode => _profileMode;

  void setMode(ProfileMode profileMode) {
    _profileMode = profileMode;
    notifyListeners();
  }

  ImageProvider<dynamic> getAvatar() => profileAvatar;

  avatarToUpdate({File imageFile}) {
    profileAvatarToUpdate = imageFile;
  }

  updateAvatar() {
    if (profileAvatarToUpdate != null) {
      profileAvatar = FileImage(profileAvatarToUpdate);
      notifyListeners();
      _api.updateAvatar(profileAvatarToUpdate.path);
    }
  }

  instrumentsToRemove({instrumentsSelected}) {
    instrumentsToRemoveList = instrumentsSelected;
  }

  updateInstrumentsList() {
    instrumentsToRemoveList.map((String instrument) {
      profile.instruments.remove(instrument);
      enableAvailableInstrument(instrument);
    }).toList();
    notifyListeners();
  }

  void addInstrument({instrument}) {
    profile.instruments.add(instrument);
    disableAvailableInstrument(instrument);
    notifyListeners();
    print('Add instrument: $instrument');
  }

  Future fetchAvailableInstruments() async {
    setState(ViewState.Busy);
    availableInstruments = await _api.getInstruments();
    setState(ViewState.Idle);

    profile.instruments
        .map((instrument) => disableAvailableInstrument(instrument))
        .toList();
  }

  List<String> getAvailableInstruments() {
    List<String> finalList = [];

    availableInstruments.items.map((instrument) {
      if (!disabledAvailableInstruments.contains(instrument)) {
        finalList.add(instrument);
      }
    }).toList();

    return finalList;
  }

  enableAvailableInstrument(instrument) =>
      disabledAvailableInstruments.remove(instrument);

  disableAvailableInstrument(instrument) =>
      disabledAvailableInstruments.add(instrument);

  List<dynamic> getVideos() {
    var thumbnailsList = profile.videos.map((video) => video).toList();
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
  }

  addNewVideo(videoURL) {
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

  ContactMethodType getContactMethodType() => profile.contactMethod.type;
  String getContactMethodData() => profile.contactMethod.data;
  updateContactMethodType(ContactMethodType type) =>
      profile.contactMethod.type = type;
  updateContactMethodData(String data) => profile.contactMethod.data = data;

  updateLocation({double lat, double long}) {
    profile.location = Location(lat: lat, long: long);
  }
}
