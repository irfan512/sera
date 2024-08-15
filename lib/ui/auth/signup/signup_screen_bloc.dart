import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sera/backend/server_response.dart';
import 'package:sera/backend/shared_web_service.dart';
import 'package:sera/data/meta_data.dart';
import 'package:sera/helper/shared_preference_helper.dart';
import 'package:sera/ui/auth/signup/signup_screen_state.dart';

class SignupScreenBloc extends Cubit<SignupScreenState> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController mobileNumberController = TextEditingController();
  final TextEditingController mobileCodeController = TextEditingController();
  final TextEditingController companyNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController brandController = TextEditingController();
  final TextEditingController salognController = TextEditingController();
  final TextEditingController announceController = TextEditingController();

  final SharedWebService _sharedWebService = SharedWebService.instance();

  final PageController pageSliderController = PageController();

  SignupScreenBloc() : super(SignupScreenState.initial());

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

  void updateSaloganValidate(bool value, String errorText) =>
      emit(state.copyWith(salognNameValidate: value, errorText: errorText));

  void updateBrandValidate(bool value, String errorText) =>
      emit(state.copyWith(brandNameValidate: value, errorText: errorText));

  void updatePasswordValidate(bool value, String errorText) =>
      emit(state.copyWith(passwordValidate: value, errorText: errorText));

  void updateMobileCodeValidate(bool value, String errorText) =>
      emit(state.copyWith(phoneCodeValidate: value, errorText: errorText));

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

  void addUserAddressInState(AddressModel newAddress) {
    final updatedUserAddress = List<AddressModel>.from(state.userAddress)
      ..add(newAddress);

    emit(state.copyWith(userAddress: updatedUserAddress));
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
    const pattern = r'^[\w-]+(\.[\w-]+)*@([a-zA-Z0-9-]+\.)+[a-zA-Z]{2,7}$';
    final regex = RegExp(pattern);
    return regex.hasMatch(email);
  }

  void handleImageSelection(XFile file) =>
      emit(state.copyWith(fileDataEvent: Data(data: file)));

  Future<IBaseResponse> vendorRegister() async {
    final bool isbrandLogoSelected = state.fileDataEvent is Data;
    try {
      final response = await _sharedWebService.vendorSignup(
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        email: emailController.text,
        phoneNumber: mobileNumberController.text,
        countryCode: mobileCodeController.text,
        password: passwordController.text,
        brandName: brandController.text,
        slogan: salognController.text,
        brandLogoPath:
            isbrandLogoSelected ? (state.fileDataEvent as Data).data.path : "",
        targetAudience: state.isMenSelect == true
            ? "Men"
            : state.isKidsSelect == true
                ? "Kids"
                : state.isWomenSelect == true
                    ? "Women"
                    : "",
      );
      if (response.status == true && response.user != null) {
        await SharedPreferenceHelper.instance().insertUser(response.user!);
        await SharedPreferenceHelper.instance()
            .setUserType(response.user!.userType!);
      }
      return response;
    } catch (error) {
      return StatusMessageResponse(status: false, message: "Invalid Data");
    }
  }

  Future<IBaseResponse> customerRegister() async {
    try {
      final response = await _sharedWebService.customerSignup(
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        email: emailController.text,
        phoneNumber:mobileNumberController.text,
        countryCode: mobileCodeController.text,
        password: passwordController.text,
      );
      if (response.status == true && response.user != null) {
        await SharedPreferenceHelper.instance().insertUser(response.user!);
        await SharedPreferenceHelper.instance()
            .setUserType(response.user!.userType!);
      }
      return response;
    } catch (error) {
      log(error.toString());
      return StatusMessageResponse(
          status: false, message: "Something went wrong");
    }
  }

  @override
  Future<void> close() {
    brandController.dispose();
    salognController.dispose();
    return super.close();
  }
}
