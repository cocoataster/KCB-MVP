import 'package:flutter/material.dart';
import 'package:sounds_good/screens/widgets/search/member_footer.dart';

class MemberCell extends StatelessWidget {
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
              Positioned.fill(
                  child: Container(
                color: Colors.teal,
              )),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: MemberFooter(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
