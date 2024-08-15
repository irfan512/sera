import 'package:equatable/equatable.dart';

class ContactUsState extends Equatable {
  final int pagerIndex;
  final String errorText;
  final bool messageValidate;
  final bool lastNameValidate;
  final bool mobileNumberValidate;

  final bool emailValidate;
  final bool passwordValidate;
  final bool confirmPasswordValidate;
  final bool isPasswordShown;
  final bool isRepeatPasswordShown;
  final bool isCustomerSelect;
  final bool isVendorSelect;
  final bool isaddressShow;
  final bool isAnnounceShow;
  final bool isWomenSelect;
  final bool isKidsSelect;
  final bool isMenSelect;

  const ContactUsState({
    required this.isAnnounceShow,
    required this.isCustomerSelect,
    required this.isaddressShow,
    required this.isVendorSelect,
    required this.pagerIndex,
    required this.errorText,
    required this.messageValidate,
    required this.lastNameValidate,
    required this.mobileNumberValidate,
    required this.emailValidate,
    required this.passwordValidate,
    required this.confirmPasswordValidate,
    required this.isPasswordShown,
    required this.isRepeatPasswordShown,
    required this.isWomenSelect,
    required this.isKidsSelect,
    required this.isMenSelect,
  });

  const ContactUsState.initial()
      : this(
          pagerIndex: 0,
          isAnnounceShow: false,
          isaddressShow: false,
          isCustomerSelect: false,
          isVendorSelect: false,
          errorText: '',
          messageValidate: false,
          lastNameValidate: false,
          mobileNumberValidate: false,
          emailValidate: false,
          passwordValidate: false,
          confirmPasswordValidate: false,
          isPasswordShown: false,
          isRepeatPasswordShown: false,
          isWomenSelect: false,
          isMenSelect: false,
          isKidsSelect: false,
        );

  ContactUsState copyWith({
    bool? isWomenSelect,
    bool? isMenSelect,
    bool? isKidsSelect,
    bool? isCustomerSelect,
    bool? isAnnounceShow,
    bool? isVendorSelect,
    int? pagerIndex,
    String? errorText,
    bool? messageValidate,
    bool? lastNameValidate,
    bool? mobileNumberValidate,
    bool? emailValidate,
    bool? passwordValidate,
    bool? confirmPasswordValidate,
    bool? isPasswordShown,
    bool? isRepeatPasswordShown,
    bool? isaddressShow,
  }) =>
      ContactUsState(
          isWomenSelect: isWomenSelect ?? this.isWomenSelect,
          isMenSelect: isMenSelect ?? this.isMenSelect,
          isKidsSelect: isKidsSelect ?? this.isKidsSelect,
          isAnnounceShow: isAnnounceShow ?? this.isAnnounceShow,
          isaddressShow: isaddressShow ?? this.isaddressShow,
          isCustomerSelect: isCustomerSelect ?? this.isCustomerSelect,
          isVendorSelect: isVendorSelect ?? this.isVendorSelect,
          pagerIndex: pagerIndex ?? this.pagerIndex,
          errorText: errorText ?? this.errorText,
          messageValidate: messageValidate ?? this.messageValidate,
          lastNameValidate: lastNameValidate ?? this.lastNameValidate,
          mobileNumberValidate:
              mobileNumberValidate ?? this.mobileNumberValidate,
          emailValidate: emailValidate ?? this.emailValidate,
          passwordValidate: passwordValidate ?? this.passwordValidate,
          confirmPasswordValidate:
              confirmPasswordValidate ?? this.confirmPasswordValidate,
          isPasswordShown: isPasswordShown ?? this.isPasswordShown,
          isRepeatPasswordShown:
              isRepeatPasswordShown ?? this.isRepeatPasswordShown);

  @override
  List<Object> get props => [
        isMenSelect,
        isWomenSelect,
        isKidsSelect,
        isAnnounceShow,
        isaddressShow,
        isCustomerSelect,
        isVendorSelect,
        pagerIndex,
        errorText,
        messageValidate,
        lastNameValidate,
        mobileNumberValidate,
        emailValidate,
        passwordValidate,
        isPasswordShown,
        isRepeatPasswordShown,
        confirmPasswordValidate
      ];

  @override
  bool get stringify => true;
}
