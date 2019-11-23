import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sounds_good/core/utils/enums.dart';
import 'package:sounds_good/core/viewmodels/profile_viewmodel.dart';
import 'package:sounds_good/screens/widgets/profile/edit/videos_list.dart';
import 'package:sounds_good/screens/widgets/profile/shared/videos_list.dart';
import 'package:sounds_good/screens/widgets/profile/shared/section_title.dart';

class ProfileVideosSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileViewModel>(builder: (context, model, child) {
      List<String> videos =
          model.getVideos().map<String>((String video) => video).toList();

      return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ProfileSectionTitle(sectionTitle: 'How do I play?'),
            model.getMode == ProfileMode.Edit
                ? EditProfileVideos(videos: videos)
                : ProfileVideos(videos: videos),
          ]);
    });
  }
}
