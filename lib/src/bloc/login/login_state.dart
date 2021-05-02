part of 'login_cubit.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {
  final showPassword = false;
  final userAuthenticated = false;
}

class LoginShowPassword extends LoginState {
  final showPassword = true;
}

class LoginHidePassword extends LoginState {
  final showPassword = false;
}
