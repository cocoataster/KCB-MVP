import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sounds_good/core/utils/enums.dart';
import 'package:sounds_good/core/utils/text_strings.dart';
import 'package:sounds_good/core/viewmodels/profile_viewmodel.dart';
import 'package:sounds_good/views/shared_resources/section_title.dart';

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
                SectionTitle(sectionTitle: TextStrings.profile_description_section_title),
                model.getMode == ProfileMode.Edit
                    ? _editModeWidget(model, context)
                    : _plainWidget(model),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _editModeWidget(model, context) {
    return TextFormField(
      maxLines: null,
      style: TextStyle(color: Colors.blueGrey.shade300),
      initialValue: model.profile.description,
      decoration: InputDecoration(
          hintText: TextStrings.profile_edit_description_hint,
          contentPadding: EdgeInsets.all(0),
          focusedBorder: UnderlineInputBorder(
              borderSide:
                  BorderSide(color: Theme.of(context).accentColor, width: 1.0)),
          border: InputBorder.none),
      onChanged: (String value) => model.updateDescription(description: value),
    );
  }

  Widget _plainWidget(model) {
    return Text(model.profile.description);
  }
}
