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
                        child: SearchPage(),
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

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  SearchViewModel search;
  var pageSize;

  @override
  void initState() {
    search = Provider.of<SearchViewModel>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (search.type == SearchType.Members) {
      print('Case search members');
      return PagewiseListView(
          pageSize: search.profileSearchRequest.limit,
          padding: EdgeInsets.all(15.0),
          itemBuilder: (context, entry, index) {
            var placeholder = 'assets/images/profile.png';
            var profile = search.profiles[index];

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
            return search.fetchProfilePage(pageIndex);
          });
    } else {
      print('Case search Locals');
      return PagewiseListView(
          pageSize: search.localSearchRequest.limit,
          padding: EdgeInsets.all(15.0),
          itemBuilder: (context, entry, index) {
            var placeholder = 'assets/images/profile.png';
            var local = search.locals[index];

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
            return search.fetchLocalPage(pageIndex);
          });
    }
  }
}
