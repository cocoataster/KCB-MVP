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
  ScrollController _scrollController = ScrollController();
  int index = 0;

  @override
  void initState() {
    super.initState();

    LandingViewModel landingViewModel =
        Provider.of<LandingViewModel>(context, listen: false);
    landingViewModel.fetchLocals(index);

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent &&
          landingViewModel.localsRequest.hasMorePages()) {
        ++index;
        landingViewModel.fetchLocals(index);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LandingViewModel>(
      builder: (context, landingViewModel, child) => Scaffold(
        body: SafeArea(
          child: Stack(
            children: <Widget>[
              ListView.builder(
                  scrollDirection: Axis.horizontal,
                  controller: _scrollController,
                  itemCount: landingViewModel.locals.length,
                  itemBuilder: (BuildContext context, int index) {
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
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
