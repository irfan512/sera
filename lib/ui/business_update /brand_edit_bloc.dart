import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:developer';
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
import 'package:sera/ui/business_update%20/brand_edit_state.dart';
import 'package:sera/util/app_strings.dart';

class EditBrandBloc extends Cubit<EditBrandState> {
  final TextEditingController businessNameController = TextEditingController();
  final TextEditingController bioController = TextEditingController();
  final TextEditingController mobileNumberController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController mobileCodeController = TextEditingController();
  final PageController pageSliderController = PageController();

  EditBrandBloc() : super(EditBrandState.initial()) {
    getUserFromSharedPref();
  }

  final SharedPreferenceHelper sharedPreferenceHelper =
      SharedPreferenceHelper.instance();
  final SharedWebService _sharedWebService = SharedWebService.instance();

  DialogHelper get _dialogHelper => DialogHelper.instance();

  SnackbarHelper get _snackbarHelper => SnackbarHelper.instance();

  void updatePagerIndex(int index) {
    if (state.pagerIndex == index) return;
    pageSliderController.jumpToPage(index);
    emit(state.copyWith(pagerIndex: index));
  }

  Future<void> getUserFromSharedPref() async {
    final user = await sharedPreferenceHelper.user;
    if (user == null) return;
    log("Gggggggggggggggggggggggggg${user.countryCode}");
    businessNameController.text = user.appUserBrand!.brandName ?? "";
    bioController.text = user.appUserBrand!.bio ?? "";
    emailController.text = user.appUserBrand!.email ?? "";
    mobileNumberController.text = user.appUserBrand!.phoneNumber ?? "";
    mobileCodeController.text = user.appUserBrand!.countryCode ?? "";
    emit(state.copyWith(
      logoImage: user.appUserBrand!.logoUrl,
      headerImage: user.appUserBrand!.headerUrl!,
    ));
  }

  void updateErrorText(String error) => emit(state.copyWith(errorText: error));

  void updateEmailValidate(bool value, String errorText) =>
      emit(state.copyWith(emailValidate: value, errorText: errorText));
  void updateMobileCodeValidate(bool value, String errorText) =>
      emit(state.copyWith(mobileCodeValidate: value, errorText: errorText));

  void updateBusinessNameValidate(bool value, String errorText) =>
      emit(state.copyWith(businessNameValidate: value, errorText: errorText));

  void updateBioValidate(bool value, String errorText) =>
      emit(state.copyWith(bioValidate: value, errorText: errorText));

  void updateMobileNumberValidate(bool value, String errorText) =>
      emit(state.copyWith(mobileNumberValidate: value, errorText: errorText));

  void updatePasswordValidate(bool value, String errorText) =>
      emit(state.copyWith(passwordValidate: value, errorText: errorText));

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

  void handleLogoSelection(XFile file) =>
      emit(state.copyWith(logoDataEvent: Data(data: file)));

  void handleHeaderSelection(XFile file) =>
      emit(state.copyWith(headerDataEvent: Data(data: file)));

  Future<void> updateBrand(EditBrandBloc bloc, BuildContext context,
      DialogHelper dialogHelper) async {
    dialogHelper
      ..injectContext(context)
      ..showProgressDialog(AppStrings.UPDATING_PROFILE);
    try {
      final previousUser = await sharedPreferenceHelper.user;
      if (previousUser == null) throw const IdNotFoundException();
      final bool isLogoImageSelected = state.logoDataEvent is Data;
      final bool isHeaderImageSelected = state.headerDataEvent is Data;
      // final userType = userRoles.entries.firstWhere(
      //   (entry) => entry.value == usertypeController.text,
      //   orElse: () => MapEntry(-1, ''),
      // );
      final response = await _sharedWebService.updateBrand(
        previousUser.appUserBrand!.id.toString(),
        businessNameController.text,
        bioController.text,
        mobileCodeController.text,
        mobileNumberController.text,
        emailController.text,
        isHeaderImageSelected ? (state.headerDataEvent as Data).data.path : "",
        isLogoImageSelected ? (state.logoDataEvent as Data).data.path : "",
      );
      if (response.status == true) {
        final newData = previousUser.copyWith(
          appUserBrand: response.brand!,
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
    return super.close();
  }
}
