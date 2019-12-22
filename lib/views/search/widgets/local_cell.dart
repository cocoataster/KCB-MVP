import 'package:flutter/material.dart';
import 'package:sounds_good/views/locals/local_view.dart';
import 'package:sounds_good/views/search/widgets/cell_local_data.dart';

class LocalCell extends StatelessWidget {
  final String imageUrl;
  final String localId;
  final String name;
  final double price;
  final String shortDescription;

  LocalCell(
      {this.imageUrl, this.localId, this.name, this.price, this.shortDescription});

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
              builder: (context) => LocalView(localId: localId),
            ),
          );
        },
        child: Stack(
          children: <Widget>[
            Container(
              child: imageUrl.contains('http')
                  ? Image.network(
                      imageUrl,
                      fit: BoxFit.cover,
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.width - 20,
                    )
                  : Image.asset(
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
                  shortDescription: shortDescription,
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
