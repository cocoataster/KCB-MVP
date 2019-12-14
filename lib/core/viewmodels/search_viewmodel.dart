import 'package:sounds_good/core/models/local.dart';
import 'package:sounds_good/core/models/profile.dart';
import 'package:sounds_good/core/models/search_request.dart';
import 'package:sounds_good/core/models/search_response.dart';
import 'package:sounds_good/core/services/api.dart';
import 'package:sounds_good/core/utils/enums.dart';
import 'package:sounds_good/core/viewmodels/base_viewmodel.dart';

class SearchViewModel extends BaseViewModel {
  Api _api = Api();

  SearchRequest profileSearchRequest = SearchRequest(
    name: "",
    instruments: List<String>(),
    maxDistance: 0.0,
    limit: 2,
    offset: 0,
  );

  SearchRequest localSearchRequest =
      SearchRequest(name: "", limit: 2, offset: 0);

  SearchType type;

  List<Profile> profiles = [];
  List<Local> locals = [];

  Future<List<Profile>> fetchProfilePage(pageIndex) async {
    setState(ViewState.Busy);
    profileSearchRequest.offset = pageIndex * profileSearchRequest.limit;
    SearchResponse searchResponse =
        await _api.getSearchItems(profileSearchRequest, SearchType.Members);

    profiles += searchResponse.items;
    ++profileSearchRequest.offset;
    profileSearchRequest.total = searchResponse.total;
    setState(ViewState.Idle);

    return searchResponse.items;
  }

  Future<List<Local>> fetchLocalPage(pageIndex) async {
    setState(ViewState.Busy);
    localSearchRequest.offset = pageIndex * localSearchRequest.limit;
    SearchResponse searchResponse =
        await _api.getSearchItems(localSearchRequest, SearchType.Locals);
    locals += searchResponse.items;
    ++localSearchRequest.offset;
    localSearchRequest.total = searchResponse.total;
    setState(ViewState.Idle);

    return searchResponse.items;
  }

  void setType(SearchType searchType) {
    type = searchType;
    notifyListeners();
  }
}
