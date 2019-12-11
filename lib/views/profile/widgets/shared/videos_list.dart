import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileVideos extends StatelessWidget {
  final List<String> thumbnails;
  final List<String> urls;

  ProfileVideos({this.thumbnails, this.urls});

  _launchURL(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
      height: MediaQuery.of(context).size.height * 0.23,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: thumbnails.length,
          itemBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.only(right: 15.0),
              width: MediaQuery.of(context).size.width * 0.50,
              child: InkWell(
                onTap: () => _launchURL(urls[index]),
                child: Image.network(thumbnails[index]),
              ),
            );
          }),
    );
  }
}
