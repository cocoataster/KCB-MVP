import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sounds_good/core/viewmodels/profile_viewmodel.dart';

class OwnProfileImage extends StatefulWidget {
  @override
  _OwnProfileImageState createState() => _OwnProfileImageState();
}

class _OwnProfileImageState extends State<OwnProfileImage> {
  ImageProvider<dynamic> _avatar;

  @override
  void initState() {
    setState(() {
      _avatar =
          Provider.of<ProfileViewModel>(context, listen: false).getAvatar();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0, left: 10.0, right: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Card(
            elevation: 6.0,
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24.0),
            ),
            child: Image(
              image: _avatar,
              fit: BoxFit.fill,
              width: MediaQuery.of(context).size.width - 68.0,
              height: MediaQuery.of(context).size.width - 88.0,
            ),
          ),
        ],
      ),
    );
  }
}
