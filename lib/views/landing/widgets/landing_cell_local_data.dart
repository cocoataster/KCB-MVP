import 'package:flutter/material.dart';

class LandingCellLocalData extends StatelessWidget {
  final String name;
  final String friendlyLocation;
  final String price;
  final String shortDescription;

  LandingCellLocalData(
      {this.name, this.friendlyLocation, this.price, this.shortDescription});
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
          LandingMemberDataFirstRow(name: name, price: price),
          LandingMemberDataSndRow(shortDescription: shortDescription),
        ],
      ),
    );
  }
}

class LandingMemberDataFirstRow extends StatelessWidget {
  final String name;
  final String price;

  LandingMemberDataFirstRow({this.name, this.price});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Expanded(
            flex: 8,
            child: Text(
              name,
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w700,
                color: Colors.black87,
              ),
              textAlign: TextAlign.start,
            ),
          ),
          Expanded(
            flex: 3,
            child: Text('$price €/h', style: TextStyle(fontSize: 10)),
          ),
        ],
      ),
    );
  }
}

class LandingMemberDataSndRow extends StatelessWidget {
  final String shortDescription;

  const LandingMemberDataSndRow({this.shortDescription});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 12,
            child: Text('$shortDescription'),
          )
        ],
      ),
    );
  }
}

/*
class CellMemberInstruments extends StatelessWidget {
  final List<String> instruments;

  CellMemberInstruments({this.instruments});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12.0, right: 12.0, bottom: 10.0),
      child: Wrap(
        children: <Widget>[
          if (instruments.length > 0)
            LandingInstrumentItem(instrument: instruments[0]),
          if (instruments.length > 1)
            LandingInstrumentItem(instrument: instruments[1]),
          if (instruments.length > 2) LandingInstrumentItem(instrument: '+'),
        ],
      ),
    );
  }
}

class LandingCellMemberFollowers extends StatelessWidget {
  final List<dynamic> followers;
  LandingCellMemberFollowers({this.followers});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 10.0, top: 3.0, bottom: 8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(const Radius.circular(15.0)),
        border: Border.all(color: Colors.blueGrey.shade200),
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
        child: Text('+${followers.length}', style: TextStyle(fontSize: 11)),
      ),
    );
  }
}*/
