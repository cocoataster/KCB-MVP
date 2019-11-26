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
            flex: 9, // 90%
            child: _headerContent(context),
          ),
        ],
      ),
    );
  }
}

Widget _headerContent(context) {
  var model = Provider.of<ProfileViewModel>(context);

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        model.profile.name,
        style: Theme.of(context).textTheme.headline,
      ),
      Text(
        model.profile.friendlyLocation,
        style: Theme.of(context).textTheme.display1,
      ),
    ],
  );
}
