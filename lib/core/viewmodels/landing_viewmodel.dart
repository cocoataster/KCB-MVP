import 'package:sounds_good/core/models/local.dart';
import 'package:sounds_good/core/models/profile.dart';
import 'package:sounds_good/core/models/search_request.dart';
import 'package:sounds_good/core/models/search_response.dart';
import 'package:sounds_good/core/services/api.dart';
import 'package:sounds_good/core/utils/enums.dart';
import 'package:sounds_good/core/viewmodels/base_viewmodel.dart';

class LandingViewModel extends BaseViewModel {
  Api _api = Api();

  SearchRequest profilesRequest = SearchRequest(
    name: "",
    instruments: List<String>(),
    maxDistance: 0.0,
    limit: 2,
    offset: 0,
  );

  SearchRequest localsRequest = SearchRequest(name: "", limit: 2, offset: 0);

  List<Profile> members = [];
  List<Local> locals = [];

  Future<List<Profile>> fetchMembers(pageIndex) async {
    setState(ViewState.Busy);
    profilesRequest.offset = pageIndex * profilesRequest.limit;
    SearchResponse searchResponse =
        await _api.getSearchItems(profilesRequest, SearchType.Members);

    members += searchResponse.items;
    ++profilesRequest.offset;
    profilesRequest.total = searchResponse.total;
    setState(ViewState.Idle);

    return searchResponse.items;
  }

  Future<List<Local>> fetchLocals(pageIndex) async {
    setState(ViewState.Busy);
    localsRequest.offset = pageIndex * localsRequest.limit;
    SearchResponse localsResponse =
        await _api.getSearchItems(localsRequest, SearchType.Locals);

    locals += localsResponse.items;
    ++localsRequest.offset;
    localsRequest.total = localsResponse.total;
    setState(ViewState.Idle);

    return localsResponse.items;
  }

}
