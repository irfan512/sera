// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sera/backend/shared_web_service.dart';
import 'package:sera/data/exception.dart';
import 'package:sera/data/meta_data.dart';
import 'package:sera/data/snackbar_message.dart';
import 'package:sera/extensions/context_extension.dart';
import 'package:sera/helper/dialog_helper.dart';
import 'package:sera/helper/shared_preference_helper.dart';
import 'package:sera/helper/snackbar_helper.dart';
import 'package:sera/ui/edit_profile/edit_profile_state.dart';
import 'package:sera/util/app_strings.dart';

class EditProfileBloc extends Cubit<EditProfileState> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController mobileNumberController = TextEditingController();
  final TextEditingController mobileCodeController = TextEditingController();
  final TextEditingController companyNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController brandController = TextEditingController();
  final TextEditingController salognController = TextEditingController();

  final SharedPreferenceHelper sharedPreferenceHelper =
      SharedPreferenceHelper.instance();
  final SharedWebService _sharedWebService = SharedWebService.instance();

  DialogHelper get _dialogHelper => DialogHelper.instance();

  SnackbarHelper get _snackbarHelper => SnackbarHelper.instance();

  final PageController pageSliderController = PageController();

  EditProfileBloc() : super(const EditProfileState.initial()) {
    getUserFromSharedPref();
  }

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

  void updatePasswordValidate(bool value, String errorText) =>
      emit(state.copyWith(passwordValidate: value, errorText: errorText));

  void updateConfirmPasswordValidate(bool value, String errorText) => emit(
      state.copyWith(confirmPasswordValidate: value, errorText: errorText));

  void updateMobileCodeValidate(bool value, String errorText) =>
      emit(state.copyWith(mobileCodeValidate: value, errorText: errorText));

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

  void handleImageSelection(XFile file) =>
      emit(state.copyWith(fileDataEvent: Data(data: file)));

  Future<void> getUserFromSharedPref() async {
    final user = await sharedPreferenceHelper.user;
    if (user == null) return;
    log("Gggggggggggggggggggggggggg${user.countryCode}");
    firstNameController.text = user.firstName ?? "";
    lastNameController.text = user.lastName ?? "";
    emailController.text = user.email ?? "";
    mobileNumberController.text = user.phoneNumber ?? "";
    mobileCodeController.text = user.countryCode ?? "";
    emit(state.copyWith(
      userImage: user.profileImage!,
    ));
  }

  Future<void> updateProfile(EditProfileBloc bloc, BuildContext context,
      DialogHelper dialogHelper) async {
    dialogHelper
      ..injectContext(context)
      ..showProgressDialog(AppStrings.UPDATING_PROFILE);
    try {
      final previousUser = await sharedPreferenceHelper.user;
      if (previousUser == null) throw const IdNotFoundException();
      final bool isProfileImageSelected = state.fileDataEvent is Data;
      // final userType = userRoles.entries.firstWhere(
      //   (entry) => entry.value == usertypeController.text,
      //   orElse: () => MapEntry(-1, ''),
      // );
      final response = await _sharedWebService.updateProfile(
        previousUser.id.toString(),
        firstNameController.text,
        lastNameController.text,
        mobileCodeController.text,
        mobileNumberController.text,
        emailController.text,
        isProfileImageSelected ? (state.fileDataEvent as Data).data.path : "",
      );
      if (response.status == true) {
        final newData = previousUser.copyWith(
          firstName: response.user?.firstName!,
          lastName: response.user?.lastName!,
          email: response.user?.email!,
          phoneNumber: response.user?.phoneNumber!,
          profileImage: response.user?.profileImage!,
          countryCode: response.user?.countryCode!,
        );
        await sharedPreferenceHelper.insertUser(newData);
        dialogHelper.dismissProgress();
        _snackbarHelper
          ..injectContext(context)
          ..showSnackbar(
            snackbarMessage: const SnackbarMessage.smallMessage(
                content: AppStrings.PROFILE_UPDATED),
            margin: EdgeInsets.only(
                left: 25,
                right: 25,
                bottom: context.isHaveBottomNotch ? 100 : 90),
          );
      } else {
        dialogHelper.dismissProgress();
        _snackbarHelper
          ..injectContext(context)
          ..showSnackbar(
            snackbarMessage:
                SnackbarMessage.smallMessageError(content: response.message),
            margin: EdgeInsets.only(
                left: 25,
                right: 25,
                bottom: context.isHaveBottomNotch ? 100 : 90),
          );
      }
    } catch (_) {
      log(_.toString());
      dialogHelper.dismissProgress();
    }
  }

  @override
  Future<void> close() {
    brandController.dispose();
    salognController.dispose();
    return super.close();
  }
}
