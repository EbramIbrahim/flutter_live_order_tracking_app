abstract class RegisterState {}

class InitialRegisterState extends RegisterState {}

class LoadingRegisterState extends RegisterState {}

class SuccessRegisterState extends RegisterState {
  String message;
  SuccessRegisterState(this.message);
}

class ErrorRegisterState extends RegisterState {
  String message;
  ErrorRegisterState(this.message);
}
