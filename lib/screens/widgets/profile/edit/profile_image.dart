import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:sounds_good/core/services/api.dart';
import 'package:sounds_good/core/viewmodels/profile_viewmodel.dart';

class EditProfileImage extends StatefulWidget {
  @override
  _EditProfileImageState createState() => _EditProfileImageState();
}

class _EditProfileImageState extends State<EditProfileImage> {
  ImageProvider<dynamic> _avatarImageProvider;
  bool _profileHasAvatar = false;

  @override

  // https://stackoverflow.com/questions/49835623/how-to-load-images-with-image-file

  initState() {
    if (Provider.of<ProfileViewModel>(context, listen: false).getAvatar !=
        null) {
      _avatarImageProvider =
          Provider.of<ProfileViewModel>(context, listen: false).getAvatar();
      _profileHasAvatar = true;
    } else {
      _avatarImageProvider = AssetImage('assets/images/avatarPlaceholder.png');
    }
    super.initState();
  }

  Future getImage() async {
    final imageSource = await showDialog<ImageSource>(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Select the image source"),
              actions: <Widget>[
                MaterialButton(
                  child: Text("Camera"),
                  onPressed: () => Navigator.pop(context, ImageSource.camera),
                ),
                MaterialButton(
                  child: Text("Gallery"),
                  onPressed: () => Navigator.pop(context, ImageSource.gallery),
                )
              ],
            ));

    if (imageSource != null) {
      final file = await ImagePicker.pickImage(source: imageSource);
      if (file != null) {
        setState(
          () {
            Provider.of<ProfileViewModel>(context, listen: false)
                .avatarToUpdate(imageFile: file);
            _avatarImageProvider = FileImage(file);
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileViewModel>(
      builder: (context, model, child) => Padding(
        padding: const EdgeInsets.only(top: 20.0, left: 10.0, right: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Card(
              color: Colors.white,
              elevation: 6.0,
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24.0),
              ),
              child: InkWell(
                onTap: () => getImage(),
                child: Container(
                  child: Stack(
                    alignment: AlignmentDirectional.center,
                    children: <Widget>[
                      Image(
                        image: _avatarImageProvider,
                        fit: BoxFit.fill,
                        width: MediaQuery.of(context).size.width - 68.0,
                        height: MediaQuery.of(context).size.width - 68.0,
                      ),
                      Container(
                        width: 200,
                        height: 130,
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.all(const Radius.circular(24.0)),
                          color: Colors.black38,
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(5.0),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.add_a_photo,
                                  color: _profileHasAvatar
                                      ? Colors.white54
                                      : Colors.blueGrey.shade100,
                                  size: 80.0,
                                ),
                                _profileHasAvatar
                                    ? Text(
                                        'Change your profile Image',
                                        style: TextStyle(
                                          color: Colors.white70,
                                        ),
                                      )
                                    : Text(
                                        'Add a profile Image',
                                        style: TextStyle(
                                          color: Colors.blueGrey.shade300,
                                        ),
                                      )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
