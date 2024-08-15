import 'package:equatable/equatable.dart';

class ChooseScreenState extends Equatable {
  final bool isCustomerSelect;
  final bool isVendorSelect;

  const ChooseScreenState({
    required this.isCustomerSelect,
    required this.isVendorSelect,
  });

  const ChooseScreenState.initial()
      : this(
          isCustomerSelect: false,
          isVendorSelect: false,
        );

  ChooseScreenState copyWith({
    bool? isCustomerSelect,
    bool? isVendorSelect,
  }) =>
      ChooseScreenState(
        isCustomerSelect: isCustomerSelect ?? this.isCustomerSelect,
        isVendorSelect: isVendorSelect ?? this.isVendorSelect,
      );

  @override
  List<Object> get props => [
        isCustomerSelect,
        isVendorSelect,
      ];

  @override
  bool get stringify => true;
}
