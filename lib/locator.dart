import 'package:get_it/get_it.dart';
import 'package:sounds_good/core/viewmodels/profile_viewmodel.dart';
import 'package:sounds_good/core/viewmodels/login_viewmodel.dart';
import 'package:sounds_good/core/viewmodels/signin_viewmodel.dart';
import 'core/services/api.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => Api());
  locator.registerLazySingleton(() => LoginViewModel());
  locator.registerLazySingleton(() => SigninViewModel());
  locator.registerLazySingleton(() => ProfileViewModel());
}
