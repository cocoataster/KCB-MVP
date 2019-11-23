import 'package:flutter/material.dart';

class AddVideo extends StatefulWidget {
  AddVideo({Key key}) : super(key: key);

  @override
  _AddVideoState createState() => _AddVideoState();
}

class _AddVideoState extends State<AddVideo> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8.0),
      child: GestureDetector(
        onTap: () => {print('Add a video')},
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.add_circle, size: 50, color: Colors.blueGrey.shade100),
              Padding(
                padding: EdgeInsets.only(top: 6.0),
                child: Text(
                  'Add a video',
                  style: TextStyle(
                    color: Colors.blueGrey.shade300,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(const Radius.circular(15.0)),
          border: Border.all(color: Colors.blueGrey.shade100, width: 3.0),
          color: Colors.white),
    );
  }
}
