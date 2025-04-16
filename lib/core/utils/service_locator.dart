import 'package:get_it/get_it.dart';
import 'package:live_order_tracking/core/utils/storage_service.dart';

GetIt sl = GetIt.instance;

void setupServiceLocator() {
  //Storage Helper

  sl.registerLazySingleton(() => StorageHelper());

  // Repos
  // sl.registerLazySingleton(() => AuthRepo(sl<DioHelper>()));
  // sl.registerLazySingleton(() => HomeRepo(sl<DioHelper>()));
  // sl.registerLazySingleton(() => CartRepo(sl<DioHelper>()));

  // Cubit
  // sl.registerFactory(() => AuthCubit(sl<AuthRepo>()));
  // sl.registerFactory(() => ProductCubit(sl<HomeRepo>()));
  // sl.registerFactory(() => CategoriesCubit(sl<HomeRepo>()));
  // sl.registerFactory(() => CartCubit(sl<CartRepo>()));
}
