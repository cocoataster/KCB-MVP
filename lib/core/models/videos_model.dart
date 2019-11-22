class Videos {
  String id;
  String video;
  String embedVideo;
  String thumbnail;

  Videos({this.id, this.video, this.embedVideo, this.thumbnail});

  factory Videos.fromJson(Map<String, dynamic> json) {
    return Videos(id: json['id'], video: json['video'], embedVideo: json['video'] , thumbnail:  json['thumbnail']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['video'] = this.video;
    data['embedVideo'] = this.embedVideo;
    data['thumbnail'] = this.thumbnail;

    return data;
  }
}