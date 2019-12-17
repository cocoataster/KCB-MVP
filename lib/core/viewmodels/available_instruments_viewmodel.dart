import 'package:sounds_good/core/models/instruments.dart';
import 'package:sounds_good/core/services/api.dart';
import 'package:sounds_good/core/utils/enums.dart';
import 'package:sounds_good/core/viewmodels/base_viewmodel.dart';

class AvailableInstrumentsViewModel extends BaseViewModel {
  
  Api _api = Api();
  Set<String> instrumentsToRemoveList = {};
  Instruments availableInstruments;
  Set<String> disabledAvailableInstruments = {};
  List<String> instrumentsList = [];

  List<String> getAvailableInstruments() {
    List<String> finalList = [];
    availableInstruments.items.map((instrument) {
      if (!disabledAvailableInstruments.contains(instrument)) {
        finalList.add(instrument);
      }
    }).toList();

    return finalList;
  }

  Future fetchAvailableInstruments() async {
    setState(ViewState.Busy);
    availableInstruments = await _api.getInstruments();
    setState(ViewState.Idle);
  }
/*
  void disableInstrementsSelectedOnProfile() {
    profile.instruments.map((instrument) {
      disableAvailableInstrument(instrument);
    }).toList();
  }*/

  void enableAvailableInstrument(instrument) =>
      disabledAvailableInstruments.remove(instrument);

  void disableAvailableInstrument(instrument) {
    disabledAvailableInstruments.add(instrument);
  }

  Set<String> getDisabledInstruments() => disabledAvailableInstruments;
}
