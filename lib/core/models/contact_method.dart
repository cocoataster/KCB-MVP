class ContactMethod {
  String type;
  String data;

  ContactMethod({this.type, this.data});

  factory ContactMethod.fromJson(Map<String, dynamic> json) {
    return ContactMethod(type: json['type'], data: json['long']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['type'] = this.type;
    data['data'] = this.data;

    return data;
  }
}
