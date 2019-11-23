import 'package:flutter/material.dart';

class ProfileVideos extends StatelessWidget {

    final List<String> videos;
    //final List<int> numbers = [1,2,3,4];

    ProfileVideos({this.videos});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
      height: MediaQuery.of(context).size.height * 0.20,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: videos.length,
          itemBuilder: (context, index) {
            return Container(
              width: MediaQuery.of(context).size.width * 0.45,
              child: Card(
                child: Container(
                  child: Center(
                      child: Image.network(videos[index]),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
