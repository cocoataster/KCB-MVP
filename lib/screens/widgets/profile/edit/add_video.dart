import 'package:flutter/material.dart';

typedef void AddVideoCallback(String videoUrl);

class AddVideo extends StatelessWidget {
  final AddVideoCallback onVideoAdded;

  AddVideo({this.onVideoAdded});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8.0),
      child: InkWell(
        onTap: () => showDialog(
          context: context,
          builder: (BuildContext context) =>
              VideoDialog(onVideoAdded: onVideoAdded),
        ),
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
      ),
    );
  }
}

class VideoDialog extends StatefulWidget {
  final AddVideoCallback onVideoAdded;

  VideoDialog({Key key, this.onVideoAdded}) : super(key: key);

  @override
  _VideoDialogState createState() => _VideoDialogState();
}

class _VideoDialogState extends State<VideoDialog> {
  bool validate = false;
  String url;

  youtubeURL(String value) {
    Pattern pattern = r'^(https?\:\/\/)?((www\.)?youtube\.com|youtu\.?be)\/.+$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value)) {
      setState(() {
        validate = false;
      });
    } else {
      setState(() {
        validate = true;
      });
      url = value;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0)), //this right here
      child: Container(
        height: 200.0,
        width: 300.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
                padding: EdgeInsets.all(15.0),
                child: Text(
                  'Insert a valid YouTube URL',
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600),
                )),
            Padding(
              padding: EdgeInsets.all(15.0),
              child: Container(
                child: TextField(
                  style: TextStyle(
                    color: Colors.blueGrey,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                  decoration: InputDecoration(
                      prefixIcon:
                          validate ? Icon(Icons.check) : Icon(Icons.close),
                      hintText: 'https://www.youtube.com/watch?v=KzTeWPkUxQs',
                      border: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.blueAccent, width: 12.0),
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.white, width: 12.0),
                        borderRadius: BorderRadius.circular(15.0),
                      )),
                  onChanged: (String value) {
                    youtubeURL(value);
                    print(validate);
                  },
                ),
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 10.0)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(right: 10.0),
                  child: RaisedButton(
                    onPressed: () => Navigator.pop(context, true),
                    color: Colors.blueGrey.shade200,
                    child: const Text(
                      'Cancel',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                RaisedButton(
                  onPressed: () {
                    widget.onVideoAdded(url);
                    Navigator.pop(context, true);
                  },
                  color: Colors.red.shade400,
                  child: const Text(
                    'Accept',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
