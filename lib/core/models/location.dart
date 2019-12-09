class Location {
  double lat;
  double long;

  Location({this.lat, this.long});

   factory Location.fromJson(Map<String, dynamic> json) {
    
    return Location(lat: json['lat'].toDouble(), long: json['long'].toDouble());
  } 

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['lat'] = this.lat;
    data['long'] = this.long;
    return data;
  }
}