import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sounds_good/core/utils/colors.dart';
import 'package:sounds_good/core/viewmodels/search_viewmodel.dart';
import 'package:sounds_good/views/search/widgets/distance_filter.dart';
import 'package:sounds_good/views/search/widgets/instruments_filters.dart';
import 'package:sounds_good/views/search/widgets/search_filters_header.dart';
import 'package:sounds_good/views/shared_resources/full_width_button.dart';

class Filters extends StatelessWidget {
  const Filters({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SearchViewModel>(
      builder: (context) => SearchViewModel(),
      child: Consumer<SearchViewModel>(
        builder: (context, search, child) => Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              FiltersHeader(),
              InstrumentsFilter(),
              Padding(
                padding: EdgeInsets.only(bottom: 100),
                child: DistanceFilter(),
              ),
              FullWidthButton(
                value: 'Apply Filters',
                color: AppColors.firstLevelCTAColor,
                onPressed: () => Navigator.pop(context) ,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
