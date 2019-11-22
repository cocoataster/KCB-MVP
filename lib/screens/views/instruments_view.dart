import 'package:flutter/material.dart';
import 'package:sounds_good/core/viewmodels/instruments_viewmodel.dart';
import 'package:sounds_good/screens/views/base_view.dart';

class InstrumentsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView<InstrumentsViewModel>(
      onModelReady: (model) {
        model.fetchInstruments();
      },
      builder: (context, model, child) => Column(
        children: model.instruments.items.map((item) => Text(item)).toList(),
      ),
    );
  }
}
