import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sounds_good/core/services/storage.dart';
import 'package:sounds_good/core/utils/text_strings.dart';

class AddInstrument extends StatefulWidget {
  final onSelectedInstrument;
  final provider;
  final bool profile;
  AddInstrument({this.onSelectedInstrument, this.provider, this.profile});

  @override
  _AddInstrumentState createState() => _AddInstrumentState();
}

class _AddInstrumentState extends State<AddInstrument> {
  List<String> availableInstruments = [];

  @override
  void initState() {
    super.initState();

    if (widget.profile == true) widget.provider.disableInstrumentsFromProfile();

    _availableIntruments();
  }

  Future _availableIntruments() async {
    var instrumentsFromStorage = await Storage.getAvailableInstruments();
    var instrumentsDecoded = jsonDecode(instrumentsFromStorage);
    instrumentsDecoded['items']
        .map((item) => availableInstruments.add(item))
        .toList();
  }

  List<String> getAvailableInstruments() {
    List<String> instrumentsToDisableFromPicker =
        widget.provider.getInstrumentsToDisableFromPicker();
    instrumentsToDisableFromPicker
        .map((instrument) => availableInstruments.remove(instrument))
        .toList();

    return availableInstruments;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _popUpInstrumentsPicker(
          context, getAvailableInstruments(), widget.onSelectedInstrument),
      child: AddInstrumentPill(),
    );
  }
}

class AddInstrumentPill extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 3.0, top: 3.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(const Radius.circular(15.0)),
        border: Border.all(color: Colors.blueGrey.shade200),
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16.0, 3.0, 16.0, 3.0),
        child: Icon(Icons.add, size: 18.0, color: Colors.blueGrey.shade400),
      ),
    );
  }
}

void _popUpInstrumentsPicker(context, instrumentsList, onSelectedInstrument) {
  int selectedItem = 1;
  showModalBottomSheet(
    context: context,
    builder: (BuildContext builder) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            TextStrings.profile_edit_add_instrument_title,
            textAlign: TextAlign.justify,
          ),
          backgroundColor: Colors.blueGrey,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.add_circle),
              onPressed: () {
                onSelectedInstrument(instrumentsList[selectedItem]);
                Navigator.pop(context);
              },
            )
          ],
        ),
        body: Container(
          child: CupertinoPicker(
            magnification: 1.0,
            backgroundColor: Colors.white10,
            children: instrumentsList
                .map<Widget>(
                  (item) => CupertinoActionSheetAction(
                    child: Text(
                      item,
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                    onPressed: () => {},
                  ),
                )
                .toList(),
            itemExtent: 52,
            looping: true,
            onSelectedItemChanged: (index) => selectedItem = index,
          ),
        ),
      );
    },
  );
}
