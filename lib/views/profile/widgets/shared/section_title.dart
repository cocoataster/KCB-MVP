import 'package:flutter/material.dart';


class ProfileSectionTitle extends StatelessWidget {
  ProfileSectionTitle({this.sectionTitle}):super();
  final String sectionTitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: Row(
          children: <Widget>[
            Text(sectionTitle,
                style: Theme.of(context).textTheme.headline
                ),
          ],
        ));
  }
}
