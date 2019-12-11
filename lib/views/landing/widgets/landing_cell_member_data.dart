import 'package:flutter/material.dart';
import 'package:sounds_good/views/profile/widgets/shared/instrument_item.dart';

class LandingCellMemberData extends StatelessWidget {
  final String name;
  final String friendlyLocation;
  final List<String> instruments;

  LandingCellMemberData({this.name, this.friendlyLocation, this.instruments});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          LandingMemberData(
              name: name, friendlyLocation: friendlyLocation),
          CellMemberInstruments(instruments: instruments),
        ],
      ),
    );
  }
}

class LandingMemberData extends StatelessWidget {
  final String name;
  final String friendlyLocation;

  LandingMemberData({this.name, this.friendlyLocation});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 9,
            child: Text(
              name,
              style: Theme.of(context).textTheme.headline,
              textAlign: TextAlign.start,
            ),
          ),
          Expanded(
            flex: 9,
            child: Text(
              friendlyLocation,
              style: Theme.of(context).textTheme.display1,
              textAlign: TextAlign.right
            ),
          ),
        ],
      ),
    );
  }
}

class CellMemberInstruments extends StatelessWidget {
  final List<String> instruments;

  CellMemberInstruments({this.instruments});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12.0, right: 12.0, bottom: 10.0),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 8,
            child: Wrap(
              children: instruments
                  .map((instrument) => InstrumentItem(instrument: instrument))
                  .toList(),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text('+'),
          ),
        ],
      ),
    );
  }
}
