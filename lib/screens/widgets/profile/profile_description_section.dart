import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sounds_good/core/utils/enums.dart';
import 'package:sounds_good/core/viewmodels/profile_viewmodel.dart';
import 'package:sounds_good/screens/widgets/profile/shared/section_title.dart';

class ProfileDescriptionSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileViewModel>(
      builder: (context, model, child) => Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 10.0, bottom: 30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ProfileSectionTitle(sectionTitle: 'About me'),
                model.getMode == ProfileMode.Edit
                    ? _editModeWidget(model)
                    : _plainWidget(model),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _editModeWidget(model) {
    return TextField(
      maxLines: null,
      decoration: InputDecoration.collapsed(
        hintText: model.profile.description,
      ),
      onChanged: (String value) => model.updateDescription(description: value),
    );
  }

  Widget _plainWidget(model) {
    return Text(model.profile.description);
  }
}
