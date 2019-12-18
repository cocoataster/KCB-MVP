import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sounds_good/core/utils/text_strings.dart';
import 'package:sounds_good/core/utils/text_styles.dart';
import 'package:sounds_good/core/viewmodels/available_instruments_viewmodel.dart';
import 'package:sounds_good/core/viewmodels/search_viewmodel.dart';
import 'package:sounds_good/views/profile/widgets/edit/add_instrument.dart';
import 'package:sounds_good/views/profile/widgets/edit/instrument_item.dart';

class InstrumentsFilter extends StatefulWidget {
  @override
  _InstrumentsFilterState createState() => _InstrumentsFilterState();
}

class _InstrumentsFilterState extends State<InstrumentsFilter> {
  List<String> availableInstrumentsList = List<String>();

  void _addInstrument(String instrument) {
    setState(() {
      Provider.of<SearchViewModel>(context, listen: false)
          .addInstrument(instrument);
    });
    setState(() {
      availableInstrumentsList.remove(instrument);
    });
  }

  void _handleInstrumentChanged(String instrument, bool isSelected) {
    setState(() {
      Provider.of<SearchViewModel>(context, listen: false)
          .removeInstrument(instrument);
    });
    setState(() {
      availableInstrumentsList.add(instrument);
    });
  }

  @override
  void initState() {
    super.initState();
    availableInstrumentsList =
        Provider.of<AvailableInstrumentsViewModel>(context, listen: false)
            .getAvailableInstruments();

    print('Available instruments: $availableInstrumentsList');
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SearchViewModel>(
      builder: (context, search, child) => Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 20, bottom: 5),
              child: Text(
                TextStrings.search_filter_instruments_section_title,
                style: TextStyles.section_header_snd_level,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 5, bottom: 10),
              child: Wrap(
                children: search.getSelectedInstruments().map(
                  (instrument) {
                    return Padding(
                      padding: EdgeInsets.only(right: 10),
                      child: EditInstrumentItem(
                        instrument: instrument,
                        isSelected: false,
                        onListChanged: _handleInstrumentChanged,
                      ),
                    );
                  },
                ).toList(),
              ),
            ),
            AddInstrument(
              onSelectedInstrument: _addInstrument,
              availableInstruments: availableInstrumentsList,
            ),
          ],
        ),
      ),
    );
  }
}
