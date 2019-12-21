import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sounds_good/core/utils/enums.dart';
import 'package:sounds_good/core/viewmodels/search_viewmodel.dart';
import 'package:sounds_good/views/search/sections/search_locals_results.dart';
import 'package:sounds_good/views/search/sections/search_member_results.dart';
import 'package:sounds_good/views/search/widgets/search_filters.dart';
import 'package:sounds_good/views/search/widgets/search_type_selector.dart';

class SearchFiltersContainer extends StatefulWidget {
  @override
  _SearchFiltersContainerState createState() => _SearchFiltersContainerState();
}

class _SearchFiltersContainerState extends State<SearchFiltersContainer> {
  SearchViewModel search;
  var fetcher;
  var index;
  var searchType;

  @override
  void initState() {
    super.initState();
    Provider.of<SearchViewModel>(context, listen: false)
        .setType(SearchType.Members);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SearchViewModel>(
      builder: (context, searchViewModel, child) => Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SearchFilters(),
                SearchTypeSelector(),
                searchViewModel.type == SearchType.Members
                    ? MemberResults()
                    : LocalResults(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
