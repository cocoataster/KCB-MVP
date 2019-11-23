import 'package:flutter/material.dart';

class ProfileVideos extends StatelessWidget {
  final List<String> videos;

  ProfileVideos({this.videos});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
      height: MediaQuery.of(context).size.height * 0.23,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: videos.length,
          itemBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.only(right: 15.0),
              width: MediaQuery.of(context).size.width * 0.50,
              child: Image.network(videos[index]),
            );
          }),
    );
  }
}
