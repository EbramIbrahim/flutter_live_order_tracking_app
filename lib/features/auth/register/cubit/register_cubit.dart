import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:live_order_tracking/features/auth/register/cubit/register_state.dart';
import 'package:live_order_tracking/features/auth/register/repository/register_repository.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterRepository registerRepository;

  RegisterCubit(this.registerRepository) : super(InitialRegisterState());

  void register(String email, String password) async {
    emit(LoadingRegisterState());
    final result = await registerRepository.register(email, password);
    result.fold(
      (errorMessage) {
        emit(ErrorRegisterState(errorMessage));
      },
      (successMessage) {
        emit(SuccessRegisterState(successMessage));
      },
    );
  }
}
