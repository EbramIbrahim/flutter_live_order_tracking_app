import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:live_order_tracking/core/routing/app_routes.dart';
import 'package:live_order_tracking/core/styling/app_colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: Text("Home", style: TextStyle(color: Colors.white)),
        centerTitle: true,
        leading: Container(),
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                GoRouter.of(
                  context,
                ).pushReplacementNamed(AppRoutes.allOrdersScreen);
              },
              child: Container(
                height: 190.h,
                width: 190.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  color: AppColors.primaryColor,
                ),
                child: Center(
                  child: Text(
                    "Orders",
                    style: TextStyle(color: Colors.white, fontSize: 20.sp),
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                GoRouter.of(
                  context,
                ).pushReplacementNamed(AppRoutes.addOrderScreen);
              },
              child: Container(
                height: 190.h,
                width: 190.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  color: AppColors.primaryColor,
                ),
                child: Center(
                  child: Text(
                    "Add Order",
                    style: TextStyle(color: Colors.white, fontSize: 20.sp),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
