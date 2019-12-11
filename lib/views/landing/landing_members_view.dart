import 'package:flutter/material.dart';
import 'package:flutter_pagewise/flutter_pagewise.dart';
import 'package:provider/provider.dart';
import 'package:sounds_good/core/services/api.dart';
import 'package:sounds_good/core/utils/enums.dart';
import 'package:sounds_good/core/viewmodels/search_viewmodel.dart';
import 'package:sounds_good/views/landing/widgets/landing_member_cell.dart';

class LandingMembersView extends StatefulWidget {
  LandingMembersView({Key key}) : super(key: key);

  @override
  _LandingMembersViewState createState() => _LandingMembersViewState();
}

class _LandingMembersViewState extends State<LandingMembersView> {
  final SearchViewModel searchViewModel = SearchViewModel();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SearchViewModel>(
      builder: (context) => searchViewModel,
      child: Consumer<SearchViewModel>(
        builder: (context, model, child) => Scaffold(
          body: model.state == ViewState.Idle
              ? SafeArea(
                  child: Stack(
                    children: <Widget>[
                      PagewiseListView(
                          scrollDirection: Axis.horizontal,
                          pageSize: model.limit,
                          padding: EdgeInsets.all(15.0),
                          itemBuilder: (context, entry, index) {
                            var placeholder =
                                'https://picsum.photos/250?image=9';
                            var profile = model.items[index];

                            var url = profile.photo != ""
                                ? '${Api.endpoint}/${profile.photo}'
                                : placeholder;

                            return LandingMemberCell(
                              imageUrl: url,
                              name: profile.name,
                              friendlyLocation: profile.friendlyLocation,
                              instruments: profile.instruments,
                            );
                          },
                          pageFuture: (pageIndex) {
                            return model.fetchPage(pageIndex);
                          }),
                    ],
                  ),
                )
              : Center(
                  child: CircularProgressIndicator(),
                ),
        ),
      ),
    );
  }
}
