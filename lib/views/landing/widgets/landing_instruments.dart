import 'package:flutter/material.dart';

class LandingInstrumentItem extends StatelessWidget {
  final String instrument;

  LandingInstrumentItem({this.instrument});

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
            padding: const EdgeInsets.fromLTRB(6.0, 3.0, 6.0, 3.0),
            child: Text(
              instrument,
              style: TextStyle(color: Colors.white, fontSize: 11),
            ),
          ),
        ),
      ],
    );
  }
}
