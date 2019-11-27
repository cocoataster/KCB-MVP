import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sounds_good/core/viewmodels/profile_viewmodel.dart';

class EditProfileHeader extends StatefulWidget {
  @override
  _EditProfileHeaderState createState() => _EditProfileHeaderState();
}

class _EditProfileHeaderState extends State<EditProfileHeader> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController friendlyLocationController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    var model = Provider.of<ProfileViewModel>(context);
    return Container(
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 9,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.blueGrey,
                  ),
                  maxLines: 1,
                  initialValue: model.profile.name,
                  decoration: InputDecoration(
                     contentPadding: EdgeInsets.only(bottom: 3.0),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context).accentColor,
                              width: 1.0)),
                      border: InputBorder.none),
                  //controller: nameController,
                  onChanged: (String value) =>
                      model.updateProfileName(name: value),
                ),
                TextFormField(
                  style: TextStyle(
                    color: Colors.blueGrey,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                  initialValue: model.profile.friendlyLocation,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(0),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context).accentColor,
                              width: 1.0)),
                      border: InputBorder.none),
                  onChanged: (String value) =>
                      model.updateProfileLocation(friendlyLocation: value),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
