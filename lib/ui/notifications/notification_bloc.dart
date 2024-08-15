import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sera/ui/notifications/notification_state.dart';

class NotificationBloc extends Cubit<NotificationState> {
  NotificationBloc() : super(const NotificationState.initial());

////////////////// CHOOSE YOURSELF //////////////////////
  void updateSizeIndex(value) {
    emit(state.copyWith(sizeIndex: value));
  }

  void updateLengthIndex(value) {
    emit(state.copyWith(lengthIndex: value));
  }
}
