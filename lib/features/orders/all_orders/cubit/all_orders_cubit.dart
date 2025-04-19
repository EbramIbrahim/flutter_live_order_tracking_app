import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:live_order_tracking/features/orders/all_orders/cubit/all_orders_state.dart';
import 'package:live_order_tracking/features/orders/all_orders/repository/all_orders_repository.dart';

class AllOrdersCubit extends Cubit<AllOrdersState> {
  AllOrdersCubit(this._allOrdersRepository) : super(AllOrdersInitial());

  final AllOrdersRepository _allOrdersRepository;

  void getAllOrders() async {
    emit(AllOrdersLoading());
    var result = await _allOrdersRepository.getOrders();
    result.fold(
      (errorMessage) => emit(AllOrdersError(errorMessage: errorMessage)),
      (ordersList) => emit(AllOrdersSuccess(ordersList: ordersList)),
    );
  }
}
