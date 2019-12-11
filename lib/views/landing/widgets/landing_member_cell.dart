import 'package:flutter/material.dart';
import 'package:sounds_good/views/landing/widgets/landing_cell_member_data.dart';

class LandingMemberCell extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String friendlyLocation;
  final List<String> instruments;

  LandingMemberCell({this.imageUrl, this.name, this.friendlyLocation, this.instruments});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 6.0,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24.0),
      ),
      child: InkWell(
        splashColor: Colors.blueGrey.withAlpha(30),
        onTap: () {},
        child: Stack(
          children: <Widget>[
            Container(
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
                width: (MediaQuery.of(context).size.height - 140) / 2
              ),
            ),
            Positioned(child: LandingCellMemberData(name: name, friendlyLocation: friendlyLocation, instruments: instruments ), bottom: 0, left: 0, right: 0)
          ],
        ),
      ),
    );
  }
}
