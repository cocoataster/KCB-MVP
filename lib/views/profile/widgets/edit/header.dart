import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sounds_good/core/utils/colors.dart';
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
  void initState() {
    Provider.of<ProfileViewModel>(context, listen: false).fetchProfile();
    super.initState();
  }

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
                      hintText: 'Enter your name',
                      contentPadding: EdgeInsets.only(bottom: 3.0),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: AppColors.firstLevelCTAColor, width: 2.0)),
                      border: InputBorder.none),
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
                      hintText: 'Where do you live?',
                      contentPadding: EdgeInsets.all(0),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: AppColors.firstLevelCTAColor,
                          width: 2.0,
                        ),
                      ),
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
