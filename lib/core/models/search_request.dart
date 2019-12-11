class SearchRequest {
  String name;
  double price;
  List<String> instruments;
  List<dynamic> followers;
  double maxDistance;
  int limit;
  int offset;

  SearchRequest(
      {this.name,
      this.price,
      this.instruments,
      this.maxDistance,
      this.limit,
      this.offset,
      this.followers});

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
}
