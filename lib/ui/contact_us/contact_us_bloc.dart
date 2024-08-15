import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sera/backend/server_response.dart';
import 'package:sera/backend/shared_web_service.dart';
import 'package:sera/helper/shared_preference_helper.dart';
import 'package:sera/ui/contact_us/contact_us_state.dart';

class ContactUsBloc extends Cubit<ContactUsState> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController messageController = TextEditingController();

  final SharedPreferenceHelper _sharedPreferenceHelper =
      SharedPreferenceHelper.instance();
  final SharedWebService _sharedWebService = SharedWebService.instance();
  ContactUsBloc() : super(const ContactUsState.initial());

  void updateErrorText(String error) => emit(state.copyWith(errorText: error));

  void updateEmailValidate(bool value, String errorText) =>
      emit(state.copyWith(emailValidate: value, errorText: errorText));

  void updateMessageValidate(bool value, String errorText) =>
      emit(state.copyWith(messageValidate: value, errorText: errorText));

  bool isValidEmail(String email) {
    // Regular expression pattern for email validation
    const pattern = r'^[\w-]+(\.[\w-]+)*@([a-zA-Z0-9-]+\.)+[a-zA-Z]{2,7}$';

    // Create a RegExp object from the pattern
    final regex = RegExp(pattern);

    // Check if the email matches the pattern
    return regex.hasMatch(email);
  }

  

  Future<IBaseResponse> contactUs() async {
    final String email = emailController.text;
    final String message = messageController.text;
    final user = await _sharedPreferenceHelper.user;
    try {
      final response = await _sharedWebService.contactUs(
        email: email,
        message: message,
        userId: user!.id!,
      );
      if (response.status == true) {
        return response;
      }
      return response;
    } catch (error) {
      return StatusMessageResponse(status: false, message: "Invalid Data");
    }
  }

  @override
  Future<void> close() {
    emailController.dispose();
    messageController.dispose();
    return super.close();
  }
}
