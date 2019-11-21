import 'package:flutter/material.dart';
import 'package:sounds_good/screens/widgets/profile/shared/videos.dart';
import 'package:sounds_good/screens/widgets/profile/shared/profile_modes.dart';
import 'package:sounds_good/screens/widgets/profile/shared/section_title.dart';

class ProfileVideosSection extends StatelessWidget {
  final ProfileMode profileMode;

  ProfileVideosSection({this.profileMode});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: _plainWidgetsList(), //Directly to _plainWidgetsList by the moment
    );
  }

// TODO Edit mode for videos
  List<Widget> _modeSwitchHelper() {
    switch (profileMode) {
      default:
        return _plainWidgetsList();
        break;
    }
  }

  List<Widget> _plainWidgetsList() {
    return <Widget>[
      ProfileSectionTitle(sectionTitle: 'How do I play?'),
      ProfileVideos(),
    ];
  }
}
