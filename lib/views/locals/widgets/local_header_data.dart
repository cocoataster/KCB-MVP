import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sounds_good/core/utils/text_styles.dart';
import 'package:sounds_good/core/viewmodels/local_viewmodel.dart';

class LocalHeaderData extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<LocalViewModel>(
      builder: (context, localViewModel, child) => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            localViewModel.local.name,
            style: TextStyles.section_header,
          ),
          Row(
            children: <Widget>[
              Text(
                localViewModel.local.friendlyLocation,
                style: TextStyles.section_subHeader,
              ),
              Text(
                ' ${localViewModel.local.price} €/h',
                style: TextStyles.section_subHeader,
              ),
            ],
          ),
        ],
      ),
    );
  }
}