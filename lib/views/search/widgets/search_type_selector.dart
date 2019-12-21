import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sounds_good/core/utils/enums.dart';
import 'package:sounds_good/core/utils/text_strings.dart';
import 'package:sounds_good/core/viewmodels/search_viewmodel.dart';

class SearchTypeSelector extends StatefulWidget {
  SearchTypeSelector({Key key}) : super(key: key);

  @override
  _SearchTypeSelectorState createState() => _SearchTypeSelectorState();
}

class _SearchTypeSelectorState extends State<SearchTypeSelector> {
  SearchType typeSelected;

  final Map<SearchType, Widget> searchWidgets = const <SearchType, Widget>{
    SearchType.Members:
        Text(TextStrings.search_filter_segmented_control_members),
    SearchType.Locals: Text(TextStrings.search_filter_segmented_control_locals),
  };

  void initState() {
    super.initState();
    typeSelected = Provider.of<SearchViewModel>(context, listen: false).type;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SearchViewModel>(
      builder: (context, searchViewModel, child) => SizedBox(
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
    );
  }
}