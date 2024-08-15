import 'package:equatable/equatable.dart';

class LoginScreenState extends Equatable {
  final String errorText;
  final bool emailValidate;
  final bool passwordError;
  final bool isPasswordShown;
  final bool isSaveCheck;

  const LoginScreenState(
      {required this.errorText,
        required this.passwordError,
        required this.isPasswordShown,
        required this.isSaveCheck,
        required this.emailValidate});

  const LoginScreenState.initial()
      : this(
      errorText: '',
      passwordError: false,
      isPasswordShown: false,
      isSaveCheck: false,
      emailValidate: false);

  LoginScreenState copyWith(
      {bool? passwordError,
        String? errorText,
        bool? isPasswordShown,
        bool? isSaveCheck,
        bool? emailValidate}) =>
      LoginScreenState(
          errorText: errorText ?? this.errorText,
          passwordError: passwordError ?? this.passwordError,
          isSaveCheck: isSaveCheck ?? this.isSaveCheck,
          emailValidate: emailValidate ?? this.emailValidate,
          isPasswordShown: isPasswordShown ?? this.isPasswordShown);

  @override
  List<Object> get props =>
      [emailValidate, passwordError, isPasswordShown, errorText, isSaveCheck];

  @override
  bool get stringify => true;
}
