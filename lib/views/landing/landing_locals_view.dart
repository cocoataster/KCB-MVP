import 'package:flutter/material.dart';

class LandingLocalsView extends StatefulWidget {
  LandingLocalsView({Key key}) : super(key: key);

  @override
  _LandingMembersViewState createState() => _LandingMembersViewState();
}

class _LandingMembersViewState extends State<LandingLocalsView> {
  List<String> elements = [
    'LOCAL: asdfasdfsa',
    'LOCAL: asdfasfsafas',
    'LOCAL: wqernsvadfasfa',
    'LOCAL: asdfjasfjña'
  ];

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
                child: Container(
                  height: 100,
                  width: 100,
                  child: Text(
                    elements[index],
                    style: TextStyle(fontSize: 30),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
