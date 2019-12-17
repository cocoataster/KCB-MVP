import 'package:flutter/material.dart';
import 'package:sounds_good/core/utils/text_strings.dart';

class ClosingHeaderButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40.0,
      height: 40.0,
      child: FloatingActionButton(
        backgroundColor: Colors.white,
        elevation: 4,
        shape: CircleBorder(),
        child: Icon(Icons.close,
            color: Colors.black,
            semanticLabel: TextStrings.locals_close_button_value),
        onPressed: () => Navigator.pop(context),
      ),
    );
  }
}