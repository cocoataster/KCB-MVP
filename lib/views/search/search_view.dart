import 'package:flutter/material.dart';
import 'package:flutter_pagewise/flutter_pagewise.dart';
import 'package:provider/provider.dart';
import 'package:sounds_good/core/models/local.dart';
import 'package:sounds_good/core/models/profile.dart';
import 'package:sounds_good/core/services/api.dart';
import 'package:sounds_good/core/utils/enums.dart';
import 'package:sounds_good/core/viewmodels/search_viewmodel.dart';
import 'package:sounds_good/views/search/search_filters.dart';
import 'package:sounds_good/views/search/widgets/local_cell.dart';
import 'package:sounds_good/views/search/widgets/member_cell.dart';

class SearchView extends StatefulWidget {
  @override
  _SearchViewState createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  SearchViewModel searchViewModel = SearchViewModel();

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
                              var item = model.items[index];

                              var url = item.photo != ""
                                  ? '${Api.endpoint}/${item.photo}'
                                  : placeholder;

                              return ItemCell(
                                  type: searchViewModel.type,
                                  item: item,
                                  url: url,
                                  id: item.id);
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
