import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sounds_good/core/utils/text_styles.dart';
import 'package:sounds_good/core/viewmodels/profile_viewmodel.dart';

class MemberProfileHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileViewModel>(
      builder: (build, viewModel, child) => Container(
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 9,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    viewModel.profile.name,
                    style: TextStyles.section_header,
                  ),
                  Text(
                    viewModel.profile.friendlyLocation,
                    style: TextStyles.section_subHeader,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
