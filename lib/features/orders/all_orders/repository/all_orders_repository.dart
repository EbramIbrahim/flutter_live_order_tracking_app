import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:live_order_tracking/features/orders/models/orders.dart';

class AllOrdersRepository {
  final FirebaseFirestore _firestore;
  AllOrdersRepository(this._firestore);

  Future<Either<String, List<Orders>>> getOrders() async {
    try {
      var querySnapshot =
          await _firestore
              .collection("orders")
              .where(
                "orderUserId",
                isEqualTo: FirebaseAuth.instance.currentUser!.uid,
              )
              .get();
      List<Orders> orders = [];
      for (var element in querySnapshot.docs) {
        orders.add(Orders.fromJson(element.data()));
      }
      return Right(orders);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
