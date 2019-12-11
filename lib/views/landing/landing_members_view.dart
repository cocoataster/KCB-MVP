import 'package:flutter/material.dart';

class LandingMembersView extends StatefulWidget {
  LandingMembersView({Key key}) : super(key: key);

  @override
  _LandingMembersViewState createState() => _LandingMembersViewState();
}

class _LandingMembersViewState extends State<LandingMembersView> {
  List<String> elements = ['MEMBER: asdfasdfsa', 'MEMBER: asdfasfsafas', 'MEMBER: wqernsvadfasfa', 'MEMBER: asdfjasfjña'];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
      height: MediaQuery.of(context).size.height * 0.23,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: elements.length,
          itemBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.only(right: 15.0),
              width: MediaQuery.of(context).size.width * 0.50,
              child: InkWell(
                onTap: () => {},
                child: Text(elements[index]),
              ),
            );
          }),
    );
  }
}