import 'package:sounds_good/core/models/profile.dart';
import 'package:sounds_good/core/models/search_request.dart';
import 'package:sounds_good/core/models/search_response.dart';
import 'package:sounds_good/core/services/api.dart';
import 'package:sounds_good/core/utils/enums.dart';
import 'package:sounds_good/core/viewmodels/base_viewmodel.dart';

class SearchViewModel extends BaseViewModel {
  Api _api = Api();

  SearchRequest searchRequest = SearchRequest(
      name: "",
      instruments: List<String>(),
      maxDistance: 0.0,
      limit: 2,
      offset: 0);

  List<Profile> profiles = [];
  int limit = 2;
  int offset = 0;
  int total = 0;

  Future fetchProfiles() async {
    setState(ViewState.Busy);
    SearchResponse searchResponse = await _api.getSearchProfiles(searchRequest);
    profiles = searchResponse.items;
    offset = searchResponse.offset;
    setState(ViewState.Idle);
  }

  Future<List<Profile>> fetchPage(pageIndex) async {
    setState(ViewState.Busy);
    searchRequest.offset = pageIndex * limit;
    SearchResponse searchResponse = await _api.getSearchProfiles(searchRequest);
    profiles += searchResponse.items;
    ++offset;
    total = searchResponse.total;
    setState(ViewState.Idle);

    return searchResponse.items;
  }

  bool hasNextPage() {
    return offset < total;
  }
}
