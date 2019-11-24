import 'package:sounds_good/core/models/profile.dart';

class SearchResponse {
  final int total;
  final int offset;
  final List<Profile> items;

  SearchResponse({this.total, this.offset, this.items});

  factory SearchResponse.fromJson(Map<String, dynamic> json) {
    // Creates a list of objects and maps for each profile
    var list = json['items'] as List;
    List<Profile> profiles =
        list.map((jsonProfile) => Profile.fromJson(jsonProfile)).toList();

    return SearchResponse(
        total: json['total'], offset: json['offset'], items: profiles);
  }
}
