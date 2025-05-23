import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:live_order_tracking/core/routing/app_routes.dart';
import 'package:live_order_tracking/core/styling/app_assets.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  AnimationController? animationController;
  Animation<double>? animation;

  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1, milliseconds: 500),
    )..repeat(reverse: true);

    animation = CurvedAnimation(
      parent: animationController!,
      curve: Curves.easeOut,
    );

    waitAnimationAndNavigate();
    super.initState();
  }

  waitAnimationAndNavigate() async {
    await Future.delayed(const Duration(seconds: 3));

    if (mounted) {
      context.pushReplacementNamed(AppRoutes.loginScreen);
    }
  }

  @override
  void dispose() {
    animationController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ScaleTransition(
          scale: animation!,
          child: Image.asset(AppAssets.logo, width: 200.w, height: 200.w),
        ),
      ),
    );
  }
}
