import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:live_order_tracking/features/orders/models/orders.dart';

class AddOrderRepository {
  FirebaseFirestore firestore;

  AddOrderRepository(this.firestore);

  Future<Either<String, String>> addOrder({required Orders order}) async {
    try {
      await firestore.collection("orders").doc().set({
        "orderId": order.orderId,
        "orderName": order.orderName,
        "orderLat": order.orderLat,
        "orderLng": order.orderLng,
        "userLat": order.userLat,
        "userLng": order.userLng,
        "orderUserId": order.orderUserId,
        "orderDate": order.orderDate,
        "orderState": order.orderState,
      });
      return const Right("Successfully add order...");
    } catch (e) {
      return Left(e.toString());
    }
  }
}
