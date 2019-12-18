import 'package:flutter/material.dart';
import 'package:sounds_good/core/utils/colors.dart';

class InstrumentPill extends StatelessWidget {
  final String instrumentName;
  final bool editable;
  InstrumentPill({this.instrumentName, this.editable});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 3.0, top: 3.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(const Radius.circular(15.0)),
        color: editable ? AppColors.highlightedElement : AppColors.disabledElement,
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12.0, 5.0, 12.0, 5.0),
        child: Text(
          instrumentName,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}

class EditPillIcon extends StatelessWidget {
  final bool status;
  const EditPillIcon({this.status});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 14.0,
      height: 14.0,
      child: FloatingActionButton(
          backgroundColor: Colors.red,
          elevation: 3,
          shape: CircleBorder(),
          child: Icon(
            status ? Icons.check : Icons.close,
            color: Colors.white,
            size: 10,
          ),
          onPressed: () => {}),
    );
  }
}
