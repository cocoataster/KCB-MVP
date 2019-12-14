import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sounds_good/core/utils/enums.dart';
import 'package:sounds_good/core/viewmodels/search_viewmodel.dart';
import 'package:sounds_good/views/search/search_view.dart';

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
    SearchType.Members: Text('Members'),
    SearchType.Locals: Text('Locals'),
  };

  @override
  Widget build(BuildContext context) {
    return Consumer<SearchViewModel>(builder: (context, search, child) {
      return Column(
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
                hintText: 'hintText',
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
                  //search.resetRequest(selection);
                  search.setType(selection);
                });
              },
              groupValue: typeSelected,
            ),
          ),
        ],
      );
    });
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
        onPressed: () => {},
      ),
    );
  }
}
