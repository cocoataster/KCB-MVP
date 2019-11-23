import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sounds_good/core/viewmodels/profile_viewmodel.dart';
import 'package:sounds_good/screens/widgets/profile/edit/add_video.dart';
import 'package:sounds_good/screens/widgets/profile/edit/video_item.dart';

class EditProfileVideos extends StatefulWidget {
  final List<String> videos;

  EditProfileVideos({this.videos});

  @override
  _EditProfileVideosState createState() => _EditProfileVideosState();
}

class _EditProfileVideosState extends State<EditProfileVideos> {
  Set<String> _videosSelected = Set<String>();

  void _handleVideoChanged(String instrument, bool isSelected) {
    setState(() {
      isSelected
          ? _videosSelected.remove(instrument)
          : _videosSelected.add(instrument);
    });
    Provider.of<ProfileViewModel>(context, listen: false)
        .videosToRemove(videosSelected: _videosSelected);
  }

  void _addVideo(newVideo) {
    //Provider.of<ProfileViewModel>(context, listen: false).addInstrument(instrument: newInstrument);
  }

  @override
  Widget build(BuildContext context) {
    List<VideoItem> videoItems = widget.videos.map((videoItem) {
          var index = widget.videos.indexOf(videoItem);
          return VideoItem(
              video: widget.videos[index],
              isSelected: _videosSelected.contains(widget.videos[index]),
              onListChanged: _handleVideoChanged);
        })
        .toList();
      List<Widget> items = [AddVideo()];
      items.addAll(videoItems);

    return Container(
      height: MediaQuery.of(context).size.height * 0.23,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: items.length,
          itemBuilder: (context, index) {
            return Container(
                margin: EdgeInsets.only(right: 15.0),
                width: MediaQuery.of(context).size.width * 0.50,
                child: items[index]);
          }),
    );
  }
}
