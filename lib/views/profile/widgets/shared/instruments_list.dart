import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sounds_good/core/viewmodels/profile_viewmodel.dart';
import 'package:sounds_good/views/shared_resources/instrument_pill.dart';

class InstrumentsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileViewModel>(
      builder: (context, profileViewModel, child) {
        List<String> instruments = profileViewModel.profile.instruments;
        return Wrap(
          spacing: 8.0,
          runSpacing: 4.0,
          children: instruments
              .map(
                (String instrument) =>
                    InstrumentPill(instrumentName: instrument, editable: false),
              )
              .toList(),
        );
      },
    );
  }
}
