class Instruments {
  List<String> items;

  Instruments({this.items});

  factory Instruments.fromJson(Map<String, dynamic> json) {
    return Instruments(items: json['items']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['items'] = this.items;

    return data;
  }
}
