class SearchRequest {
  String name;
  List<String> instruments;
  double maxDistance;

  SearchRequest({this.name, this.instruments, this.maxDistance});

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
}
