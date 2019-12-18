import 'package:flutter/material.dart';
import 'package:sounds_good/core/utils/text_styles.dart';
import 'package:sounds_good/views/shared_resources/instrument_pill.dart';

class CellMemberData extends StatelessWidget {
  final String name;
  final String friendlyLocation;
  final List<String> instruments;
  final List<dynamic> followers;

  CellMemberData(
      {this.name, this.friendlyLocation, this.instruments, this.followers});
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
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 10,
                  child: MemberName(name: name),
                ),
                Expanded(
                    flex: 8,
                    child: MemberLocation(friendlyLocation: friendlyLocation)),
              ],
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 12.0, right: 12.0, bottom: 10.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 8,
                  child: CellMemberInstruments(instruments: instruments),
                ),
                CellMemberFollowers(followers: followers),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MemberName extends StatelessWidget {
  final String name;
  MemberName({this.name});

  @override
  Widget build(BuildContext context) {
    return Text(
      name,
      style: TextStyles.section_header,
      textAlign: TextAlign.start,
    );
  }
}

class MemberLocation extends StatelessWidget {
  final String friendlyLocation;
  const MemberLocation({this.friendlyLocation});

  @override
  Widget build(BuildContext context) {
    return Text(friendlyLocation,
        style: TextStyles.section_subHeader,
        textAlign: TextAlign.right);
  }
}

class CellMemberInstruments extends StatelessWidget {
  final List<String> instruments;

  CellMemberInstruments({this.instruments});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: <Widget>[
        if (instruments.length > 0) InstrumentPill(instrumentName: instruments[0], editable: false),
        if (instruments.length > 1) InstrumentPill(instrumentName: instruments[1], editable: false),
        if (instruments.length > 2) InstrumentPill(instrumentName: '+', editable: false),
      ],
    );
  }
}

class CellMemberFollowers extends StatelessWidget {
  final List<dynamic> followers;
  CellMemberFollowers({this.followers});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 3.0, top: 3.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(const Radius.circular(15.0)),
        border: Border.all(color: Colors.blueGrey.shade200),
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16.0, 3.0, 16.0, 3.0),
        child: Text('+${followers.length}'),
      ),
    );
  }
}
