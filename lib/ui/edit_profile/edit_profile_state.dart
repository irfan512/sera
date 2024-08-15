import 'package:equatable/equatable.dart';
import 'package:sera/data/meta_data.dart';

class EditProfileState extends Equatable {
  final int pagerIndex;
  final String errorText;
  final bool firstNameValidate;
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
  final bool mobileCodeValidate;
  final String userImage;
  final DataEvent fileDataEvent;

  const EditProfileState({
    required this.isAnnounceShow,
    required this.fileDataEvent,

    required this.mobileCodeValidate,
    required this.isCustomerSelect,
    required this.isaddressShow,
    required this.isVendorSelect,
    required this.pagerIndex,
    required this.errorText,
    required this.firstNameValidate,
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
    required this.userImage,
  });

  const EditProfileState.initial()
      : this(
          mobileCodeValidate: false,
          fileDataEvent: const Initial(),
          pagerIndex: 0,
          isAnnounceShow: false,
          isaddressShow: false,
          isCustomerSelect: false,
          isVendorSelect: false,
          errorText: '',
          firstNameValidate: false,
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
          userImage: "",
        );

  EditProfileState copyWith({
    bool? isWomenSelect,
    bool? mobileCodeValidate,
    bool? isMenSelect,
    bool? isKidsSelect,
    bool? isCustomerSelect,
    bool? isAnnounceShow,
    bool? isVendorSelect,
    int? pagerIndex,
    String? errorText,
    bool? firstNameValidate,
    bool? lastNameValidate,
    bool? mobileNumberValidate,
    bool? emailValidate,
    bool? passwordValidate,
    bool? confirmPasswordValidate,
    bool? isPasswordShown,
    bool? isRepeatPasswordShown,
    bool? isaddressShow,
    String? userImage,
    DataEvent? fileDataEvent,
  }) =>
      EditProfileState(
          isWomenSelect: isWomenSelect ?? this.isWomenSelect,
          fileDataEvent: fileDataEvent ?? this.fileDataEvent,

          mobileCodeValidate: mobileCodeValidate ?? this.mobileCodeValidate,
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
          emailValidate: emailValidate ?? this.emailValidate,
          passwordValidate: passwordValidate ?? this.passwordValidate,
          confirmPasswordValidate:
              confirmPasswordValidate ?? this.confirmPasswordValidate,
          isPasswordShown: isPasswordShown ?? this.isPasswordShown,
          userImage: userImage ?? this.userImage,
          isRepeatPasswordShown:
              isRepeatPasswordShown ?? this.isRepeatPasswordShown);

  @override
  List<Object> get props => [
        mobileCodeValidate,
        fileDataEvent,
        userImage,
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
        emailValidate,
        passwordValidate,
        isPasswordShown,
        isRepeatPasswordShown,
        confirmPasswordValidate
      ];

  @override
  bool get stringify => true;
}
