import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sounds_good/core/utils/text_strings.dart';
import 'package:sounds_good/core/viewmodels/available_instruments_viewmodel.dart';

class AddInstrument extends StatefulWidget {
  final onSelectedInstrument;
  AddInstrument({this.onSelectedInstrument});

  @override
  _AddInstrumentState createState() => _AddInstrumentState();
}

class _AddInstrumentState extends State<AddInstrument> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AvailableInstrumentsViewModel>(
      builder: (context, availableInstruments, child) => GestureDetector(
        onTap: () => _popUpInstrumentsPicker(
            context,
            availableInstruments.getAvailableInstruments(),
            widget.onSelectedInstrument),
        child: AddInstrumentPill(),
      ),
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
