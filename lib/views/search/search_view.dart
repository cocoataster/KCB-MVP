import 'package:flutter/material.dart';
import 'package:flutter_pagewise/flutter_pagewise.dart';
import 'package:provider/provider.dart';
import 'package:sounds_good/core/models/local.dart';
import 'package:sounds_good/core/models/profile.dart';
import 'package:sounds_good/core/services/api.dart';
import 'package:sounds_good/core/utils/enums.dart';
import 'package:sounds_good/core/viewmodels/search_viewmodel.dart';
import 'package:sounds_good/views/search/sections/search_filters.dart';
import 'package:sounds_good/views/search/widgets/local_cell.dart';
import 'package:sounds_good/views/search/widgets/member_cell.dart';

class SearchView extends StatefulWidget {
  @override
  _SearchViewState createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  SearchViewModel searchViewModel = SearchViewModel();

  @override
  void initState() {
    searchViewModel.type = SearchType.Members;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SearchViewModel>(
      builder: (context) => searchViewModel,
      child: Consumer<SearchViewModel>(
        builder: (context, searchViewModel, child) => Scaffold(
          body: searchViewModel.state == ViewState.Idle
              ? SafeArea(
                  child: Stack(
                    children: <Widget>[
                      SearchFilters(),
                      Padding(
                        padding: EdgeInsets.only(top: 120),
                        child: searchList(searchViewModel),
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

Widget searchList(SearchViewModel searchViewModel) {
  switch (searchViewModel.type) {
    case SearchType.Members:
      //print('Case search members');
      return PagewiseListView(
          pageSize: searchViewModel.profileSearchRequest.limit,
          padding: EdgeInsets.all(15.0),
          itemBuilder: (context, entry, index) {
            var placeholder = 'assets/images/profile.png';
            var profile = searchViewModel.profiles[index];

            var url = profile.photo != ""
                ? '${Api.endpoint}/${profile.photo}'
                : placeholder;

            return MemberCell(
              imageUrl: url,
              name: profile.name,
              friendlyLocation: profile.friendlyLocation,
              instruments: profile.instruments,
              followers: profile.followers,
              id: profile.id,
            );
          },
          pageFuture: (pageIndex) {
            return searchViewModel.fetchProfilePage(pageIndex);
          });
      break;
    case SearchType.Locals:
      print('Case search Locals');
      return PagewiseListView(
          pageSize: searchViewModel.localSearchRequest.limit,
          padding: EdgeInsets.all(15.0),
          itemBuilder: (context, entry, index) {
            var placeholder = 'assets/images/profile.png';
            var local = searchViewModel.locals[index];

            var url = local.photos.first != ""
                ? '${Api.endpoint}/${local.photos.first}'
                : placeholder;

            return LocalCell(
              imageUrl: url,
              localId: local.id,
              name: local.name,
              price: local.price,
              description: local.description,
            );
          },
          pageFuture: (pageIndex) {
            return searchViewModel.fetchLocalPage(pageIndex);
          });
      break;
  }
}

class ItemCell extends StatelessWidget {
  final SearchType type;
  final dynamic item;
  final String url;
  final String id;

  ItemCell({this.type, this.item, this.url, this.id});

  @override
  Widget build(BuildContext context) {
    MemberCell memberCell;

    switch (type) {
      case SearchType.Members:
        var profile = item as Profile;
        return MemberCell(
          imageUrl: url,
          name: profile.name,
          friendlyLocation: profile.friendlyLocation,
          instruments: profile.instruments,
          followers: profile.followers,
          id: id,
        );
        break;
      case SearchType.Locals:
        var local = item as Local;
        return LocalCell(
          imageUrl: url,
          name: local.name,
          price: local.price,
          description: local.description,
        );
        break;
    }
    return memberCell;
  }
}
