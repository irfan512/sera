import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sera/ui/cart_checkout/cart_checkout_state.dart';

class CartCheckoutBloc extends Cubit<CartCheckoutState> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController mobileNumberController = TextEditingController();
  final TextEditingController companyNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController brandController = TextEditingController();
  final TextEditingController salognController =
      TextEditingController();



  final PageController pageSliderController = PageController();

  CartCheckoutBloc() : super(const CartCheckoutState.initial());

  void updatePagerIndex(int index) {
    if (state.pagerIndex == index) return;
    pageSliderController.jumpToPage(index);
    emit(state.copyWith(pagerIndex: index));
  }

  void updateErrorText(String error) => emit(state.copyWith(errorText: error));

  void updateEmailValidate(bool value, String errorText) =>
      emit(state.copyWith(emailValidate: value, errorText: errorText));

  void updateFirstNameValidate(bool value, String errorText) =>
      emit(state.copyWith(firstNameValidate: value, errorText: errorText));

  void updateLastNameValidate(bool value, String errorText) =>
      emit(state.copyWith(lastNameValidate: value, errorText: errorText));

  void updateMobileNumberValidate(bool value, String errorText) =>
      emit(state.copyWith(mobileNumberValidate: value, errorText: errorText));

  void updateCompanyNameValidate(bool value, String errorText) =>
      emit(state.copyWith(companyNameValidate: value, errorText: errorText));

  void updateJobTitleValidate(bool value, String errorText) =>
      emit(state.copyWith(jobTitleValidate: value, errorText: errorText));

  void updatePasswordValidate(bool value, String errorText) =>
      emit(state.copyWith(passwordValidate: value, errorText: errorText));

  void updateConfirmPasswordValidate(bool value, String errorText) => emit(
      state.copyWith(confirmPasswordValidate: value, errorText: errorText));

  void togglePasswordVisibilityState() =>
      emit(state.copyWith(isPasswordShown: !state.isPasswordShown));

  void toggleRepeatPasswordVisibilityState() =>
      emit(state.copyWith(isRepeatPasswordShown: !state.isRepeatPasswordShown));

////////////////// CHOOSE YOURSELF //////////////////////
  void toogleCustomerSelect(value) {
    emit(state.copyWith(isCustomerSelect: value));
    log(state.isCustomerSelect.toString());
  }

  void toogleVendorSelect(value) {
    emit(state.copyWith(isVendorSelect: value));
  }

  void toogleAddressShow(value) {
    emit(state.copyWith(isaddressShow: value));
  }

  void updateAnnouncePage(value) {
    emit(state.copyWith(isAnnounceShow: value));
  }

  void updateWomenValue(value) {
    emit(state.copyWith(isWomenSelect: value));
  }

  void updateMenValue(value) {
    emit(state.copyWith(isMenSelect: value));
  }

  void updateKidValue(value) {
    emit(state.copyWith(isKidsSelect: value));
  }

  bool isValidEmail(String email) {
    // Regular expression pattern for email validation
    const pattern = r'^[\w-]+(\.[\w-]+)*@([a-zA-Z0-9-]+\.)+[a-zA-Z]{2,7}$';

    // Create a RegExp object from the pattern
    final regex = RegExp(pattern);

    // Check if the email matches the pattern
    return regex.hasMatch(email);
  }

  @override
  Future<void> close() {
    brandController.dispose();
    salognController.dispose();
    return super.close();
  }
}
