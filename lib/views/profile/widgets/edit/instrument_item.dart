import 'package:flutter/material.dart';
import 'package:sounds_good/views/shared_resources/instrument_pill.dart';

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
          InstrumentPill(instrumentName: instrument, editable: isSelected),
          Positioned(
            top: 0,
            right: 0,
            child: EditPillIcon(status: isSelected),
          ),
        ],
      ),
    );
  }
}
