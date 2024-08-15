import 'package:equatable/equatable.dart';
import 'package:sera/data/meta_data.dart';

class EditBrandState extends Equatable {
  final int pagerIndex;
  final String errorText;
  final bool businessNameValidate;
  final bool lastNameValidate;
  final bool mobileNumberValidate;

  final bool emailValidate;
  final bool passwordValidate;
  final bool bioValidate;
  final bool isPasswordShown;
  final bool isRepeatPasswordShown;
  final bool isCustomerSelect;
  final bool isVendorSelect;
  final bool isaddressShow;
  final bool isAnnounceShow;
  final bool isWomenSelect;
  final bool isKidsSelect;
  final bool isMenSelect;
  final bool mobileCodeValidate;
  final DataEvent headerDataEvent;
  final DataEvent logoDataEvent;
  final String logoImage;
  final String headerImage;

  const EditBrandState({
    required this.mobileCodeValidate,
    required this.isAnnounceShow,
    required this.logoImage,
    required this.headerImage,
    required this.isCustomerSelect,
    required this.isaddressShow,
    required this.isVendorSelect,
    required this.pagerIndex,
    required this.errorText,
    required this.businessNameValidate,
    required this.lastNameValidate,
    required this.mobileNumberValidate,
    required this.emailValidate,
    required this.passwordValidate,
    required this.bioValidate,
    required this.isPasswordShown,
    required this.isRepeatPasswordShown,
    required this.isWomenSelect,
    required this.isKidsSelect,
    required this.isMenSelect,
    required this.logoDataEvent,
    required this.headerDataEvent,
  });

  const EditBrandState.initial()
      : this(
          pagerIndex: 0,
          isAnnounceShow: false,
          mobileCodeValidate: false,
          logoImage: "",
          headerImage: "",
          isaddressShow: false,
          isCustomerSelect: false,
          isVendorSelect: false,
          errorText: '',
          businessNameValidate: false,
          lastNameValidate: false,
          mobileNumberValidate: false,
          emailValidate: false,
          passwordValidate: false,
          bioValidate: false,
          isPasswordShown: false,
          isRepeatPasswordShown: false,
          isWomenSelect: false,
          isMenSelect: false,
          isKidsSelect: false,
          logoDataEvent: const Initial(),
          headerDataEvent: const Initial(),
        );

  EditBrandState copyWith({
    bool? isWomenSelect,
    bool? mobileCodeValidate,
    bool? isMenSelect,
    bool? isKidsSelect,
    bool? isCustomerSelect,
    bool? isAnnounceShow,
    bool? isVendorSelect,
    int? pagerIndex,
    String? errorText,
    bool? businessNameValidate,
    bool? lastNameValidate,
    bool? mobileNumberValidate,
    bool? emailValidate,
    bool? passwordValidate,
    bool? bioValidate,
    bool? isPasswordShown,
    bool? isRepeatPasswordShown,
    bool? isaddressShow,
    DataEvent? headerDataEvent,
    DataEvent? logoDataEvent,
    String? logoImage,
    String? headerImage,
  }) =>
      EditBrandState(
          logoImage: logoImage ?? this.logoImage,
          headerImage: headerImage ?? this.headerImage,
          mobileCodeValidate: mobileCodeValidate ?? this.mobileCodeValidate,
          isWomenSelect: isWomenSelect ?? this.isWomenSelect,
          isMenSelect: isMenSelect ?? this.isMenSelect,
          isKidsSelect: isKidsSelect ?? this.isKidsSelect,
          isAnnounceShow: isAnnounceShow ?? this.isAnnounceShow,
          isaddressShow: isaddressShow ?? this.isaddressShow,
          isCustomerSelect: isCustomerSelect ?? this.isCustomerSelect,
          isVendorSelect: isVendorSelect ?? this.isVendorSelect,
          pagerIndex: pagerIndex ?? this.pagerIndex,
          errorText: errorText ?? this.errorText,
          businessNameValidate:
              businessNameValidate ?? this.businessNameValidate,
          lastNameValidate: lastNameValidate ?? this.lastNameValidate,
          mobileNumberValidate:
              mobileNumberValidate ?? this.mobileNumberValidate,
          emailValidate: emailValidate ?? this.emailValidate,
          passwordValidate: passwordValidate ?? this.passwordValidate,
          bioValidate: bioValidate ?? this.bioValidate,
          isPasswordShown: isPasswordShown ?? this.isPasswordShown,
          headerDataEvent: headerDataEvent ?? this.headerDataEvent,
          logoDataEvent: logoDataEvent ?? this.logoDataEvent,
 

          isRepeatPasswordShown:
              isRepeatPasswordShown ?? this.isRepeatPasswordShown);

  @override
  List<Object> get props => [
        logoImage,
        headerImage,
        headerDataEvent,
        logoDataEvent,
        mobileCodeValidate,
        isMenSelect,
        isWomenSelect,
        isKidsSelect,
        isAnnounceShow,
        isaddressShow,
        isCustomerSelect,
        isVendorSelect,
        pagerIndex,
        errorText,
        businessNameValidate,
        lastNameValidate,
        mobileNumberValidate,
        emailValidate,
        passwordValidate,
        isPasswordShown,
        isRepeatPasswordShown,
        bioValidate,
      
      ];

  @override
  bool get stringify => true;
}
