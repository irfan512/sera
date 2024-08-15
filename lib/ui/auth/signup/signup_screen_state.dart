import 'package:equatable/equatable.dart';
import 'package:sera/backend/server_response.dart';
import 'package:sera/data/meta_data.dart';

class SignupScreenState extends Equatable {
  final int pagerIndex;
  final String errorText;
  final bool firstNameValidate;
  final bool lastNameValidate;
  final bool mobileNumberValidate;
  final bool salognNameValidate;
  final bool brandNameValidate;
  final bool emailValidate;
  final bool passwordValidate;
  final bool phoneCodeValidate;
  final bool isPasswordShown;
  final bool isRepeatPasswordShown;
  final bool isCustomerSelect;
  final bool isVendorSelect;
  final bool isaddressShow;
  final bool isAnnounceShow;
  final bool isWomenSelect;
  final bool isKidsSelect;
  final bool isMenSelect;
  final DataEvent fileDataEvent;
  final String userImage;
  final List<AddressModel> userAddress;

  const SignupScreenState({
    required this.isAnnounceShow,
    required this.userImage,
    required this.isCustomerSelect,
    required this.isaddressShow,
    required this.isVendorSelect,
    required this.pagerIndex,
    required this.errorText,
    required this.firstNameValidate,
    required this.lastNameValidate,
    required this.mobileNumberValidate,
    required this.salognNameValidate,
    required this.brandNameValidate,
    required this.emailValidate,
    required this.passwordValidate,
    required this.phoneCodeValidate,
    required this.isPasswordShown,
    required this.isRepeatPasswordShown,
    required this.isWomenSelect,
    required this.isKidsSelect,
    required this.isMenSelect,
    required this.fileDataEvent,
    required this.userAddress,
  });

  SignupScreenState.initial()
      : this(
          pagerIndex: 0,
          userImage: "",
          isAnnounceShow: false,
          isaddressShow: false,
          isCustomerSelect: false,
          isVendorSelect: false,
          errorText: '',
          firstNameValidate: false,
          lastNameValidate: false,
          mobileNumberValidate: false,
          salognNameValidate: false,
          brandNameValidate: false,
          emailValidate: false,
          passwordValidate: false,
          phoneCodeValidate: false,
          isPasswordShown: false,
          isRepeatPasswordShown: false,
          isWomenSelect: false,
          isMenSelect: false,
          isKidsSelect: false,
          fileDataEvent: const Initial(),
          userAddress: [],
        );

  SignupScreenState copyWith({
    bool? isWomenSelect,
    bool? isMenSelect,
    bool? isKidsSelect,
    bool? isCustomerSelect,
    bool? isAnnounceShow,
    bool? isVendorSelect,
    int? pagerIndex,
    String? errorText,
    String? userImage,
    bool? firstNameValidate,
    bool? lastNameValidate,
    bool? mobileNumberValidate,
    bool? salognNameValidate,
    bool? brandNameValidate,
    bool? emailValidate,
    bool? passwordValidate,
    bool? phoneCodeValidate,
    bool? isPasswordShown,
    bool? isRepeatPasswordShown,
    bool? isaddressShow,
    DataEvent? fileDataEvent,
    List<AddressModel>? userAddress,
  }) =>
      SignupScreenState(
          userAddress: userAddress ?? this.userAddress,
          isWomenSelect: isWomenSelect ?? this.isWomenSelect,
          userImage: userImage ?? this.userImage,
          fileDataEvent: fileDataEvent ?? this.fileDataEvent,
          isMenSelect: isMenSelect ?? this.isMenSelect,
          isKidsSelect: isKidsSelect ?? this.isKidsSelect,
          isAnnounceShow: isAnnounceShow ?? this.isAnnounceShow,
          isaddressShow: isaddressShow ?? this.isaddressShow,
          isCustomerSelect: isCustomerSelect ?? this.isCustomerSelect,
          isVendorSelect: isVendorSelect ?? this.isVendorSelect,
          pagerIndex: pagerIndex ?? this.pagerIndex,
          errorText: errorText ?? this.errorText,
          firstNameValidate: firstNameValidate ?? this.firstNameValidate,
          lastNameValidate: lastNameValidate ?? this.lastNameValidate,
          mobileNumberValidate:
              mobileNumberValidate ?? this.mobileNumberValidate,
          salognNameValidate: salognNameValidate ?? this.salognNameValidate,
          brandNameValidate: brandNameValidate ?? this.brandNameValidate,
          emailValidate: emailValidate ?? this.emailValidate,
          passwordValidate: passwordValidate ?? this.passwordValidate,
          phoneCodeValidate: phoneCodeValidate ?? this.phoneCodeValidate,
          isPasswordShown: isPasswordShown ?? this.isPasswordShown,
          isRepeatPasswordShown:
              isRepeatPasswordShown ?? this.isRepeatPasswordShown);

  @override
  List<Object> get props => [
        userAddress,
        userImage,
        fileDataEvent,
        isMenSelect,
        isWomenSelect,
        isKidsSelect,
        isAnnounceShow,
        isaddressShow,
        isCustomerSelect,
        isVendorSelect,
        pagerIndex,
        errorText,
        firstNameValidate,
        lastNameValidate,
        mobileNumberValidate,
        salognNameValidate,
        brandNameValidate,
        emailValidate,
        passwordValidate,
        isPasswordShown,
        isRepeatPasswordShown,
        phoneCodeValidate
      ];

  @override
  bool get stringify => true;
}
