import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sounds_good/core/services/api.dart';
import 'package:sounds_good/core/viewmodels/local_viewmodel.dart';

class LocalPhotos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
      height: MediaQuery.of(context).size.height * 0.4,
      child: Consumer<LocalViewModel>(
        builder: (context, localViewModel, child) => ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: localViewModel.local.photos.length,
          itemBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.only(right: 5.0),
              child: ClipRRect(
                borderRadius: new BorderRadius.circular(22.0),
                child: Image.network(
                  '${Api.endpoint}/${localViewModel.local.photos[index]}',
                  fit: BoxFit.fill,
                  width: MediaQuery.of(context).size.height * 0.4,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
