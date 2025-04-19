/*
 order id
 order name
 order lat lng
 user lat lng
 order user id
 order date
 order status
 */

import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:live_order_tracking/core/routing/app_routes.dart';
import 'package:live_order_tracking/core/styling/app_assets.dart';
import 'package:live_order_tracking/core/styling/app_styles.dart';
import 'package:live_order_tracking/core/utils/animated_snack_dialog.dart';
import 'package:live_order_tracking/core/widgets/custom_text_field.dart';
import 'package:live_order_tracking/core/widgets/loading_widget.dart';
import 'package:live_order_tracking/core/widgets/primary_button_widget.dart';
import 'package:live_order_tracking/core/widgets/spacing_widgets.dart';
import 'package:live_order_tracking/features/orders/add_order/cubit/add_order_cubit.dart';
import 'package:live_order_tracking/features/orders/add_order/cubit/add_order_state.dart';
import 'package:live_order_tracking/features/orders/models/orders.dart';

class AddOrderScreen extends StatefulWidget {
  const AddOrderScreen({super.key});

  @override
  State<AddOrderScreen> createState() => _AddOrderScreenState();
}

class _AddOrderScreenState extends State<AddOrderScreen> {
  final formKey = GlobalKey<FormState>();
  TextEditingController orderIdController = TextEditingController();
  TextEditingController orderNameController = TextEditingController();
  TextEditingController orderArrivalController = TextEditingController();

  LatLng? orderLocation;
  LatLng? userLocation;
  DateTime? orderArrivalDateTime;
  String? orderLocationDetails;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocConsumer<AddOrderCubit, AddOrderState>(
          builder: (context, state) {
            if (state is AddOrderLoading) {
              return LoadingWidget();
            }
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 22.w),
              child: Form(
                key: formKey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const HeightSpace(28),
                      SizedBox(
                        width: 335.w,
                        child: Text(
                          "Create Your new Order",
                          style: AppStyles.primaryHeadLinesStyle,
                        ),
                      ),
                      const HeightSpace(8),
                      SizedBox(
                        width: 335.w,
                        child: Text(
                          "it's great to see you again",
                          style: AppStyles.grey12MediumStyle,
                        ),
                      ),
                      const HeightSpace(20),
                      Center(
                        child: Image.asset(
                          AppAssets.order,
                          width: 190.w,
                          height: 190.w,
                        ),
                      ),
                      const HeightSpace(32),
                      Text("order ID", style: AppStyles.black16w500Style),
                      const HeightSpace(8),
                      CustomTextField(
                        controller: orderIdController,
                        hintText: "Enter Your Order ID",
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter Your Order ID";
                          }
                          return null;
                        },
                      ),
                      const HeightSpace(16),
                      Text("Order Name", style: AppStyles.black16w500Style),
                      const HeightSpace(8),
                      CustomTextField(
                        hintText: "Enter Your Order Name",
                        controller: orderNameController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter Your Order Name";
                          }
                          return null;
                        },
                      ),
                      const HeightSpace(16),
                      Text("Arrival Date", style: AppStyles.black16w500Style),
                      const HeightSpace(8),
                      CustomTextField(
                        hintText: "Enter Your Arrival Date",
                        controller: orderArrivalController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter Your Order Name";
                          }
                          return null;
                        },
                        readOnly: true,
                        suffixIcon: IconButton(
                          onPressed: () {
                            showDatePicker(
                              context: context,
                              firstDate: DateTime.now(),
                              lastDate: DateTime(2030),
                              initialDate: DateTime.now(),
                            ).then((value) {
                              orderArrivalDateTime = value;
                              if (orderArrivalDateTime != null) {
                                String dateFormated = DateFormat(
                                  "yyyy-MM-dd",
                                ).format(orderArrivalDateTime!);
                                orderArrivalController.text = dateFormated;
                              }
                            });
                          },
                          icon: Icon(Icons.data_usage_outlined),
                        ),
                      ),
                      const HeightSpace(16),
                      PrimayButtonWidget(
                        buttonText: "Pick Your location",
                        icon: Icon(
                          Icons.map_outlined,
                          color: Colors.white,
                          size: 20.sp,
                        ),
                        onPress: () async {
                          LatLng? location = await context.push<LatLng?>(
                            AppRoutes.placePickerScreen,
                          );
                          if (location != null) {
                            orderLocation = location;
                            List<Placemark> placeMarks =
                                await placemarkFromCoordinates(
                                  location.latitude,
                                  location.longitude,
                                );
                            orderLocationDetails =
                                "${placeMarks.first.country} ${placeMarks.first.street}";
                          }
                        },
                      ),

                      const HeightSpace(2),
                      if (orderLocationDetails != null)
                        Text(
                          orderLocationDetails!,
                          style: TextStyle(fontSize: 12.sp),
                        )
                      else
                        SizedBox.shrink(),

                      const HeightSpace(35),
                      PrimayButtonWidget(
                        buttonText: "Create Order",
                        onPress: () {
                          if (orderArrivalDateTime == null) {
                            showAnimatedSnackDialog(
                              context,
                              message: "You should fill the arrival date",
                              type: AnimatedSnackBarType.warning,
                            );
                            return;
                          }

                          if (formKey.currentState!.validate()) {
                            context.read<AddOrderCubit>().addOrder(
                              order: Orders(
                                orderId: orderIdController.text,
                                orderName: orderNameController.text,
                                orderLat: 30.0270231,
                                orderLng: 31.4221001,
                                userLat: 0.0,
                                userLng: 0.0,
                                orderUserId:
                                    FirebaseAuth.instance.currentUser!.uid,
                                orderDate: orderArrivalDateTime.toString(),
                                orderState: "pending",
                              ),
                            );
                          }
                        },
                      ),
                      const HeightSpace(55),
                    ],
                  ),
                ),
              ),
            );
          },
          listener: (context, state) {
            if (state is AddOrderSuccess) {
              showAnimatedSnackDialog(
                context,
                message: state.successMessage,
                type: AnimatedSnackBarType.success,
              );
            }
            if (state is AddOrderError) {
              showAnimatedSnackDialog(
                context,
                message: state.errorMessage,
                type: AnimatedSnackBarType.error,
              );
            }
          },
        ),
      ),
    );
  }
}
