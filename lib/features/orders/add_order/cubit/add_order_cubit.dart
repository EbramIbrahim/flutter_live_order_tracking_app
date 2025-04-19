import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:live_order_tracking/features/orders/add_order/cubit/add_order_state.dart';
import 'package:live_order_tracking/features/orders/add_order/repository/add_order_repository.dart';
import 'package:live_order_tracking/features/orders/models/orders.dart';

class AddOrderCubit extends Cubit<AddOrderState> {
  AddOrderCubit(this._addOrderRepository) : super(AddOrderInitial());

  final AddOrderRepository _addOrderRepository;

  addOrder({required Orders order}) async {
    emit(AddOrderLoading());

    var result = await _addOrderRepository.addOrder(order: order);
    result.fold(
      (errorMessage) {
        emit(AddOrderError(errorMessage));
      },
      (successMessage) {
        emit(AddOrderSuccess(successMessage));
      },
    );
  }
}
