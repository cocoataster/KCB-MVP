import 'package:sounds_good/core/models/local.dart';
import 'package:sounds_good/core/models/my_band.dart';
import 'package:sounds_good/core/models/profile.dart';
import 'package:sounds_good/core/models/search_request.dart';
import 'package:sounds_good/core/models/search_response.dart';
import 'package:sounds_good/core/services/api.dart';
import 'package:sounds_good/core/utils/enums.dart';
import 'package:sounds_good/core/viewmodels/base_viewmodel.dart';

class LandingViewModel extends BaseViewModel {
  Api _api = Api();

  SearchRequest profilesRequest = SearchRequest(limit: 2, offset: 0, total: 0);

  SearchRequest localsRequest = SearchRequest(limit: 2, offset: 0, total: 0);

  List<Profile> members = [];
  List<Local> locals = [];

  fetchBand(pageIndex) async {
    setState(ViewState.Busy);
    profilesRequest.offset = pageIndex * profilesRequest.limit;
    MyBand myBand =
        await _api.getMyBand(profilesRequest.limit, profilesRequest.offset);

    myBand.profiles.map((profile) => members.add(profile)).toList();

    profilesRequest.total = myBand.total;
    setState(ViewState.Idle);
  }
  
  fetchLocals(pageIndex) async {
    setState(ViewState.Busy);
    localsRequest.offset = pageIndex * localsRequest.limit;
    SearchResponse localsResponse =
        await _api.getSearchItems(localsRequest, SearchType.Locals);

    localsResponse.items.map((item) => locals.add(item)).toList();

    localsRequest.total = localsResponse.total;
    setState(ViewState.Idle);
  }
}
