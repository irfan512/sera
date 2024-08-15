import 'package:equatable/equatable.dart';

class NotificationState extends Equatable {
  final String sizeIndex;
  final String lengthIndex;

  const NotificationState({
    required this.sizeIndex,
    required this.lengthIndex,
  });

  const NotificationState.initial()
      : this(
          sizeIndex: "",
          lengthIndex: "",
        );

  NotificationState copyWith({
    String? sizeIndex,
    String? lengthIndex,
  }) =>
      NotificationState(
        sizeIndex: sizeIndex ?? this.sizeIndex,
        lengthIndex: lengthIndex ?? this.lengthIndex,
      );

  @override
  List<Object> get props => [
        sizeIndex,
        lengthIndex,
      ];

  @override
  bool get stringify => true;
}
