import 'package:sounds_good/core/models/contact_method.dart';
import 'package:sounds_good/core/models/location.dart';



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

  Profile(
      {this.id,
      this.name,
      this.location,
      this.contactMethod,
      this.instruments,
      this.friendlyLocation,
      this.videos,
      this.description,
      this.photo});

  factory Profile.fromJson(Map<String, dynamic> json) {
    
    List<String> instrumentsList = List<String>();

    if (json['instruments'] != []) {
      var instruments = json['instruments'];
      instrumentsList = List<String>.from(instruments);
    } else {
      instrumentsList = null;
    }

    // Location and Contact Method can be null

    Location location =
        json['location'] != null ? Location.fromJson(json['location']) : null;

    ContactMethod contactMethod = json['contact'] != null
        ? ContactMethod.fromJson(json['contact'])
        : null;

    var videos = json['videos'];
    List<dynamic> videosList = List<dynamic>.from(videos);
     if (json['videos'] != []) {
      var videos = json['videos'];
      videosList = List<dynamic>.from(videos);
    } else {
      videosList = null;
    }

    return Profile(
        id: json['cuid'],
        name: json['name'],
        location: location,
        contactMethod: contactMethod,
        instruments: instrumentsList,
        friendlyLocation: json['friendlyLocation'],
        videos: videosList,
        description: json['description'],
        photo: json['photo']);
  }

  Map<String, dynamic> toJson() {
    final data = Map<String, dynamic>();
    
    data['name'] = this.name;
    data['location'] = this.location.toJson();
    data['contact'] = this.contactMethod.toJson();
    data['instruments'] = this.instruments;
    data['friendlyLocation'] = this.friendlyLocation;
    data['videos'] = this.videos.map<String>((video) => video['id'].toString()).toList();
    data['description'] = this.description;
    
    return data;
  }
  
  }