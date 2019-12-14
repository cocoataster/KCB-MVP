import 'package:flutter/material.dart';
import 'package:sounds_good/core/models/contact_method.dart';
import 'package:sounds_good/views/landing/widgets/landing_cell_local_data.dart';
import 'package:sounds_good/views/profile/profile_view.dart';

class LandingLocalCell extends StatelessWidget {
  final String id;
  final List<String> photos;
  final String name;
  final String friendlyLocation;
  final String price;
  final ContactMethod contactMethod;
  final String description; 

  LandingLocalCell(
      {this.id,
      this.photos,
      this.name,
      this.friendlyLocation,
      this.price,
      this.contactMethod,
      this.description});

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
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ProfileView(id)),
          );
        },
        child: Stack(
          children: <Widget>[
            Container(
              child: Image.network(photos[0],
                  fit: BoxFit.cover,
                  width: (MediaQuery.of(context).size.height - 200) / 2),
            ),
            Positioned(
                child: LandingCellLocalData(
                    name: name,
                    friendlyLocation: friendlyLocation,
                    price: price,
                    description: description),
                bottom: 0,
                left: 0,
                right: 0)
          ],
        ),
      ),
    );
  }
}
