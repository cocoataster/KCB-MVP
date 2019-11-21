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
            child: _iconClose(context),
          ),
        ],
      ),
    );
  }

  Container _pill(String name, BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 3.0, top: 3.0),
      decoration: _getPillBoxDecoration(context),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12.0, 5.0, 12.0, 5.0),
        child: Text(
          name,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Container _iconClose(BuildContext context) {
    return Container(
      width: 15.0,
      height: 15.0,
      child: _getIcon(context),
      decoration: _getIconDecoration(context),
    );
  }

  BoxDecoration _getPillBoxDecoration(BuildContext context) {
    var _boxColor =
        isSelected ? Colors.blueGrey.shade100 : Colors.indigo.shade200;

    return BoxDecoration(
      borderRadius: BorderRadius.all(const Radius.circular(15.0)),
      color: _boxColor,
    );
  }

  Icon _getIcon(BuildContext context) {
    var _iconImage = isSelected ? Icons.check : Icons.close;

    return Icon(
      _iconImage,
      color: Colors.white,
      size: 10.0,
    );
  }

  BoxDecoration _getIconDecoration(BuildContext context) {
    var _iconColor = isSelected ? Colors.red.shade200 : Colors.red;

    return BoxDecoration(
      borderRadius: BorderRadius.all(const Radius.circular(50.0)),
      color: _iconColor,
    );
  }
}
