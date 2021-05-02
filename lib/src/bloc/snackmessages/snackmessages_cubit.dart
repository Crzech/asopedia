import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'snackmessages_state.dart';

class SnackmessagesCubit extends Cubit<SnackmessagesState> {
  SnackmessagesCubit() : super(SnackmessagesInitial());

  void addNewMessage(message) => emit(SnackmessagesNewMessage(message: message)); 
}
