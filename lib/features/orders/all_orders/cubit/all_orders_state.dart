import 'package:live_order_tracking/features/orders/models/orders.dart';

abstract class AllOrdersState {}

class AllOrdersInitial extends AllOrdersState {}

class AllOrdersLoading extends AllOrdersState {}

class AllOrdersSuccess extends AllOrdersState {
  final List<Orders> ordersList;
  AllOrdersSuccess({required this.ordersList});
}

class AllOrdersError extends AllOrdersState {
  final String errorMessage;
  AllOrdersError({required this.errorMessage});
}
