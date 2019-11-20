import 'package:get_it/get_it.dart';
import 'core/services/api.dart';
import 'package:sounds_good/core/viewmodels/login_model.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => Api());

  locator.registerLazySingleton(() => LoginModel());
}
