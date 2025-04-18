/*
 order id
 order name
 order lat lng
 user lat lng
 order user id
 order date
 order status
 */

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:live_order_tracking/core/routing/app_routes.dart';
import 'package:live_order_tracking/core/styling/app_assets.dart';
import 'package:live_order_tracking/core/styling/app_styles.dart';
import 'package:live_order_tracking/core/widgets/custom_text_field.dart';
import 'package:live_order_tracking/core/widgets/primary_button_widget.dart';
import 'package:live_order_tracking/core/widgets/spacing_widgets.dart';

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
        body: Padding(
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

                  const HeightSpace(55),
                  PrimayButtonWidget(
                    buttonText: "Create Order",
                    onPress: () {
                      //    if (formKey.currentState!.validate()) {
                      //   GoRouter.of(context).pushNamed(AppRoutes.verifyOtpScreen);
                      //  }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
