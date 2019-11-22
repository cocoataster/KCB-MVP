import 'package:flutter/material.dart';

class AddInstrument extends StatelessWidget {
  final onTap;
  AddInstrument({this.onTap});
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: _pill(context),
    );
  }
}

Container _pill(context) {
  return Container(
    margin: EdgeInsets.only(right: 3.0, top: 3.0),
    decoration: _getPillBoxDecoration(context),
    child: Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 3.0, 16.0, 3.0),
      child: Icon(Icons.add, size: 18.0, color: Colors.blueGrey.shade400),
    ),
  );
}

BoxDecoration _getPillBoxDecoration(BuildContext context) {
 
  return BoxDecoration(
    borderRadius: BorderRadius.all(const Radius.circular(15.0)),
    border: Border.all(color: Colors.blueGrey.shade200),
    
    color: Colors.white,
  );
}
