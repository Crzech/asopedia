part of 'home_cubit.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {
  final bool isUserConfirmed = false;
  final bool isLoading = true;
}

class HomeUserNotConfirmed extends HomeState {
  final bool isUserConfirmed = false;
  final bool isLoading = false;
}

class HomeUserConfirmed extends HomeState {
  final bool isUserConfirmed = true;
  final bool isLoading = false;
}