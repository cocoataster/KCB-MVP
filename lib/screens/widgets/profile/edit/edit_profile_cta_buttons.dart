import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sounds_good/core/utils/enums.dart';
import 'package:sounds_good/core/viewmodels/profile_viewmodel.dart';
import 'package:sounds_good/screens/widgets/profile/shared/profile_close_button.dart';

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
                width: MediaQuery.of(context).size.width - 50.0,
                child: RaisedButton(
                  onPressed: () {
                    model.updateInstrumentsList();
                    model.updateVideosList();
                    model.setMode(ProfileMode.Own);
                  },
                  color: Colors.red.shade400,
                  child: Text('Accept', style: TextStyle(fontSize: 18)),
                  shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(10.0),
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              SizedBox(
                width: MediaQuery.of(context).size.width - 50.0,
                child: ProfileCloseButton(
                    value: 'Cancel',
                    onPressed: () => model.setMode(ProfileMode.Own)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
