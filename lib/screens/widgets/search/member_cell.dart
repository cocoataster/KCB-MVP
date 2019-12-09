import 'package:flutter/material.dart';
import 'package:sounds_good/screens/widgets/search/member_footer.dart';

class MemberCell extends StatelessWidget {
  final String imageUrl;

  MemberCell(this.imageUrl);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        splashColor: Colors.blueGrey.withAlpha(30),
        onTap: () {},
        child: Container(
          height: 300,
          child: Stack(
            children: <Widget>[
              Positioned.fill(child: Image.network(imageUrl)),
              Positioned(
                bottom: -4,
                left: -4,
                right: -4,
                child: MemberFooter(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
