import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'dart:async';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:sounds_good/core/viewmodels/profile_viewmodel.dart';

class EditProfileImage extends StatefulWidget {
  @override
  _EditProfileImageState createState() => _EditProfileImageState();
}

class _EditProfileImageState extends State<EditProfileImage> {
  ImageProvider<dynamic> _avatarImageProvider;
  bool _profileHasAvatar = false;

  @override
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

  Future<void> cropImage({File pickedImage}) async {
    File croppedImage = await ImageCropper.cropImage(
        sourcePath: pickedImage.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
        ],
        androidUiSettings: AndroidUiSettings(
          toolbarTitle: 'Edit your image',
          toolbarColor: Colors.blueGrey,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.square,
          lockAspectRatio: false,
        ),
        iosUiSettings: IOSUiSettings(
          minimumAspectRatio: 1.0,
        ));

    setState(() {
      Provider.of<ProfileViewModel>(context, listen: false)
          .avatarToUpdate(imageFile: croppedImage);
      _avatarImageProvider = FileImage(croppedImage);
    });
  }

  Future getImage() async {
    final imageSource = await showDialog<ImageSource>(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Select the image source"),
              actions: <Widget>[
                RaisedButton.icon(
                  onPressed: () => Navigator.pop(context, ImageSource.camera),
                  color: Theme.of(context).accentColor,
                  icon: Icon(Icons.camera, color: Colors.white70),
                  label: const Text(
                    'Camera',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                RaisedButton.icon(
                  onPressed: () => Navigator.pop(context, ImageSource.gallery),
                  color: Theme.of(context).accentColor,
                  icon: Icon(Icons.collections, color: Colors.white70),
                  label: Text(
                    'Gallery',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ],
            ));

    if (imageSource != null) {
      final file = await ImagePicker.pickImage(source: imageSource);
      if (file != null) {
        cropImage(pickedImage: file);
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
                        height: MediaQuery.of(context).size.width - 88.0,
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
                                      ),
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
