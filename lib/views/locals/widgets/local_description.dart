import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sounds_good/core/viewmodels/local_viewmodel.dart';

class LocalDescription extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<LocalViewModel>(
      builder: (context, localViewModel, child) => Padding(
        padding: const EdgeInsets.only(top: 10.0, bottom: 30.0),
        child: Text(localViewModel.local.description),
      ),
    );
  }
}
