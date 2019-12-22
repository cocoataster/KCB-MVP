import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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

  _follow(memberId) {
    print(memberId);
  }

  _unfollow(memberId) {
    print(memberId);
  }

  @override
  void initState() {
    super.initState();
    _getFollowersAndInvitations();
  }

  _getFollowersAndInvitations() async {
    var invitationsOwnProfile = await Storage.getInvitations();
    var followersOwnProfile = await Storage.getFollowers();
    jsonDecode(invitationsOwnProfile).map((invitation) => invitations.add(invitation)).toList();
    jsonDecode(followersOwnProfile).map((follower) => followers.add(follower)).toList();
  }

  @override
  Widget build(BuildContext context) {
    String _value;
    VoidCallback _action;
    var viewModel = Provider.of<ProfileViewModel>(context, listen: false);
    List<String> followers = viewModel.profile.followers;
    List<String> invitations = viewModel.profile.invitations;

    if (followers.contains(widget.memberId)) {
      _value = 'Unfollow';
      _action = _unfollow(widget.memberId);
    } else if (invitations.contains(widget.memberId)) {
      _value = 'Pending';
      _action = () => {print('Pending')};
    } else {
      _value = 'Follow';
      _action = _follow(widget.memberId);
    }
    return FullWidthButton(
      value: _value,
      color: AppColors.firstLevelCTAColor,
      onPressed: _action,
    );
  }
}
