import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  void togglePassword() => emit(state.runtimeType == LoginInitial || state.runtimeType == LoginHidePassword ? LoginShowPassword() : LoginHidePassword());
}
