import 'package:flutter/material.dart';
import 'package:flutter_pagewise/flutter_pagewise.dart';
import 'package:provider/provider.dart';
import 'package:sounds_good/core/services/api.dart';
import 'package:sounds_good/core/utils/enums.dart';
import 'package:sounds_good/core/viewmodels/landing_viewmodel.dart';
import 'package:sounds_good/views/landing/widgets/landing_local_cell.dart';

class LandingLocalsView extends StatefulWidget {
  LandingLocalsView({Key key}) : super(key: key);

  @override
  _LandingLocalsViewState createState() => _LandingLocalsViewState();
}

class _LandingLocalsViewState extends State<LandingLocalsView> {
  @override
  Widget build(BuildContext context) {
    return Consumer<LandingViewModel>(
      builder: (context, landingViewModel, child) => Scaffold(
        body: landingViewModel.state == ViewState.Idle
            ? SafeArea(
                child: Stack(
                  children: <Widget>[
                    PagewiseListView(
                        scrollDirection: Axis.horizontal,
                        pageSize: landingViewModel.localsRequest.limit,
                        padding: EdgeInsets.fromLTRB(12.0, 3.0, 12.0, 6.0),
                        itemBuilder: (context, entry, index) {
                          var placeholder = 'https://picsum.photos/250?image=9';
                          var local = landingViewModel.locals[index];

                          List<String> localPhotosURLs = [];
                          local.photos.first != ""
                              ? localPhotosURLs
                                  .add('${Api.endpoint}/${local.photos.first}')
                              : localPhotosURLs.add(placeholder);

                          return LandingLocalCell(
                              photos: localPhotosURLs,
                              id: local.id,
                              name: local.name,
                              friendlyLocation: "",
                              price: local.price.toStringAsFixed(2),
                              contactMethod: local.contactMethod,
                              description: local.description);
                        },
                        pageFuture: (pageIndex) {
                          return landingViewModel.fetchLocals(pageIndex);
                        }),
                  ],
                ),
              )
            : Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }
}
