import 'package:equatable/equatable.dart';

class CartScreenState extends Equatable {
  final String sizeIndex;
  final String lengthIndex;

  const CartScreenState({
    required this.sizeIndex,
    required this.lengthIndex,
  });

  const CartScreenState.initial()
      : this(
          sizeIndex: "",
          lengthIndex: "",
        );

  CartScreenState copyWith({
    String? sizeIndex,
    String? lengthIndex,
  }) =>
      CartScreenState(
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
