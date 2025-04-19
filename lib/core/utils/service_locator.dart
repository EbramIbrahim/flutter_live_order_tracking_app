import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:live_order_tracking/core/utils/storage_service.dart';
import 'package:live_order_tracking/features/auth/login/cubit/login_cubit.dart';
import 'package:live_order_tracking/features/auth/login/repository/login_repository.dart';
import 'package:live_order_tracking/features/auth/register/cubit/register_cubit.dart';
import 'package:live_order_tracking/features/auth/register/repository/register_repository.dart';
import 'package:live_order_tracking/features/orders/add_order/cubit/add_order_cubit.dart';
import 'package:live_order_tracking/features/orders/add_order/repository/add_order_repository.dart';
import 'package:live_order_tracking/features/orders/all_orders/cubit/all_orders_cubit.dart';
import 'package:live_order_tracking/features/orders/all_orders/repository/all_orders_repository.dart';

GetIt sl = GetIt.instance;

void setupServiceLocator() {
  sl.registerLazySingleton(() => FirebaseAuth.instance);
  sl.registerLazySingleton(() => FirebaseFirestore.instance);

  //Storage Helper
  sl.registerLazySingleton(() => StorageHelper());

  // Repos
  sl.registerLazySingleton(
    () => RegisterRepository(sl<FirebaseAuth>(), sl<FirebaseFirestore>()),
  );
  sl.registerLazySingleton(() => LoginRepository(sl<FirebaseAuth>()));
  sl.registerLazySingleton(() => AddOrderRepository(sl<FirebaseFirestore>()));
  sl.registerLazySingleton(() => AllOrdersRepository(sl<FirebaseFirestore>()));

  // sl.registerLazySingleton(() => CartRepo(sl<DioHelper>()));

  // Cubit
  sl.registerFactory(() => RegisterCubit(sl<RegisterRepository>()));
  sl.registerFactory(() => LoginCubit(sl<LoginRepository>()));
  sl.registerFactory(() => AddOrderCubit(sl<AddOrderRepository>()));
  sl.registerFactory(() => AllOrdersCubit(sl<AllOrdersRepository>()));

  // sl.registerFactory(() => CategoriesCubit(sl<HomeRepo>()));
  // sl.registerFactory(() => CartCubit(sl<CartRepo>()));
}
