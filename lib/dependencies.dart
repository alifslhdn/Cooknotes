import 'package:cooknotes/services/rest_service.dart';
import 'package:cooknotes/services/user_data_service.dart';
import 'package:cooknotes/services/user_rest_service.dart';
import 'package:cooknotes/user_viewmodel.dart';
import 'package:get_it/get_it.dart';

final service = GetIt.instance;

void init() {
  service.registerLazySingleton(() => RestService());
  service.registerLazySingleton<UserDataService>(() => UserRestService());
  service.registerLazySingleton(() => UserViewmodel());
}
