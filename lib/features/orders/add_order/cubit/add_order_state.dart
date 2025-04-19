abstract class AddOrderState {}

class AddOrderInitial extends AddOrderState {}

class AddOrderLoading extends AddOrderState {}

class AddOrderError extends AddOrderState {
  final String errorMessage;
  AddOrderError(this.errorMessage);
}

class AddOrderSuccess extends AddOrderState {
  final String successMessage;
  AddOrderSuccess(this.successMessage);
}
