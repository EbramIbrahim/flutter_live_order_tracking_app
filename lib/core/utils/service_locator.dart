import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:live_order_tracking/core/utils/storage_service.dart';
import 'package:live_order_tracking/features/auth/login/cubit/login_cubit.dart';
import 'package:live_order_tracking/features/auth/login/repository/login_repository.dart';
import 'package:live_order_tracking/features/auth/register/cubit/register_cubit.dart';
import 'package:live_order_tracking/features/auth/register/repository/register_repository.dart';

GetIt sl = GetIt.instance;

void setupServiceLocator() {
  sl.registerLazySingleton(() => FirebaseAuth.instance);

  //Storage Helper
  sl.registerLazySingleton(() => StorageHelper());

  // Repos
  sl.registerLazySingleton(() => RegisterRepository(sl<FirebaseAuth>()));
  sl.registerLazySingleton(() => LoginRepository(sl<FirebaseAuth>()));
  // sl.registerLazySingleton(() => CartRepo(sl<DioHelper>()));

  // Cubit
  sl.registerFactory(() => RegisterCubit(sl<RegisterRepository>()));
  sl.registerFactory(() => LoginCubit(sl<LoginRepository>()));
  // sl.registerFactory(() => CategoriesCubit(sl<HomeRepo>()));
  // sl.registerFactory(() => CartCubit(sl<CartRepo>()));
}
