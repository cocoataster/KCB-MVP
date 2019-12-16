import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sounds_good/core/viewmodels/local_viewmodel.dart';

class LocalLocationMap extends StatelessWidget {
  final Completer<GoogleMapController> _controller = Completer();

  @override
  Widget build(BuildContext context) {
    return Consumer<LocalViewModel>(
      builder: (context, localViewModel, child) => Container(
        margin: EdgeInsets.only(top: 20),
        height: 250,
        child: ClipRRect(
          borderRadius: new BorderRadius.circular(22.0),
          child: GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: CameraPosition(
              target: LatLng(localViewModel.local.location.lat,
                  localViewModel.local.location.long),
              zoom: 16.4746,
            ),
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
          ),
        ),
      ),
    );
  }
}