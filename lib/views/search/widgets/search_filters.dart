import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sounds_good/core/utils/text_strings.dart';
import 'package:sounds_good/core/viewmodels/search_viewmodel.dart';
import 'package:sounds_good/views/search/widgets/button_modal_filters.dart';

class SearchFilters extends StatefulWidget {
  SearchFilters({Key key}) : super(key: key);

  @override
  _SearchFiltersState createState() => _SearchFiltersState();
}

class _SearchFiltersState extends State<SearchFilters> {
  _search(String name) {
    var searchViewModel = Provider.of<SearchViewModel>(context, listen: false);
    if (name.length > 3) {
      setState(() {
        searchViewModel.updateName(name);
      });
    } else if (name.length == 0) {
      setState(() {
        searchViewModel.updateName("");
      });
    }
  }

  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Consumer<SearchViewModel>(
        builder: (context, searchViewModel, child) => ListTile(
          leading: FiltersButton(),
          title: TextFormField(
            controller: _controller,
            decoration: InputDecoration(
              prefixIcon: IconButton(
                icon: Icon(Icons.cancel),
                onPressed: () {
                  searchViewModel.resetProfileSearch();
                  FocusScope.of(context).requestFocus(FocusNode());
                  _controller.clear();
                },
              ),
              suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () =>
                      FocusScope.of(context).requestFocus(FocusNode())),
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
              labelStyle: TextStyle(fontSize: 16),
              border: new OutlineInputBorder(
                borderRadius: const BorderRadius.all(
                  const Radius.circular(24.0),
                ),
              ),
              hintText: TextStrings.search_filter_search_hint,
              labelText: TextStrings.search_filter_search_label,
            ),
            onChanged: (name) {
              _search(name);
            },
            onFieldSubmitted: (saved) => FocusScope.of(context).requestFocus(
              FocusNode(),
            ),
          ),
        ),
      ),
    );
  }
}
