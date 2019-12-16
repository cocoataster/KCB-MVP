import 'package:flutter/material.dart';
import 'package:sounds_good/core/utils/colors.dart';
import 'package:sounds_good/core/utils/text_strings.dart';
import 'package:sounds_good/views/shared_resources/full_width_button.dart';

class LocalCTAButton extends StatelessWidget {
  const LocalCTAButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 20.0, bottom: 30),
      child: FullWidthButton(
        value: TextStrings.locals_cta_button_value,
        color: AppColors.firstLevelCTAColor,
        onPressed: () => Navigator.pop(context),
      ),
    );
  }
}