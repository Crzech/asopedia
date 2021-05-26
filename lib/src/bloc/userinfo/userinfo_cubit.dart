import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:asopedia/src/models/user/user_info.dart';


part 'userinfo_state.dart';
class UserinfoCubit extends Cubit<UserinfoState> {
  UserinfoCubit() : super(UserinfoInitial());

  void setUser(UserInfo user) {
    emit(UserFetched(user));
  }
}
