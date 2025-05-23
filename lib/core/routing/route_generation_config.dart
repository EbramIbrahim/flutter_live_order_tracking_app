import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:live_order_tracking/core/routing/app_routes.dart';
import 'package:live_order_tracking/core/utils/service_locator.dart';
import 'package:live_order_tracking/features/auth/login/cubit/login_cubit.dart';
import 'package:live_order_tracking/features/auth/login/widgets/login_screen.dart';
import 'package:live_order_tracking/features/auth/register/cubit/register_cubit.dart';
import 'package:live_order_tracking/features/auth/register/widgets/register_screen.dart';
import 'package:live_order_tracking/features/home/home_screen.dart';
import 'package:live_order_tracking/features/location_picker/location_picker_screen.dart';
import 'package:live_order_tracking/features/orders/add_order/add_order_Screen.dart';
import 'package:live_order_tracking/features/orders/add_order/cubit/add_order_cubit.dart';
import 'package:live_order_tracking/features/orders/all_orders/cubit/all_orders_cubit.dart';
import 'package:live_order_tracking/features/orders/all_orders/widgets/all_orders_screen.dart';
import 'package:live_order_tracking/features/splash_screen/splash_screen.dart';

class RouteGenerationConfig {
  static GoRouter goRouter = GoRouter(
    initialLocation: AppRoutes.splashScreen,
    routes: [
      GoRoute(
        name: AppRoutes.splashScreen,
        path: AppRoutes.splashScreen,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        name: AppRoutes.loginScreen,
        path: AppRoutes.loginScreen,
        builder:
            (context, state) => BlocProvider(
              create: (context) => sl<LoginCubit>(),
              child: LoginScreen(),
            ),
      ),
      GoRoute(
        name: AppRoutes.registerScreen,
        path: AppRoutes.registerScreen,
        builder:
            (context, state) => BlocProvider(
              create: (context) => sl<RegisterCubit>(),
              child: RegisterScreen(),
            ),
      ),
      GoRoute(
        name: AppRoutes.homeScreen,
        path: AppRoutes.homeScreen,
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        name: AppRoutes.addOrderScreen,
        path: AppRoutes.addOrderScreen,
        builder:
            (context, state) => BlocProvider(
              create: (context) => sl<AddOrderCubit>(),
              child: AddOrderScreen(),
            ),
      ),
      GoRoute(
        name: AppRoutes.allOrdersScreen,
        path: AppRoutes.allOrdersScreen,
        builder:
            (context, state) => BlocProvider(
              create: (context) => sl<AllOrdersCubit>(),
              child: AllOrdersScreen(),
            ),
      ),
      GoRoute(
        name: AppRoutes.placePickerScreen,
        path: AppRoutes.placePickerScreen,
        builder: (context, state) => const LocationPickerScreen(),
      ),
    ],
  );
}
