class SearchRequest {
  String name;
  List<String> instruments;
  double maxDistance;
  int limit;
  int offset;

  SearchRequest(
      {this.name, this.instruments, this.maxDistance, this.limit, this.offset});

  String getName() {
    return name != null ? name : "";
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
}
