import 'profile.dart';

class MyBand {
  final int total;
  final int offset;
  final List<Profile> profiles;

  MyBand({this.total, this.offset, this.profiles});

  factory MyBand.fromJson(Map<String, dynamic> json) {
    var list = json['items'] as List;
    List<Profile> profiles = [];

    profiles = list
        .map((jsonNotification) => Profile.fromJson(jsonNotification))
        .toList();

    return MyBand(
        total: json['total'], offset: json['offset'], profiles: profiles);
  }
}
