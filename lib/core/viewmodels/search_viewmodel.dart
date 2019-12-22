import 'package:sounds_good/core/models/local.dart';
import 'package:sounds_good/core/models/profile.dart';
import 'package:sounds_good/core/models/search_request.dart';
import 'package:sounds_good/core/models/search_response.dart';
import 'package:sounds_good/core/services/api.dart';
import 'package:sounds_good/core/utils/enums.dart';
import 'package:sounds_good/core/viewmodels/base_viewmodel.dart';

class SearchViewModel extends BaseViewModel {
  Api _api = Api();

  SearchRequest profileSearchRequest =
      SearchRequest(name: "", instruments: [], limit: 2, offset: 0, total: 0);

  SearchRequest localSearchRequest =
      SearchRequest(name: "", limit: 2, offset: 0, total: 0);
  SearchType type;
  List<Profile> profiles = [];
  List<Local> locals = [];
  List<String> instrumentsToDisableFromPicker = [];

  void setType(SearchType searchType) {
    type = searchType;
    notifyListeners();
  }

  SearchType getType() => type;

  SearchRequest getReq() => profileSearchRequest;

  Future fetchMembersSearch(index) async {
    setState(ViewState.Busy);
    profileSearchRequest.offset = index * profileSearchRequest.limit;
    SearchResponse searchResponse =
        await _api.getSearchItems(profileSearchRequest, type);

    searchResponse.items.map((item) => profiles.add(item)).toList();

    profileSearchRequest.total = searchResponse.total;
    setState(ViewState.Idle);
  }

  Future fetchLocalsSearch(index) async {
    setState(ViewState.Busy);
    localSearchRequest.offset = index * localSearchRequest.limit;
    SearchResponse searchResponse =
        await _api.getSearchItems(localSearchRequest, type);

    searchResponse.items.map((item) => locals.add(item)).toList();

    localSearchRequest.total = searchResponse.total;
    setState(ViewState.Idle);
  }

  void updateName(String newName) {
    if (type == SearchType.Members) {
      resetProfileSearch();
      profileSearchRequest.name = newName;
    } else {
      resetLocalSearch();
      localSearchRequest.name = newName;
    }
  }

  void resetProfileSearch() {
    profileSearchRequest.name = "";
    profileSearchRequest.offset = 0;
    profileSearchRequest.total = 0;
    profileSearchRequest.instruments = [];
    profiles = [];
    fetchMembersSearch(0);
  }

  void resetLocalSearch() {
    localSearchRequest.name = "";
    localSearchRequest.offset = 0;
    localSearchRequest.total = 0;
    locals = [];
    fetchLocalsSearch(0);
  }

  void resetProfileInstruments(instruments) {
    profileSearchRequest.name = "";
    profileSearchRequest.offset = 0;
    profileSearchRequest.total = 0;
    profileSearchRequest.instruments = instruments;
    profiles = [];
    fetchMembersSearch(0);
  }

  void updateFilters() {
    profileSearchRequest.instruments.addAll(instrumentsFilterRequest);
    fetchMembersSearch(0);
  }

  // Instruments

  Set<String> disabledAvailableInstruments = {};
  List<String> availableInstruments = [];
  List<String> instrumentsFilterRequest = [];

  void initAvailableInstruments(List<String> instrumentsList) {
    availableInstruments.addAll(instrumentsList);
  }

  void addInstrument(instrument) {
    instrumentsFilterRequest.add(instrument);
    availableInstruments.remove(instrument);
    notifyListeners();
  }

  void removeInstrument(instrument) {
    instrumentsFilterRequest.remove(instrument);
    availableInstruments.add(instrument);
    notifyListeners();
  }

  // For avoid duplicates on Instruments Picker

  void enableAvailableInstrument(instrument) =>
      instrumentsToDisableFromPicker.remove(instrument);

  void disableAvailableInstrument(instrument) =>
      instrumentsToDisableFromPicker.add(instrument);

  List<String> getInstrumentsToDisableFromPicker() =>
      instrumentsToDisableFromPicker;

  List<String> getAvailableInstruments() => availableInstruments;
  List<String> getSelectedInstruments() => instrumentsFilterRequest;

  //

  // Distance

  double distanceFilter;

  void setDistanceFilter(double distance) => distanceFilter = distance;
}
