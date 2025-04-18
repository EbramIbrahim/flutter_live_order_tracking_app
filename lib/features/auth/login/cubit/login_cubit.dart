import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:live_order_tracking/features/auth/login/cubit/login_state.dart';
import 'package:live_order_tracking/features/auth/login/repository/login_repository.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginRepository loginRepository;

  LoginCubit(this.loginRepository) : super(InitialLoginState());

  void login(String email, String password) async {
    emit(LoadingLoginState());
    final result = await loginRepository.login(email, password);
    result.fold(
      (errorMessage) {
        emit(ErrorLoginState(errorMessage));
      },
      (successMessage) {
        emit(SuccessLoginState(successMessage));
      },
    );
  }
}
