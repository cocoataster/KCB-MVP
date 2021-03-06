import 'package:sounds_good/core/models/contact_method.dart';
import 'package:sounds_good/core/models/location.dart';
import 'package:sounds_good/core/utils/enums.dart';

class Profile {
  final String id;
  String name;
  Location location;
  ContactMethod contactMethod;
  List<String> instruments;
  String friendlyLocation;
  List<dynamic> videos;
  String description;
  String photo;
  List<String> followers;
  List<String> invitations;

  Profile(
      {this.id,
      this.name,
      this.location,
      this.contactMethod,
      this.instruments,
      this.friendlyLocation,
      this.videos,
      this.description,
      this.photo,
      this.followers,
      this.invitations });

  factory Profile.fromJson(Map<String, dynamic> json) {
    List<String> instrumentsList = List<String>();
    if (json['instruments'] != []) {
      var instruments = json['instruments'];
      instrumentsList = List<String>.from(instruments);
    } else {
      instrumentsList = [];
    }

    List<String> followersList = List<String>();
    if (json['followers'] != []) {
      var followers = json['followers'];
      followersList = List<String>.from(followers);
    } else {
      followersList = [];
    }

    List<String> invitationsList = List<String>();
    if (json['invitations'] != []) {
      var invitations = json['invitations'];
      invitationsList = List<String>.from(invitations);
    } else {
      invitationsList = [];
    }

    // Location and Contact Method can be null
    // Not sure about that... just in case..
    Location voidLocation = Location(lat: 0.0, long: 0.0);
    Location location = json['location'] != null
        ? Location.fromJson(json['location'])
        : voidLocation;

    ContactMethod voidContactMethod =
        ContactMethod(type: ContactMethodType.Email, data: '');
    ContactMethod contactMethod = json['contact'] != null
        ? ContactMethod.fromJson(json['contact'])
        : voidContactMethod;

    var videos = json['videos'];
    List<dynamic> videosList = List<dynamic>.from(videos);
    if (json['videos'] != []) {
      var videos = json['videos'];
      videosList = List<dynamic>.from(videos);
    } else {
      videosList = [];
    }

    return Profile(
        id: json['cuid'],
        name: json['name'] != null ? json['name'] : '',
        location: location,
        contactMethod: contactMethod,
        instruments: instrumentsList,
        friendlyLocation:
            json['friendlyLocation'] != null ? json['friendlyLocation'] : '',
        videos: videosList,
        description: json['description'] != null ? json['description'] : '',
        photo: json['photo'] != null ? json['photo'] : '',
        followers: followersList,
        invitations: invitationsList);
  }

  Map<String, dynamic> toJson() {
    final data = Map<String, dynamic>();

    data['name'] = this.name;
    data['location'] = this.location.toJson();
    data['contact'] = this.contactMethod.toJson();
    data['instruments'] = this.instruments;
    data['friendlyLocation'] = this.friendlyLocation;
    data['videos'] =
        this.videos.map<String>((video) => video['id'].toString()).toList();
    data['description'] = this.description;
    data['followers'] = this.followers;
    data['invitations'] = this.invitations;

    return data;
  }
}
