import 'package:flutter/material.dart';
import 'package:sounds_good/core/utils/text_strings.dart';
import 'package:sounds_good/views/shared_resources/closing_header_button.dart';
import 'package:sounds_good/views/shared_resources/section_title.dart';

class FiltersHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          top: 0,
          right: 0,
          child: ClosingHeaderButton(),
        ),
        SectionTitle(
              sectionTitle: TextStrings.search_filters_section_title,
            ),
      ],
    );
  }
}