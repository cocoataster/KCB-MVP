import 'package:flutter/material.dart';
import 'package:sounds_good/core/utils/text_styles.dart';

class FullWidthButton extends StatelessWidget {
  final String value;
  final Color color;
  final VoidCallback onPressed;
  

  FullWidthButton({this.value, this.color, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width - 48.0,
      child: RaisedButton(
        onPressed: onPressed,
        color: color,
        child: Text(value, style: TextStyles.buttons_value),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }
}
