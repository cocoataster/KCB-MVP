import 'package:flutter/material.dart';
import 'package:sounds_good/views/search/sections/filters.dart';

class FiltersButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 45.0,
      height: 45.0,
      child: FloatingActionButton(
        backgroundColor: Colors.white,
        elevation: 4,
        shape: CircleBorder(),
        child: Icon(Icons.format_list_bulleted, color: Colors.black),
        onPressed: () => _settingModalBottomSheet(context),
      ),
    );
  }
}

void _settingModalBottomSheet(context) {
  showBottomSheet(
    context: context,
    builder: (context) {
      return Container(
        height: MediaQuery.of(context).size.height -150,
        width: MediaQuery.of(context).size.width,
        color: Colors.transparent,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(20.0),
              topRight: const Radius.circular(20.0),
            ),
          ),
          child: Filters(),
        ),
      );
    },
  );
}
