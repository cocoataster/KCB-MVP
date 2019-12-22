import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sounds_good/core/utils/colors.dart';
import 'package:sounds_good/core/utils/enums.dart';
import 'package:sounds_good/core/utils/text_strings.dart';
import 'package:sounds_good/core/viewmodels/search_viewmodel.dart';
import 'package:sounds_good/views/search/widgets/distance_filter.dart';
import 'package:sounds_good/views/search/widgets/instruments_filters.dart';
import 'package:sounds_good/views/search/widgets/search_filters_header.dart';
import 'package:sounds_good/views/shared_resources/full_width_button.dart';

class Filters extends StatelessWidget {
  const Filters({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<SearchViewModel>(
      builder: (context, search, child) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                FiltersHeader(),
                if (search.getType() == SearchType.Members) InstrumentsFilter(),
                Padding(
                  padding: EdgeInsets.only(bottom: 100),
                  child: DistanceFilter(),
                ),
                FullWidthButton(
                  value: TextStrings.search_filters_apply_filters_title,
                  color: AppColors.firstLevelCTAColor,
                  onPressed: () {
                    search.getType() == SearchType.Members 
                        ? search.updateProfileFilters()
                        : search.updateLocalFilters();
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
