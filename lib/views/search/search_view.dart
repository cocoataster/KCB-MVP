import 'package:flutter/material.dart';
import 'package:flutter_pagewise/flutter_pagewise.dart';
import 'package:provider/provider.dart';
import 'package:sounds_good/core/services/api.dart';
import 'package:sounds_good/core/utils/enums.dart';
import 'package:sounds_good/core/viewmodels/search_viewmodel.dart';
import 'package:sounds_good/views/search/search_filters.dart';
import 'package:sounds_good/views/search/widgets/member_cell.dart';

class SearchView extends StatefulWidget {
  @override
  _SearchViewState createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  SearchViewModel searchViewModel = SearchViewModel();

  @override
  void initState() {
    //searchViewModel.fetchProfiles();
    super.initState();
  }

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
                      SearchFilters(),
                      Padding(
                        padding: EdgeInsets.only(top: 120),
                        child: PagewiseListView(
                            pageSize: model.limit,
                            padding: EdgeInsets.all(15.0),
                            itemBuilder: (context, entry, index) {
                              var placeholder =
                                  'https://picsum.photos/250?image=9';
                              var profile = model.profiles[index];

                              var url = profile.photo != ""
                                  ? '${Api.endpoint}/${profile.photo}'
                                  : placeholder;

                              return MemberCell(
                                imageUrl: url,
                                name: profile.name,
                                friendlyLocation: profile.friendlyLocation,
                                instruments: profile.instruments,
                                //followers: profile.followers,
                              );
                            },
                            pageFuture: (pageIndex) {
                              return model.fetchPage(pageIndex);
                            }),
                      ),
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
