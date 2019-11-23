import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sounds_good/core/utils/enums.dart';
import 'package:sounds_good/core/viewmodels/profile_viewmodel.dart';
import 'package:sounds_good/screens/widgets/profile/shared/videos.dart';
import 'package:sounds_good/screens/widgets/profile/shared/section_title.dart';

class ProfileVideosSection extends StatelessWidget {
  final ProfileMode profileMode;

  ProfileVideosSection({this.profileMode});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileViewModel>(
      builder: (context, model, child) => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children:
            _plainWidgetsList(model), //Directly to _plainWidgetsList by the moment
      ),
    );
  }

  List<Widget> _plainWidgetsList(model) {
    //model.getVideos().map((video) => video).toList()
    List<String> videosList = model.getVideos().map<String>((String video) => video).toList();
    return <Widget>[
      ProfileSectionTitle(sectionTitle: 'How do I play?'),
      ProfileVideos(videos: videosList),
   
    ];
  }
}
