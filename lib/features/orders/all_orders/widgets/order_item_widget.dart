import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:live_order_tracking/core/styling/app_colors.dart';
import 'package:live_order_tracking/core/styling/app_styles.dart';
import 'package:live_order_tracking/core/widgets/primary_button_widget.dart';
import 'package:live_order_tracking/features/orders/models/orders.dart';

class OrderItemWidget extends StatelessWidget {
  final Orders orders;
  const OrderItemWidget({super.key, required this.orders});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 200.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        color: AppColors.greyColor,
      ),
      child: Padding(
        padding: EdgeInsets.all(8.w),
        child: Column(
          children: [
            Text(
              "Order Id: #${orders.orderId}",
              style: AppStyles.black18BoldStyle,
            ),
            Text(
              "Order name: ${orders.orderName}",
              style: AppStyles.black16w500Style,
            ),
            Text(
              "Order Status: #${orders.orderState}",
              style: AppStyles.black16w500Style.copyWith(color: Colors.green),
            ),
            Text(
              "Order date: #${orders.orderDate}",
              style: AppStyles.grey12MediumStyle,
            ),

            PrimayButtonWidget(
              buttonText: "Start Order",
              textColor: Colors.white,
              onPress: () {},
            ),
          ],
        ),
      ),
    );
  }
}
