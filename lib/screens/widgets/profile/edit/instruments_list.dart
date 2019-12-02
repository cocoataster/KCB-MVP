import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sounds_good/core/viewmodels/profile_viewmodel.dart';
import 'package:sounds_good/screens/widgets/profile/edit/add_instrument.dart';
import 'package:sounds_good/screens/widgets/profile/edit/instrument_item.dart';

class EditInstrumentsList extends StatefulWidget {
  EditInstrumentsList({Key key}) : super(key: key);

  @override
  _EditInstrumentsListState createState() => _EditInstrumentsListState();
}

class _EditInstrumentsListState extends State<EditInstrumentsList> {
  Set<String> _instrumentsSelected = Set<String>();

  void _handleInstrumentChanged(String instrument, bool isSelected) {
    setState(() {
      isSelected
          ? _instrumentsSelected.remove(instrument)
          : _instrumentsSelected.add(instrument);
    });
    Provider.of<ProfileViewModel>(context, listen: false)
        .instrumentsToRemove(instrumentsSelected: _instrumentsSelected);
  }

  void _addInstrument(String newInstrument) {
    Provider.of<ProfileViewModel>(context, listen: false)
        .addInstrument(instrument: newInstrument);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileViewModel>(
      builder: (context, data, child) {
        print('Instruments Edit: ${data.profile.instruments}');
        List<Widget> _instrumentsWidgetsList =
            data.profile.instruments.map((String instrument) {
          return EditInstrumentItem(
            instrument: instrument,
            isSelected: _instrumentsSelected.contains(instrument),
            onListChanged: _handleInstrumentChanged,
          );
        }).toList();

        List<Widget> _editableInstrumentsList = [
          AddInstrument(onSelectedInstrument: _addInstrument),
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
