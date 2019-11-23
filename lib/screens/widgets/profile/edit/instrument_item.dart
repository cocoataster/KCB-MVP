import 'package:flutter/material.dart';

typedef void InstrumentsListCallback(String instrument, bool isSelected);

class EditInstrumentItem extends StatelessWidget {
  final String instrument;
  final bool isSelected;
  final InstrumentsListCallback onListChanged;

  EditInstrumentItem({String instrument, this.isSelected, this.onListChanged})
      : instrument = instrument,
        super(key: ObjectKey(instrument));

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onListChanged(instrument, isSelected);
      },
      child: Stack(
        children: [
          _pill(instrument, context),
          Positioned(
            top: 0,
            right: 0,
            child: _iconButton(context),
          ),
        ],
      ),
    );
  }

  Container _pill(String name, BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 3.0, top: 3.0),
      decoration: _getPillBoxDecoration(context, isSelected),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12.0, 5.0, 12.0, 5.0),
        child: Text(
          name,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  BoxDecoration _getPillBoxDecoration(BuildContext context, bool isSelected) {
    var _boxColor =
        isSelected ? Colors.blueGrey.shade100 : Colors.indigo.shade200;

    return BoxDecoration(
      borderRadius: BorderRadius.all(const Radius.circular(15.0)),
      color: _boxColor,
    );
  }

  Container _iconButton(context) {
    return Container(
      width: 14.0,
      height: 14.0,
      child: FloatingActionButton(
          backgroundColor: Colors.red,
          elevation: 3,
          shape: CircleBorder(),
          child: _icon(context),
          onPressed: () => {}),
    );
  }

  Icon _icon(BuildContext context) {
    var _iconImage = isSelected ? Icons.check : Icons.close;
    return Icon(
      _iconImage,
      color: Colors.white,
      size: 10,
    );
  }
}
