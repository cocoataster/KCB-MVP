import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sounds_good/core/utils/enums.dart';
import 'package:sounds_good/screens/widgets/profile/shared/profile_mode_switch_button.dart';

class SearchFilters extends StatefulWidget {
  SearchFilters({Key key}) : super(key: key);

  @override
  _SearchFiltersState createState() => _SearchFiltersState();
}

class _SearchFiltersState extends State<SearchFilters> {
  final Map<SearchType, Widget> searchWidgets = const <SearchType, Widget>{
    SearchType.Members: Text('Members'),
    SearchType.Locals: Text('Locals'),
  };

  SearchType typeSelected = SearchType.Members;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          leading: FiltersButton(),
          title: TextField(
            decoration: InputDecoration(
              suffixIcon: Icon(Icons.search),
              border: OutlineInputBorder(),
              labelText: 'Type something',
            ),
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
              });
            },
            groupValue: typeSelected,
          ),
        ),
      ],
    );
  }
}

class FiltersButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40.0,
      height: 40.0,
      child: FloatingActionButton(
        backgroundColor: Colors.white,
        elevation: 4,
        shape: CircleBorder(),
        child: Icon(Icons.format_list_bulleted, color: Colors.black),
        onPressed: () => {},
      ),
    );
  }
}
