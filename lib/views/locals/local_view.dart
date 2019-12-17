import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sounds_good/core/utils/enums.dart';
import 'package:sounds_good/core/utils/text_strings.dart';
import 'package:sounds_good/core/viewmodels/local_viewmodel.dart';
import 'package:sounds_good/views/locals/local_sections.dart/local_header.dart';
import 'package:sounds_good/views/locals/widgets/local_cta_button.dart';
import 'package:sounds_good/views/locals/widgets/local_description.dart';
import 'package:sounds_good/views/locals/widgets/local_location_map.dart';
import 'package:sounds_good/views/locals/widgets/local_photos.dart';
import 'package:sounds_good/views/shared_resources/section_title.dart';

class LocalView extends StatefulWidget {
  final String localId;

  LocalView({this.localId});

  @override
  _LocalViewState createState() => _LocalViewState();
}

class _LocalViewState extends State<LocalView> {
  LocalViewModel localViewModel = LocalViewModel();

  @override
  void initState() {
    localViewModel.fetchLocal(widget.localId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LocalViewModel>(
      builder: (context) => localViewModel,
      child: Consumer<LocalViewModel>(
        builder: (context, localViewModel, child) => Scaffold(
          body: localViewModel.state == ViewState.Idle
              ? SafeArea(
                  child: Container(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            LocalHeader(),
                            LocalLocationMap(),
                            LocalCTAButton(),
                            SectionTitle(
                                sectionTitle:
                                    TextStrings.locals_about_us_section_title),
                            LocalDescription(),
                            LocalPhotos(),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              : Center(
                  child: CircularProgressIndicator(),
                ),
        ),
      ),
    );
  }
}


