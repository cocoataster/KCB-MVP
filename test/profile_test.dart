import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sounds_good/core/models/location.dart';
import 'package:sounds_good/core/models/profile.dart';
import 'package:sounds_good/core/viewmodels/profile_viewmodel.dart';
import 'dart:async';
import 'package:path_provider/path_provider.dart';

import 'package:flutter/services.dart' show rootBundle;



Future<Profile> getProfile() async {
  final file = File('test/test-resources/profile.json');
  final json = jsonDecode(await file.readAsString());

  return Profile.fromJson(json);
}


void main() {
 
  group('Profile ViewModel', () {
    ProfileViewModel viewModel;

    setUpAll(() async {
      viewModel = ProfileViewModel();
      viewModel.profile = await getProfile();
    });

    test('Name should be updated', () {
      final name = 'Eric';
      viewModel.updateProfileName(name: name);

      expect(viewModel.profile.name, name);
    });

    test('Friendly location should be updated', () {
      final friendlyLocation = 'London';
      viewModel.updateProfileLocation(friendlyLocation: friendlyLocation);

      expect(viewModel.profile.friendlyLocation, friendlyLocation);
    });

    test('Location should be updated', () {
      final location = Location(lat: 12.0, long: 15.0);
      viewModel.updateLocation(lat: location.lat, long: location.long);

      expect(viewModel.profile.location.lat, location.lat);
      expect(viewModel.profile.location.long, location.long);
    });

    test('Description should be updated', () {
      final description = 'El más molón de Londres';
      viewModel.updateDescription(description: description);

      expect(viewModel.profile.description, description);
    });

  });
}
