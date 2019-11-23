import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sounds_good/core/viewmodels/instruments_viewmodel.dart';
import 'package:sounds_good/screens/views/base_view.dart';

//TODO esto era de pruebas, hay que borrarlo

class InstrumentsView extends StatefulWidget {
  @override
  _InstrumentsViewState createState() => _InstrumentsViewState();
}

class _InstrumentsViewState extends State<InstrumentsView> {
  int selectedItem = 1;
  @override
  Widget build(BuildContext context) {
    return BaseView<InstrumentsViewModel>(
      onModelReady: (model) {
        model.fetchInstruments();
      },
      builder: (context, model, child) => MaterialButton(
        child: Text("Instruments"),
        color: Colors.white,
        onPressed: () {
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
                      onPressed: () {print(model.getInstrument(selectedItem));},
                    )
                  ],
                ),
                body: Container(
                  child: CupertinoPicker(
                    magnification: 1.0,
                    backgroundColor: Colors.white10,
                    children: model.instruments.items
                        .map((item) => CupertinoActionSheetAction(
                            child: Text(
                              item,
                              style: TextStyle(fontSize: 16, color: Colors.black),
                            ),
                            onPressed: () => {}))
                        .toList(),
                    itemExtent: 52,
                    looping: true,
                    onSelectedItemChanged: (index) => selectedItem = index,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
