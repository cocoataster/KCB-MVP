import 'package:flutter/material.dart';

class InstrumentItem extends StatelessWidget {
  final String instrument;

  InstrumentItem({this.instrument});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _pill(instrument, context),
      ],
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

  BoxDecoration _getPillBoxDecoration(BuildContext context) {
    return BoxDecoration(
      borderRadius: BorderRadius.all(const Radius.circular(15.0)),
      color: Colors.indigo.shade200,
    );
  }
}
