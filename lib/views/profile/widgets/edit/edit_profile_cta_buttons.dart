import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sounds_good/core/utils/colors.dart';
import 'package:sounds_good/core/utils/enums.dart';
import 'package:sounds_good/core/utils/text_strings.dart';
import 'package:sounds_good/core/viewmodels/profile_viewmodel.dart';
import 'package:sounds_good/views/profile/widgets/shared/profile_close_button.dart';

class EditProfileCTAButtons extends StatelessWidget {
  const EditProfileCTAButtons({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileViewModel>(
      builder: (context, model, child) => Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              SizedBox(
                width: MediaQuery.of(context).size.width - 48.0,
                child: RaisedButton(
                  onPressed: () {
                    model.updateInstrumentsList();
                    model.updateVideosList();
                    model.updateAvatar();
                    model.setMode(ProfileMode.Own);
                    model.updateProfile();                    
                  },
                  color: AppColors.firstLevelCTAColor,
                  child: Text(
                    TextStrings.profile_edit_cta_buttons_ok_value,
                    style: TextStyle(fontSize: 18),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              SizedBox(
                width: MediaQuery.of(context).size.width - 48.0,
                child: ProfileCloseButton(
                    value: TextStrings.profile_edit_cta_buttons_ko_value,
                    onPressed: () => model.setMode(ProfileMode.Own)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
