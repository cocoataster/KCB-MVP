import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sounds_good/core/utils/enums.dart';
import 'package:sounds_good/core/utils/text_strings.dart';
import 'package:sounds_good/core/viewmodels/search_viewmodel.dart';

import 'package:sounds_good/views/search/sections/filters.dart';

class SearchFilters extends StatefulWidget {
  SearchFilters({Key key}) : super(key: key);

  @override
  _SearchFiltersState createState() => _SearchFiltersState();
}

class _SearchFiltersState extends State<SearchFilters> {
  SearchType typeSelected;

  @override
  void initState() {
    typeSelected = Provider.of<SearchViewModel>(context, listen: false).type;
    super.initState();
  }

  final Map<SearchType, Widget> searchWidgets = const <SearchType, Widget>{
    SearchType.Members:
        Text(TextStrings.search_filter_segmented_control_members),
    SearchType.Locals: Text(TextStrings.search_filter_segmented_control_locals),
  };

  @override
  Widget build(BuildContext context) {
    return Consumer<SearchViewModel>(
      builder: (context, search, child) => Column(
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
                    search.updateName(name);
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
                  search.setType(selection);
                  
                });
              },
              groupValue: typeSelected,
            ),
          ),
        ],
      ),
    );
  }
}

class FiltersButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 45.0,
      height: 45.0,
      child: FloatingActionButton(
        backgroundColor: Colors.white,
        elevation: 4,
        shape: CircleBorder(),
        child: Icon(Icons.format_list_bulleted, color: Colors.black),
        onPressed: () => _settingModalBottomSheet(context),
      ),
    );
  }
}

void _settingModalBottomSheet(context) {
  showBottomSheet(
    context: context,
    builder: (context) {
      return Container(
        height: MediaQuery.of(context).size.height -150,
        width: MediaQuery.of(context).size.width,
        color: Colors.transparent,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(20.0),
              topRight: const Radius.circular(20.0),
            ),
          ),
          child: Filters(),
        ),
      );
    },
  );
}
