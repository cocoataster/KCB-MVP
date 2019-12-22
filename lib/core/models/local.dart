import 'package:sounds_good/core/models/contact_method.dart';
import 'package:sounds_good/core/models/location.dart';
import 'package:sounds_good/core/utils/enums.dart';

class Local {
  final String id;
  String name;
  String friendlyLocation;
  Location location;
  double price;
  ContactMethod contactMethod;
  List<String> photos;
  String description;
  String shortDescription;

  Local(
      {this.id,
      this.friendlyLocation,
      this.name,
      this.location,
      this.price,
      this.contactMethod,
      this.photos,
      this.description,
      this.shortDescription});

  factory Local.fromJson(Map<String, dynamic> json) {
    // Location and Contact Method can be null
    Location voidLocation = Location(lat: 0.0, long: 0.0);
    Location location = json['location'] != null
        ? Location.fromJson(json['location'])
        : voidLocation;

    ContactMethod voidContactMethod =
        ContactMethod(type: ContactMethodType.Email, data: '');
    ContactMethod contactMethod = json['contact'] != null
        ? ContactMethod.fromJson(json['contact'])
        : voidContactMethod;

    // Photos
    List<String> photosList = List<String>();
    if (json['photos'] != []) {
      var photos = json['photos'];
      if (photos != []) {
        photosList = List<String>.from(photos);
        if (photosList.length == 0) {
          photosList = [""];
        }
      } else {
        photos = [""];
      }
    } else {
      photosList = [""];
    }

    double price = json['price'] != null ? json['price'] * 1.0 : 0.0;

    return Local(
      id: json['cuid'],
      name: json['name'] != null ? json['name'] : '',
      friendlyLocation:
          json['friendlyLocation'] != null ? json['fiendlyLocation'] : '',
      location: location,
      price: price,
      contactMethod: contactMethod,
      photos: photosList,
      description: json['description'] != null ? json['description'] : '',
      shortDescription: json['shortDescription'] != null ? json['shortDescription'] : '',
    );
  }

  Map<String, dynamic> toJson() {
    final data = Map<String, dynamic>();

    data['name'] = this.name;
    data['location'] = this.location.toJson();
    data['price'] = this.price;
    data['friendlyLocation'] = this.friendlyLocation;
    data['contact'] = this.contactMethod.toJson();
    data['photos'] = this.photos;
    data['description'] = this.description;
    data['shortDescription'] = this.shortDescription;
    

    return data;
  }
}
