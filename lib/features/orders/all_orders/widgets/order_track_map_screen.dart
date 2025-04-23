import 'dart:async';
import 'dart:developer';
import 'dart:typed_data';

import 'package:custom_info_window/custom_info_window.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:live_order_tracking/core/styling/app_assets.dart';
import 'package:live_order_tracking/core/utils/location_services.dart';
import 'package:live_order_tracking/features/orders/all_orders/widgets/order_custom_info_window.dart';
import 'package:live_order_tracking/features/orders/models/orders.dart';

class OrderTrackMapScreen extends StatefulWidget {
  final Orders orders;
  const OrderTrackMapScreen({super.key, required this.orders});

  @override
  State<OrderTrackMapScreen> createState() => _OrderTrackMapScreenState();
}

class _OrderTrackMapScreenState extends State<OrderTrackMapScreen> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  CustomInfoWindowController customInfoWindowController =
      CustomInfoWindowController();
  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();
  Set<Marker> markers = {};

  LatLng? currentPosition;

  loadOrderLocationAndUserMarker(Orders orders) async {
    final Uint8List orderIcon = await LocationServices.getBytesFromAsset(
      AppAssets.order,
      50,
    );

    final Uint8List userIcon = await LocationServices.getBytesFromAsset(
      AppAssets.truck,
      50,
    );

    final orderMarker = LocationServices.addMarker(
      LatLng(orders.orderLat ?? 30.0596113, orders.orderLng ?? 31.3333333),
      orders.orderId.toString(),
      BitmapDescriptor.bytes(orderIcon),
      customInfoWindowController,
      OrderCustomInfoWindow(orders: orders),
    );

    final userMarker = LocationServices.addMarker(
      currentPosition ?? LatLng(30.0596113, 31.3333333),
      FirebaseAuth.instance.currentUser!.uid,
      BitmapDescriptor.bytes(userIcon),
      customInfoWindowController,
      OrderCustomInfoWindow(orders: orders),
    );

    markers.addAll([orderMarker, userMarker]);
    setState(() {});
  }

  Future<void> _goToThePosition(LatLng position) async {
    final GoogleMapController controller = await _controller.future;
    await controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: position, zoom: 16),
      ),
    );
  }

  locateAndAnimateToUserPosition() async {
    try {
      final position = await LocationServices.determinePosition();
      currentPosition = LatLng(position.latitude, position.longitude);
      _goToThePosition(
        LatLng(currentPosition!.latitude, currentPosition!.longitude),
      );
    } catch (e) {
      log(e.toString());
    }
  }

  drawLinesBetweenOrderAndLocation(Orders orders) async {
    await LocationServices.getPolyline(
      polylinePoints,
      "",
      LatLng(orders.orderLat ?? 0.0, orders.orderLng ?? 0.0),
      currentPosition ?? LatLng(0.0, 0.0),
      polylines,
      polylineCoordinates,
    );
  }

  @override
  void initState() async {
    await locateAndAnimateToUserPosition();
    loadOrderLocationAndUserMarker(widget.orders);
    drawLinesBetweenOrderAndLocation(widget.orders);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            markers: markers,
            mapType: MapType.hybrid,
            initialCameraPosition: CameraPosition(
              target: LatLng(
                widget.orders.orderLat ?? 0.0,
                widget.orders.orderLng ?? 0.0,
              ),
              zoom: 16,
            ),
            onMapCreated: (controller) => _controller.complete(controller),
          ),
          CustomInfoWindow(
            controller: customInfoWindowController,
            height: 160.h,
            width: 300.w,
            offset: 50,
          ),
        ],
      ),
    );
  }
}
