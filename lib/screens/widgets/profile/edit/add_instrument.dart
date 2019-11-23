import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sounds_good/core/viewmodels/instruments_viewmodel.dart';
import 'package:sounds_good/screens/views/base_view.dart';

class AddInstrument extends StatefulWidget {
  final onSelectedInstrument;
  AddInstrument({this.onSelectedInstrument});

  @override
  _AddInstrumentState createState() => _AddInstrumentState();
}

class _AddInstrumentState extends State<AddInstrument> {
  @override
  Widget build(BuildContext context) {
    return Consumer<InstrumentsViewModel>(
      builder: (context, instrumentsViewmodel, child) =>

    GestureDetector(
      onTap: () =>
          _popUp(context, instrumentsViewmodel, widget.onSelectedInstrument),
      child: _pill(context),
    ),);
  }
}

Container _pill(context) {
  return Container(
    margin: EdgeInsets.only(right: 3.0, top: 3.0),
    decoration: _getPillBoxDecoration(context),
    child: Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 3.0, 16.0, 3.0),
      child: Icon(Icons.add, size: 18.0, color: Colors.blueGrey.shade400),
    ),
  );
}

BoxDecoration _getPillBoxDecoration(BuildContext context) {
  return BoxDecoration(
    borderRadius: BorderRadius.all(const Radius.circular(15.0)),
    border: Border.all(color: Colors.blueGrey.shade200),
    color: Colors.white,
  );
}

void _popUp(context, modelInstruments, onSelectedInstrument) {
  int selectedItem = 1;
  showModalBottomSheet(
    context: context,
    builder: (BuildContext builder) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            "Select Your Instrument",
            textAlign: TextAlign.justify,
          ),
          backgroundColor: Colors.blueGrey,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                onSelectedInstrument(
                    modelInstruments.getInstrument(selectedItem));
                Navigator.pop(context);
              },
            )
          ],
        ),
        body: Container(
          child: CupertinoPicker(
            magnification: 1.0,
            backgroundColor: Colors.white10,
            children: modelInstruments.instruments.items
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
