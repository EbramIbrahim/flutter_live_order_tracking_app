import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:live_order_tracking/core/styling/app_colors.dart';
import 'package:live_order_tracking/core/utils/animated_snack_dialog.dart';
import 'package:live_order_tracking/core/widgets/loading_widget.dart';
import 'package:live_order_tracking/features/orders/all_orders/cubit/all_orders_cubit.dart';
import 'package:live_order_tracking/features/orders/all_orders/cubit/all_orders_state.dart';
import 'package:live_order_tracking/features/orders/all_orders/widgets/order_item_widget.dart';
import 'package:live_order_tracking/features/orders/models/orders.dart';

class AllOrdersScreen extends StatefulWidget {
  const AllOrdersScreen({super.key});

  @override
  State<AllOrdersScreen> createState() => _AllOrdersScreenState();
}

class _AllOrdersScreenState extends State<AllOrdersScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("My Orders", style: TextStyle(color: Colors.white)),
        backgroundColor: AppColors.primaryColor,
        leading: Container(),
      ),
      body: BlocConsumer<AllOrdersCubit, AllOrdersState>(
        builder: (context, state) {
          if (state is AllOrdersLoading) {
            return LoadingWidget();
          }
          if (state is AllOrdersSuccess) {
            List<Orders> orders = state.ordersList;
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: ListView.builder(
                itemCount: orders.length,
                itemBuilder: (context, index) {
                  return OrderItemWidget(orders: orders[index]);
                },
              ),
            );
          }
          return Container();
        },
        listener: (context, state) {
          if (state is AllOrdersError) {
            showAnimatedSnackDialog(
              context,
              message: state.errorMessage,
              type: AnimatedSnackBarType.error,
            );
          }
        },
      ),
    );
  }
}
