import 'package:flutter/material.dart';

typedef void VideoListCallback(String video, bool isSelected);

class VideoItem extends StatelessWidget {
  final String video;
  final bool isSelected;
  final VideoListCallback onListChanged;

  const VideoItem({Key key, this.video, this.isSelected, this.onListChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onListChanged(video, isSelected);
      },
      child: Stack(
        children: <Widget>[
          _video(video, context),
          Positioned(
            top: 0.0,
            right: 0.0,
            child: _iconButton(context),
          ),
        ],
      ),
    );
  }

  _video(String video, BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 4.0, top: 8.0),
      child: Opacity(
        opacity: isSelected ? 0.3 : 1.0,
        child: Image.network(video),
      ),
    );
  }

  Container _iconButton(context) {
    return Container(
      width: 22.0,
      height: 22.0,
      child: FloatingActionButton(
          backgroundColor: Colors.red,
          elevation: 3,
          shape: CircleBorder(),
          child: _icon(context),
          onPressed: () => {}),
    );
  }

  Icon _icon(BuildContext context) {
    var _iconImage = isSelected ? Icons.check : Icons.close;
    return Icon(
      _iconImage,
      color: Colors.white,
      size: 14.0,
    );
  }

  Icon _playIcon(context) => Icon(Icons.play_arrow, color: Colors.white);
}
