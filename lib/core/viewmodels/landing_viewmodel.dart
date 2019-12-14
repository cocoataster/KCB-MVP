import 'package:sounds_good/core/models/local.dart';
import 'package:sounds_good/core/models/profile.dart';
import 'package:sounds_good/core/models/search_request.dart';
import 'package:sounds_good/core/models/search_response.dart';
import 'package:sounds_good/core/services/api.dart';
import 'package:sounds_good/core/utils/enums.dart';
import 'package:sounds_good/core/viewmodels/base_viewmodel.dart';

class LandingViewModel extends BaseViewModel {
  Api _api = Api();

  SearchRequest searchRequest = SearchRequest(
    name: "",
    instruments: List<String>(),
    maxDistance: 0.0,
    limit: 2,
    offset: 0,
  );

  SearchType type;
  List<dynamic> members = [];
  List<dynamic> locals = [];
  int limit = 2;
  int offset = 0;
  int total = 0;

  Future<List<Profile>> fetchMembers(pageIndex) async {
    type = SearchType.Members;
    setState(ViewState.Busy);
    searchRequest.offset = pageIndex * limit;
    SearchResponse searchResponse =
        await _api.getSearchItems(searchRequest, type);

    members += searchResponse.items;
    ++offset;
    total = searchResponse.total;
    setState(ViewState.Idle);

    return searchResponse.items;
  }

  Future<List<Local>> fetchLocals(pageIndex) async {
    type = SearchType.Locals;
    setState(ViewState.Busy);
    searchRequest.offset = pageIndex * limit;
    SearchResponse localsResponse = await _api.getLocalsRequest();

    print('Locals: $localsResponse');
    locals += localsResponse.items;
    ++offset;
    total = localsResponse.total;
    setState(ViewState.Idle);

    return localsResponse.items;
  }

  void resetRequest(SearchType type) {
    searchRequest = SearchRequest(
        name: "",
        instruments: List<String>(),
        maxDistance: 0.0,
        limit: 2,
        offset: 0);
    //this.items = [];
    this.offset = 0;
    this.type = type;
  }
}
