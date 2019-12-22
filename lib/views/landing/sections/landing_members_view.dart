import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sounds_good/core/services/api.dart';
import 'package:sounds_good/core/viewmodels/landing_viewmodel.dart';
import 'package:sounds_good/views/landing/widgets/landing_member_cell.dart';

class LandingMembersView extends StatefulWidget {
  LandingMembersView({Key key}) : super(key: key);

  @override
  _LandingMembersViewState createState() => _LandingMembersViewState();
}

class _LandingMembersViewState extends State<LandingMembersView> {
  ScrollController _scrollController = ScrollController();
  int index = 0;

  @override
  void initState() {
    super.initState();

    LandingViewModel landingViewModel =
        Provider.of<LandingViewModel>(context, listen: false);
    landingViewModel.fetchBand(index);

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent &&
          landingViewModel.profilesRequest.hasMorePages()) {
        ++index;
        landingViewModel.fetchBand(index);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LandingViewModel>(
      builder: (context, landingViewModel, child) => Scaffold(
        body: SafeArea(
          child: Stack(
            children: <Widget>[
              ListView.builder(
                  scrollDirection: Axis.horizontal,
                  controller: _scrollController,
                  itemCount: landingViewModel.members.length,
                  itemBuilder: (BuildContext context, int index) {
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
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
