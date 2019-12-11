import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sounds_good/core/utils/enums.dart';
import 'package:sounds_good/core/viewmodels/profile_viewmodel.dart';
import 'package:sounds_good/views/profile/widgets/edit/instruments_list.dart';
import 'package:sounds_good/views/profile/widgets/shared/section_title.dart';
import 'package:sounds_good/views/profile/widgets/shared/instruments_list.dart';

class InstrumentsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileViewModel>(
      builder: (context, model, child) => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ProfileSectionTitle(sectionTitle: 'What can I play?'),
          model.getMode == ProfileMode.Edit
              ? EditInstrumentsList()
              : InstrumentsList()
        ],
      ),
    );
  }
}
