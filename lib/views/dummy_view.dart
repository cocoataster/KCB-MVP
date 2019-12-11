import 'package:flutter/material.dart';

class DummyView extends StatelessWidget {
  final text;
  const DummyView(this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            text,
            style: Theme.of(context).textTheme.display2,
          ),
        ],
      )),
    );
  }
}
