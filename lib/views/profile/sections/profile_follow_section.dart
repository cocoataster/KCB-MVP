import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sounds_good/core/services/api.dart';
import 'package:sounds_good/core/services/storage.dart';
import 'package:sounds_good/core/utils/colors.dart';
import 'package:sounds_good/core/viewmodels/profile_viewmodel.dart';
import 'package:sounds_good/views/shared_resources/full_width_button.dart';

class FollowMembersSection extends StatefulWidget {
  final String memberId;

  FollowMembersSection({this.memberId});

  @override
  _FollowMembersSectionState createState() => _FollowMembersSectionState();
}

class _FollowMembersSectionState extends State<FollowMembersSection> {
  List<String> followers = [];
  List<String> invitations = [];

  @override
  void initState() {
    super.initState();
  }

  Future _getFollowersAndInvitations() async {
    var invitationsOwnProfile = await Storage.getInvitations();
    var followersOwnProfile = await Storage.getFollowers();
    jsonDecode(invitationsOwnProfile)
        .map((invitation) => invitations.add(invitation))
        .toList();
    jsonDecode(followersOwnProfile)
        .map((follower) => followers.add(follower))
        .toList();
  }

  _follow(){
     Api().followMember(widget.memberId);
     Provider.of<ProfileViewModel>(context, listen: false).getMyFollowers();
     Navigator.pop(context); 
  }
  @override
  Widget build(BuildContext context) {
    String _value;
    VoidCallback _action;
    Color _color;

    return FutureBuilder(
      future: _getFollowersAndInvitations(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (followers.contains(widget.memberId)) {
            _value = 'Unfollow';
            _action = () => Api().unfollowMember(widget.memberId);
            _color = AppColors.secondLevelCTAColor;
          } else if (invitations.contains(widget.memberId)) {
            _value = 'Pending';
            _action = () => {};
            _color = AppColors.secondLevelCTAColor;
          } else {
            _value = 'Follow';
            _action = () => _follow();
            _color = AppColors.firstLevelCTAColor;
          }
          return Padding(
            padding: EdgeInsets.fromLTRB(14, 16, 14, 0),
            child: FullWidthButton(
              value: _value,
              color: _color,
              onPressed: _action,
            ),
          );
        } else {
          return new CircularProgressIndicator();
        }
      },
    );
  }
}
