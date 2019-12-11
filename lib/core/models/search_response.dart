import 'package:sounds_good/core/models/profile.dart';
import 'package:sounds_good/core/utils/enums.dart';

import 'local.dart';

class SearchResponse {
  final int total;
  final int offset;
  final List<dynamic> items;

  SearchResponse({this.total, this.offset, this.items});

  factory SearchResponse.fromJson(Map<String, dynamic> json, SearchType type) {
    // Creates a list of objects and maps for each profile
    var list = json['items'] as List;
    List<dynamic> items = [];

    switch (type) {
      case SearchType.Members:
        items =
            list.map((jsonProfile) => Profile.fromJson(jsonProfile)).toList();
        break;
      case SearchType.Locals:
        items = list.map((jsonLocal) => Local.fromJson(jsonLocal)).toList();
        break;
    }

    return SearchResponse(
        total: json['total'], offset: json['offset'], items: items);
  }
}
