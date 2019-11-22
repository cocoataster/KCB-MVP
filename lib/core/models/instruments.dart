class Instruments {
  List<String> items;

  Instruments({this.items});

  factory Instruments.fromJson(Map<String, dynamic> json) {
    List<String> instrumentsList = List<String>();

    if (json['items'] != []) {
      var items = json['items'];
      instrumentsList = List<String>.from(items);
    } else {
      instrumentsList = null;
    }

    return Instruments(items: instrumentsList);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['items'] = this.items;

    return data;
  }
}
