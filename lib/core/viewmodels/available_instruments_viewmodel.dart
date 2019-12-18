import 'package:sounds_good/core/models/instruments.dart';
import 'package:sounds_good/core/services/api.dart';
import 'package:sounds_good/core/utils/enums.dart';
import 'package:sounds_good/core/viewmodels/base_viewmodel.dart';

class AvailableInstrumentsViewModel extends BaseViewModel {
  Api _api = Api();
  Instruments availableInstruments;
  Set<String> _instrumentsToDisable = {};

  Future fetchAvailableInstruments() async {
    setState(ViewState.Busy);
    availableInstruments = await _api.getInstruments();
    setState(ViewState.Idle);
  }

  ///
  //  Avoid instrument duplicates by selecting them again on the picker.
  ///

  List<String> getAvailableInstruments() {
    List<String> finalList = [];
    availableInstruments.items.map((instrument) {
      if (!_instrumentsToDisable.contains(instrument)) {
        finalList.add(instrument);
      }
    }).toList();

    return finalList;
  }

  void disableInstrumentsFromProfile(instrumentsOnProfile) =>
      instrumentsOnProfile
          .map((instrument) => disableAvailableInstrument(instrument))
          .toList();

  void enableAvailableInstrument(instrument) =>
      _instrumentsToDisable.remove(instrument);

  void disableAvailableInstrument(instrument) =>
      _instrumentsToDisable.add(instrument);

  void instrumentsToDisable(instrumentsList) => availableInstruments.items
      .map((instrument) => disableAvailableInstrument(instrument))
      .toList();
}
