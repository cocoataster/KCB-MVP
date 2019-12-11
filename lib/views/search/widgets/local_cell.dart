import 'package:flutter/material.dart';
import 'package:sounds_good/views/search/widgets/cell_local_data.dart';

class LocalCell extends StatelessWidget {
  final String imageUrl;
  final String name;
  final double price;
  final String description;

  LocalCell({this.imageUrl, this.name, this.price, this.description});

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
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.width - 20,
              ),
            ),
            Positioned(
                child: CellLocalData(
                  name: name,
                  price: price,
                  description: description,
                ),
                bottom: 0,
                left: 0,
                right: 0)
          ],
        ),
      ),
    );
  }
}
