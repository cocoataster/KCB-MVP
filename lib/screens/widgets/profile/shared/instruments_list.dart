import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sounds_good/core/viewmodels/profile_viewmodel.dart';
import 'package:sounds_good/screens/widgets/profile/shared/instrument_item.dart';

class InstrumentsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileViewModel>(
      builder: (context, data, child) {
        print('Instruments Share: ${data.profile.instruments}');
        List<String> instruments = data.profile.instruments;
        return Wrap(
          spacing: 8.0,
          runSpacing: 4.0,
          children: instruments
              .map(
                  (String instrument) => InstrumentItem(instrument: instrument))
              .toList(),
        );
      },
    );
  }
}