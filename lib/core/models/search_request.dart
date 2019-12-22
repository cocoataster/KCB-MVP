import 'package:sounds_good/core/services/locator.dart';

class SearchRequest {
  String name;
  double price;
  List<String> instruments;
  List<dynamic> followers;
  double maxDistance;
  int limit;
  int offset;
  int total;
  double lat;
  double lon;

  SearchRequest(
      {this.name,
      this.price,
      this.instruments,
      this.maxDistance,
      this.limit,
      this.offset,
      this.total,
      this.followers,
      this.lat,
      this.lon});

  String getName() {
    return name != null ? name : "";
  }

  String getPrice() {
    return price != null ? price.toString() : "";
  }

  String getInstrumentsString() {
    var instrumentsString = "";
    bool isFirstInstrument = true;

    for (var instrument in instruments) {
      instrumentsString += isFirstInstrument ? instrument : "," + instrument;
      isFirstInstrument = false;
    }

    return instrumentsString;
  }

  String getLat() {
    double lat = Locator.getLatitude();
    return lat != null ? lat.toStringAsFixed(2) : "";
  }

  String getLon() {
    double lon = Locator.getLongitude();
    return lon != null ? lon.toStringAsFixed(2) : "";
  }

  String getMaxDistance() {
    return maxDistance != null ? maxDistance.toStringAsFixed(0) : "";
  }

  int getLimit() {
    return limit != null ? limit : 2;
  }

  int getOffset() {
    return offset != null ? offset : 0;
  }

  List<dynamic> getFollowers() {
    return this.followers;
  }

  bool hasMorePages() {
    return offset < total;
  }
}
