import 'package:flutter/material.dart';
import 'package:sounds_good/core/utils/text_strings.dart';
import 'package:sounds_good/core/utils/text_styles.dart';
import 'package:sounds_good/views/shared_resources/closing_header_button.dart';


class FiltersHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 8,
          child: Text(
            TextStrings.search_filters_section_title,
            style: TextStyles.section_header,
          ),
        ),
        Expanded(
          flex: 2,
          child: ClosingHeaderButton(),
        ),
      ],
    );
  }
}
