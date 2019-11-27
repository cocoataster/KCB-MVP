import 'package:sounds_good/core/models/instruments.dart';
import 'package:sounds_good/core/services/api.dart';
import 'package:sounds_good/core/utils/enums.dart';
import 'package:sounds_good/core/viewmodels/base_viewmodel.dart';

import '../../locator.dart';

class InstrumentsViewModel extends BaseViewModel {
  Api _api = locator<Api>();
  Instruments instruments;

  Future fetchInstruments() async {
    setState(ViewState.Busy);
    instruments = await _api.getInstruments();
    setState(ViewState.Idle);
  }

  String getInstrument(pos) => instruments.items[pos];
}
