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
            child: _headerContent(),
          ),
        ],
      ),
    );
  }
}

Widget _headerContent() {
  return Consumer<ProfileViewModel>(
    builder: (context, model, child) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          model.profile.name,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w700,
          ),
        ),
        Text(
          model.profile.friendlyLocation,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    ),
  );
}