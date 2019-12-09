import 'package:flutter/material.dart';

class MemberFooter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[Text('Name'), Text('Location')],
        ),
        Wrap(
          spacing: 4.0,
          runSpacing: 4.0,
          children: <Widget>[Text('Instrument 1'), Text('Instrument 2')],
        )
      ],
    );
  }
}
