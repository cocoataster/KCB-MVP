import 'package:flutter/material.dart';

class InstrumentItem extends StatelessWidget {
  final String instrument;

  InstrumentItem({this.instrument});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.only(right: 3.0, top: 3.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(const Radius.circular(15.0)),
            color: Colors.indigo.shade200,
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(12.0, 5.0, 12.0, 5.0),
            child: Text(
              instrument,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
