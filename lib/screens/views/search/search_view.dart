import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sounds_good/core/models/profile.dart';
import 'package:sounds_good/core/utils/enums.dart';
import 'package:sounds_good/core/viewmodels/search_viewmodel.dart';
import 'package:sounds_good/screens/views/search/search_filters.dart';
import 'package:sounds_good/screens/widgets/search/member_cell.dart';

class SearchView extends StatefulWidget {
  @override
  _SearchViewState createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  SearchViewModel searchViewModel = SearchViewModel();

  @override
  void initState() {
    searchViewModel.fetchProfiles();
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
                        padding: EdgeInsets.only(top: 100),
                        child: ListView(
                          padding: EdgeInsets.all(24),
                          children: _getListData(model.profiles),
                        ),
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

  _getListData(List<Profile> profiles) {
    List<Widget> widgets = [];

    print("Get List Data. After async call");

    for (var profile in profiles) {
      var url = 'https://picsum.photos/250?image=9';
      if (profile.photo != null) {
        url = 'http://ec2-52-87-34-66.compute-1.amazonaws.com/' + profile.photo;
      }
      print(url);
      widgets.add(MemberCell(url));
    }

    return widgets;
  }
}
