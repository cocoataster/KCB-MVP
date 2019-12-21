import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sounds_good/core/viewmodels/available_instruments_viewmodel.dart';
import 'package:sounds_good/core/viewmodels/profile_viewmodel.dart';
import 'package:sounds_good/views/profile/widgets/edit/add_instrument.dart';
import 'package:sounds_good/views/profile/widgets/edit/instrument_item.dart';

class EditInstrumentsList extends StatefulWidget {
  EditInstrumentsList({Key key}) : super(key: key);

  @override
  _EditInstrumentsListState createState() => _EditInstrumentsListState();
}

class _EditInstrumentsListState extends State<EditInstrumentsList> {
  Set<String> _instrumentsSelected = Set<String>();
  List<String> availableInstrumentsList = List<String>();

  void _handleInstrumentChanged(String instrument, bool isSelected) {
    setState(() {
      isSelected
          ? _instrumentsSelected.remove(instrument)
          : _instrumentsSelected.add(instrument);
    });
    Provider.of<ProfileViewModel>(context, listen: false)
        .instrumentsToRemove(instrumentsSelected: _instrumentsSelected);
    Provider.of<AvailableInstrumentsViewModel>(context, listen: false)
        .instrumentsToDisable(_instrumentsSelected);
  }

  void _addInstrument(String newInstrument) {
    Provider.of<ProfileViewModel>(context, listen: false)
        .addInstrument(instrument: newInstrument);
    Provider.of<AvailableInstrumentsViewModel>(context, listen: false)
        .disableAvailableInstrument(newInstrument);
  }

  @override
  void initState() {
    List<String> instrumentsOnProfile =
        Provider.of<ProfileViewModel>(context, listen: false)
            .getInstrumentsOnProfile();

    Provider.of<AvailableInstrumentsViewModel>(context, listen: false)
        .disableInstrumentsFromProfile(instrumentsOnProfile);

    availableInstrumentsList =
        Provider.of<AvailableInstrumentsViewModel>(context, listen: false)
            .getAvailableInstruments();
    super.initState();

    print('Instruments on Profile: $instrumentsOnProfile');
    print('Available instruments: $availableInstrumentsList');
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileViewModel>(
      builder: (context, data, child) {
        List<Widget> _instrumentsWidgetsList =
            data.profile.instruments.map((String instrument) {
          return EditInstrumentItem(
            instrument: instrument,
            isSelected: _instrumentsSelected.contains(instrument),
            onListChanged: _handleInstrumentChanged,
          );
        }).toList();

        List<Widget> _editableInstrumentsList = [
          AddInstrument(
            onSelectedInstrument: _addInstrument,
          ),
        ];

        _editableInstrumentsList.addAll(_instrumentsWidgetsList);

        return Wrap(
          spacing: 8.0,
          runSpacing: 4.0,
          children: _editableInstrumentsList,
        );
      },
    );
  }
}
