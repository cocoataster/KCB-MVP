import 'package:sounds_good/core/models/contact_method.dart';
import 'package:sounds_good/core/models/location.dart';
import 'package:sounds_good/core/utils/enums.dart';

class Local {
  final String id;
  String name;
  Location location;
  double price;
  ContactMethod contactMethod;
  List<String> photos;
  String description;

  Local(
      {this.id,
      this.name,
      this.location,
      this.price,
      this.contactMethod,
      this.photos,
      this.description});

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
      photosList = List<String>.from(photos);
    } else {
      photosList = [];
    }

    return Local(
      id: json['cuid'],
      name: json['name'] != null ? json['name'] : '',
      location: location,
      price: json['price'] != null ? json['price'] : 0.0,
      contactMethod: contactMethod,
      photos: photosList,
      description: json['description'] != null ? json['description'] : '',
    );
  }

  Map<String, dynamic> toJson() {
    final data = Map<String, dynamic>();

    data['name'] = this.name;
    data['location'] = this.location.toJson();
    data['price'] = this.price;
    data['contact'] = this.contactMethod.toJson();
    data['photos'] = this.photos;
    data['description'] = this.description;

    return data;
  }
}
