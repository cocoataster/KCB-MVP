import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sounds_good/core/utils/text_strings.dart';
import 'package:sounds_good/core/utils/text_styles.dart';
import 'package:sounds_good/core/viewmodels/search_viewmodel.dart';

class DistanceFilter extends StatefulWidget {
  @override
  _DistanceFilterState createState() => _DistanceFilterState();
}

class _DistanceFilterState extends State<DistanceFilter> {
  double _continuousValue = 5.0;

  void _handleDistance(double value) {
    setState(() {
      _continuousValue = value;
      Provider.of<SearchViewModel>(context, listen: false)
          .setDistanceFilter(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 20),
          child: Text(
            TextStrings.search_filter_distance_section_title,
            style: TextStyles.section_header_snd_level,
          ),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              children: <Widget>[
                Semantics(
                  label: TextStrings.search_filters_distance_filter_title,
                  child: Container(
                    width: 50,
                    height: 48,
                    child: TextField(
                      decoration: InputDecoration(border: InputBorder.none),
                      textAlign: TextAlign.center,
                      style: TextStyles.section_header,
                      onSubmitted: (String value) {
                        final double newValue = double.tryParse(value);
                        if (newValue != null && newValue != _continuousValue)
                          _handleDistance(newValue.clamp(0, 100));
                      },
                      keyboardType: TextInputType.number,
                      controller: TextEditingController(
                        text: _continuousValue.toStringAsFixed(0),
                      ),
                    ),
                  ),
                ),
                Text(
                  'Km',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w400,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
            Slider.adaptive(
              value: _continuousValue,
              min: 0.0,
              max: 2500.0,
              onChanged: (double value) => _handleDistance(value),
            ),
          ],
        )
      ],
    );
  }
}
