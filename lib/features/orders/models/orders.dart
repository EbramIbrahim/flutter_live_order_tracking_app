class Orders {
  String? orderId;
  String? orderName;
  double? orderLat;
  double? orderLng;
  double? userLat;
  double? userLng;
  String? orderUserId;
  String? orderDate;
  String? orderState;

  Orders({
    this.orderId,
    this.orderName,
    this.orderLat,
    this.orderLng,
    this.userLat,
    this.userLng,
    this.orderUserId,
    this.orderDate,
    this.orderState,
  });

  factory Orders.fromJson(Map<String, dynamic> map) {
    return Orders(
      orderId: map["orderId"],
      orderName: map["orderName"],
      orderLat: map["orderLat"],
      orderLng: map["orderLng"],
      userLat: map["userLat"],
      userLng: map["userLng"],
      orderUserId: map["orderUserId"],
      orderDate: map["orderDate"],
      orderState: map["orderState"],
    );
  }
  Map<String, dynamic> ordersToJson(Orders order) {
    return {
      "orderId": orderId,
      "orderName": orderName,
      "orderLat": orderLat,
      "orderLng": orderLng,
      "userLat": userLat,
      "userLng": userLng,
      "orderUserId": orderUserId,
      "orderDate": orderDate,
      "orderState": orderState,
    };
  }
}
