abstract class LoginState {}

class InitialLoginState extends LoginState {}

class LoadingLoginState extends LoginState {}

class SuccessLoginState extends LoginState {
  String message;
  SuccessLoginState(this.message);
}

class ErrorLoginState extends LoginState {
  String message;
  ErrorLoginState(this.message);
}
