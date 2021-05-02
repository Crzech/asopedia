part of 'snackmessages_cubit.dart';

@immutable
abstract class SnackmessagesState {
}

class SnackmessagesInitial extends SnackmessagesState {}

class SnackmessagesNewMessage extends SnackmessagesState{
  final String message;

  SnackmessagesNewMessage({ this.message });
}
