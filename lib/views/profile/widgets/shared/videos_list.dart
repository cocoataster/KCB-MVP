import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

class ProfileVideos extends StatefulWidget {
  final List<dynamic> videos;

  ProfileVideos({this.videos});

  @override
  _ProfileVideosState createState() => _ProfileVideosState();
}

class _ProfileVideosState extends State<ProfileVideos> {
  List<String> videosURLs;

  _launchURL(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<bool> _checkURL(urlToCheck) async {
    final response = await http.head(urlToCheck);

    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }

  Future<List<dynamic>> _checkVideos() async {
    List<dynamic> videos = [];
    await Future.forEach(widget.videos, (item) async {
      if (await _checkURL(item['thumbnail'])) videos.add(item);
    });

    return videos;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
        future: _checkVideos(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            print('Snapshot: ${snapshot.data}');
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
              height: MediaQuery.of(context).size.height * 0.23,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.only(right: 15.0),
                      width: MediaQuery.of(context).size.width * 0.50,
                      child: InkWell(
                        onTap: () => _launchURL(snapshot.data[index]['video']),
                        child: Image.network(snapshot.data[index]['thumbnail']),
                      ),
                    );
                  }),
            );
          } else {
            return new CircularProgressIndicator();
          }
        });
  }
}
