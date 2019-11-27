import 'package:sounds_good/core/utils/enums.dart';

class ContactMethod {
  ContactMethodType type;
  String data;

  ContactMethod({this.type, this.data});

  factory ContactMethod.fromJson(Map<String, dynamic> json) {
    ContactMethodType type; 
    json['type'] == 'email' ? type = ContactMethodType.Email : type = ContactMethodType.Phone;

    return ContactMethod(type: type, data: json['data']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['type'] = convertContactMethodType();
    data['data'] = this.data;
    return data;
  }

  String convertContactMethodType() {
    String type;    
    this.type == ContactMethodType.Email ? type = 'email' : type = 'phone';
    return type;
  }
}
