import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sera/backend/server_response.dart';
import 'package:sera/backend/shared_web_service.dart';
import 'package:sera/helper/shared_preference_helper.dart';
import 'package:sera/ui/auth/login/login_screen_state.dart';

class LoginScreenBloc extends Cubit<LoginScreenState> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController resetEmailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final SharedWebService _sharedWebService = SharedWebService.instance();

  LoginScreenBloc() : super(const LoginScreenState.initial());

  void updateErrorText(String error) => emit(state.copyWith(errorText: error));

  void updateEmailValidation(bool value, String errorText) =>
      emit(state.copyWith(emailValidate: value, errorText: errorText));

  void updatePasswordError(bool value, String errorText) =>
      emit(state.copyWith(passwordError: value, errorText: errorText));

  void togglePasswordVisibilityState() =>
      emit(state.copyWith(isPasswordShown: !state.isPasswordShown));

  Future<IBaseResponse> login() async {
    final String email = emailController.text;
    final String password = passwordController.text;
    try {
      final response = await _sharedWebService.login(
        email: email,
        password: password,
      );
      if (response.status == true && response.user != null) {
        await SharedPreferenceHelper.instance().insertUser(response.user!);
        await SharedPreferenceHelper.instance()
            .setUserType(response.user!.userType!);
      }
      return response;
    } catch (error) {
      log(error.toString());
      return StatusMessageResponse(status: false, message: "Invalid Data");
    }
  }



  Future<IBaseResponse> socialLogin(token, provider) async {
    try {
      final response = await _sharedWebService.socialLogin(
        token: token,
        provider: provider,
      );
      if (response.status == true && response.user != null) {
        await SharedPreferenceHelper.instance().insertUser(response.user!);
        await SharedPreferenceHelper.instance()
            .setUserType(response.user!.userType!);
      }
      return response;
    } catch (error) {
      log(error.toString());
      return StatusMessageResponse(status: false, message: "Invalid Data");
    }
  }




  bool isValidEmail(String email) {
    const pattern = r'^[\w-]+(\.[\w-]+)*@([a-zA-Z0-9-]+\.)+[a-zA-Z]{2,7}$';
    final regex = RegExp(pattern);
    return regex.hasMatch(email);
  }




  @override
  Future<void> close() {
    emailController.dispose();
    passwordController.dispose();
    return super.close();
  }
}
