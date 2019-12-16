import 'package:sounds_good/core/models/local.dart';
import 'package:sounds_good/core/services/api.dart';
import 'package:sounds_good/core/utils/enums.dart';
import 'package:sounds_good/core/viewmodels/base_viewmodel.dart';

class LocalViewModel extends BaseViewModel {
  Api _api = Api();
  Local local;

  Future fetchLocal(String id) async {
    setState(ViewState.Busy);
    local = await _api.getLocalWithId(id);
    setState(ViewState.Idle);
  }
}
