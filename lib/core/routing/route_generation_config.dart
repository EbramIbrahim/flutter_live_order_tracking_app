import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:live_order_tracking/core/routing/app_routes.dart';
import 'package:live_order_tracking/core/utils/service_locator.dart';
import 'package:live_order_tracking/features/auth/login/cubit/login_cubit.dart';
import 'package:live_order_tracking/features/auth/login/widgets/login_screen.dart';
import 'package:live_order_tracking/features/auth/register/cubit/register_cubit.dart';
import 'package:live_order_tracking/features/auth/register/widgets/register_screen.dart';
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
    ],
  );
}
