import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sounds_good/core/utils/text_strings.dart';
import 'package:sounds_good/core/viewmodels/search_viewmodel.dart';
import 'package:sounds_good/views/profile/widgets/edit/add_instrument.dart';
import 'package:sounds_good/views/profile/widgets/edit/instrument_item.dart';

class InstrumentsFilter extends StatefulWidget {
  @override
  _InstrumentsFilterState createState() => _InstrumentsFilterState();
}

class _InstrumentsFilterState extends State<InstrumentsFilter> {
  void _addInstrument(String instrument) {
    setState(() {
      Provider.of<SearchViewModel>(context, listen: false)
          .addInstrument(instrument);
    });
  }

  void _handleInstrumentChanged(String instrument, bool isSelected) {
    setState(() {
      Provider.of<SearchViewModel>(context, listen: false)
          .removeInstrument(instrument);
    });
  }

  double _continuousValue = 5.0;

  void _handleDistance(double value) {
    setState(() {
      _continuousValue = value;
      Provider.of<SearchViewModel>(context, listen: false).setDistanceFilter(value);
    });

  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SearchViewModel>(
      builder: (context, search, child) => Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(TextStrings.search_filter_instruments_section_title),
            Row(
                children: search.getSelectedInstruments().map((instrument) {
              return EditInstrumentItem(
                instrument: instrument,
                isSelected: false,
                onListChanged: _handleInstrumentChanged,
              );
            }).toList()),
            AddInstrument(
              onSelectedInstrument: _addInstrument,
              availableInstruments: search.getAvailableInstruments(),
            ),
            Text(TextStrings.search_filter_distance_section_title),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Semantics(
                  label: 'Distance Filter',
                  child: SizedBox(
                    width: 64,
                    height: 48,
                    child: TextField(
                      textAlign: TextAlign.center,
                      onSubmitted: (String value) {
                        final double newValue = double.tryParse(value);
                        if (newValue != null && newValue != _continuousValue) _handleDistance(newValue.clamp(0, 100));
                      },
                      keyboardType: TextInputType.number,
                      controller: TextEditingController(
                        text: _continuousValue.toStringAsFixed(0),
                      ),
                    ),
                  ),
                ),
                Slider.adaptive(
                  value: _continuousValue,
                  min: 0.0,
                  max: 100.0,
                  onChanged: (double value) => _handleDistance(value),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
