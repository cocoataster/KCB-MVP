import 'package:flutter/material.dart';
import 'package:flutter_pagewise/flutter_pagewise.dart';
import 'package:provider/provider.dart';
import 'package:sounds_good/core/services/api.dart';
import 'package:sounds_good/core/utils/enums.dart';
import 'package:sounds_good/core/viewmodels/landing_viewmodel.dart';
import 'package:sounds_good/views/landing/widgets/landing_member_cell.dart';

class LandingMembersView extends StatefulWidget {
  LandingMembersView({Key key}) : super(key: key);

  @override
  _LandingMembersViewState createState() => _LandingMembersViewState();
}

class _LandingMembersViewState extends State<LandingMembersView> {
  @override
  Widget build(BuildContext context) {
    return Consumer<LandingViewModel>(
      builder: (context, landingViewModel, child) => Scaffold(
        body: landingViewModel.state == ViewState.Idle
            ? SafeArea(
                child: Stack(
                  children: <Widget>[
                    PagewiseListView(
                        scrollDirection: Axis.horizontal,
                        pageSize: landingViewModel.profilesRequest.limit,
                        padding: EdgeInsets.fromLTRB(12.0, 3.0, 12.0, 6.0),
                        itemBuilder: (context, entry, index) {
                          var placeholder = 'https://picsum.photos/250?image=9';
                          var profile = landingViewModel.members[index];

                          var url = profile.photo != ""
                              ? '${Api.endpoint}/${profile.photo}'
                              : placeholder;

                          return LandingMemberCell(
                            imageUrl: url,
                            id: profile.id,
                            name: profile.name,
                            friendlyLocation: profile.friendlyLocation,
                            instruments: profile.instruments,
                            followers: profile.followers,
                          );
                        },
                        pageFuture: (pageIndex) {
                          return landingViewModel.fetchMembers(pageIndex);
                        }),
                  ],
                ),
              )
            : Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }
}
