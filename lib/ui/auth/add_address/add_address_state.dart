import 'package:equatable/equatable.dart';

class NewAddressScreenState extends Equatable {
  final String errorText;
  final bool countryValidate;
  final bool stateValidate;
  final bool cityValidate;
  final bool isSaveCheck;
  final bool isHouseSelect;
  final bool isFlatSelect;
  final bool address1Validate;
  final bool address2Validate;
  final bool houseNoValidate;

  const NewAddressScreenState({
    required this.errorText,
    required this.stateValidate,
    required this.cityValidate,
    required this.isSaveCheck,
    required this.countryValidate,
    required this.isHouseSelect,
    required this.isFlatSelect,
    required this.address1Validate,
    required this.address2Validate,
    required this.houseNoValidate,
  });

  const NewAddressScreenState.initial()
      : this(
            errorText: '',
            address1Validate: false,
            address2Validate: false,
            houseNoValidate: false,
            stateValidate: false,
            cityValidate: false,
            isSaveCheck: false,
            countryValidate: false,
            isHouseSelect: true,
            isFlatSelect: false);

  NewAddressScreenState copyWith({
    bool? stateValidate,
    String? errorText,
    bool? cityValidate,
    bool? isSaveCheck,
    bool? countryValidate,
    bool? isFlatSelect,
    bool? isHouseSelect,
    bool? houseNoValidate,
    bool? address1Validate,
    bool? address2Validate,
  }) =>
      NewAddressScreenState(
        errorText: errorText ?? this.errorText,
        stateValidate: stateValidate ?? this.stateValidate,
        isSaveCheck: isSaveCheck ?? this.isSaveCheck,
        countryValidate: countryValidate ?? this.countryValidate,
        cityValidate: cityValidate ?? this.cityValidate,
        isHouseSelect: isHouseSelect ?? this.isHouseSelect,
        isFlatSelect: isFlatSelect ?? this.isFlatSelect,
        houseNoValidate: houseNoValidate ?? this.houseNoValidate,
        address1Validate: address1Validate ?? this.address1Validate,
        address2Validate: address2Validate ?? this.address2Validate,
      );

  @override
  List<Object> get props => [
        address1Validate,
        address2Validate,
        houseNoValidate,
        countryValidate,
        stateValidate,
        cityValidate,
        errorText,
        isFlatSelect,
        isHouseSelect,
        isSaveCheck
      ];

  @override
  bool get stringify => true;
}
