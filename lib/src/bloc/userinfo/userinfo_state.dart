part of 'userinfo_cubit.dart';

@immutable
abstract class UserinfoState {}

class UserinfoInitial extends UserinfoState {}

class UserFetched extends UserinfoState {
  UserFetched(this.user);
  
  final UserInfo user;
}

