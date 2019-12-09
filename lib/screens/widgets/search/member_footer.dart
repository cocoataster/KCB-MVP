import 'package:flutter/material.dart';

class MemberFooter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Wrap(
              spacing: 4,
              runSpacing: 4,
              children: <Widget>[Text('Name'), Text('Location')],
            ),
          ),
          Padding(padding: const EdgeInsets.symmetric(vertical: 8)),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Wrap(
              spacing: 4.0,
              runSpacing: 4.0,
              children: <Widget>[Text('Instrument 1'), Text('Instrument 2')],
            ),
          )
        ],
      ),
    );
  }
}
