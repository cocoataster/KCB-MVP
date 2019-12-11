import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sounds_good/core/viewmodels/profile_viewmodel.dart';

class UserProfileHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 9,
            child: _headerContent(context),
          ),
        ],
      ),
    );
  }
}

Widget _headerContent(context) {
  var model = Provider.of<ProfileViewModel>(context);
  String name;
  String friendlyLocation;

  model.profile.name != null 
  ? name = model.profile.name
  : name = '';

  model.profile.friendlyLocation != null 
  ? friendlyLocation = model.profile.friendlyLocation
  : friendlyLocation = '';
  

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        name ,
        style: Theme.of(context).textTheme.headline,
      ),
      Text(
        friendlyLocation,
        style: Theme.of(context).textTheme.display1,
      ),
    ],
  );
}
