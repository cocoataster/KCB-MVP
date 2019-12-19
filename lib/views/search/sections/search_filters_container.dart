import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sounds_good/core/utils/enums.dart';
import 'package:sounds_good/core/utils/text_strings.dart';
import 'package:sounds_good/core/viewmodels/search_viewmodel.dart';
import 'package:sounds_good/views/search/sections/search_filters.dart';
import 'package:sounds_good/views/search/sections/search_locals_results.dart';
import 'package:sounds_good/views/search/sections/search_member_results.dart';

class SearchFiltersContainer extends StatefulWidget {
  @override
  _SearchFiltersContainerState createState() => _SearchFiltersContainerState();
}

class _SearchFiltersContainerState extends State<SearchFiltersContainer> {
  SearchType typeSelected;
  SearchViewModel search;
  var fetcher;
  var index;
  var searchType;

  final Map<SearchType, Widget> searchWidgets = const <SearchType, Widget>{
    SearchType.Members:
        Text(TextStrings.search_filter_segmented_control_members),
    SearchType.Locals: Text(TextStrings.search_filter_segmented_control_locals),
  };

  @override
  void initState() {
    super.initState();
    Provider.of<SearchViewModel>(context, listen: false)
        .setType(SearchType.Members);
    typeSelected = Provider.of<SearchViewModel>(context, listen: false).type;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SearchViewModel>(
      builder: (context, searchViewModel, child) => Scaffold(
        body: SafeArea(
          child: Column(
            children: <Widget>[
              ListTile(
                leading: FiltersButton(),
                title: TextFormField(
                  decoration: InputDecoration(
                    suffixIcon: Icon(Icons.search),
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
                    if (name.length > 3) {
                      setState(() {
                        searchViewModel.updateName(name);
                      });
                    } else if (name.length == 0) {
                      setState(() {
                        searchViewModel.updateName("");
                      });
                    }
                  },
                ),
              ),
              SizedBox(
                height: 50.0,
                width: 180.0,
                child: CupertinoSegmentedControl<SearchType>(
                  padding: EdgeInsets.all(0.0),
                  borderColor: Colors.blueGrey,
                  selectedColor: Colors.blueGrey,
                  children: searchWidgets,
                  onValueChanged: (selection) {
                    setState(() {
                      typeSelected = selection;
                      searchViewModel.setType(selection);
                    });
                  },
                  groupValue: typeSelected,
                ),
              ),
              typeSelected == SearchType.Members
                  ? MemberResults()
                  : LocalResults(),
            ],
          ),
        ),
      ),
    );
  }
}
