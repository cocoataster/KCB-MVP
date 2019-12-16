import 'package:flutter/material.dart';
import 'package:sounds_good/views/locals/widgets/local_header_button.dart';
import 'package:sounds_good/views/locals/widgets/local_header_data.dart';

class LocalHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          top: 0,
          right: 0,
          child: LocalHeaderButton(),
        ),
        LocalHeaderData(),
      ],
    );
  }
}
