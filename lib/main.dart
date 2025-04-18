import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:live_order_tracking/core/routing/route_generation_config.dart';
import 'package:live_order_tracking/core/styling/app_themes.dart';
import 'package:live_order_tracking/core/utils/service_locator.dart';
import 'package:live_order_tracking/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupServiceLocator();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      builder: (context, child) {
        return MaterialApp.router(
          title: 'Order Tracking',
          theme: AppThemes.lightTheme,
          routerConfig: RouteGenerationConfig.goRouter,
        );
      },
    );
  }
}
