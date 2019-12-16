import 'package:flutter/material.dart';
import 'package:sounds_good/core/utils/text_styles.dart';

class SectionTitle extends StatelessWidget {
  SectionTitle({this.sectionTitle}) : super();
  final String sectionTitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: Row(
          children: <Widget>[
            Text(
              sectionTitle,
              style: TextStyles.section_header,
            ),
          ],
        ));
  }
}
