import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sera/backend/server_response.dart';
import 'package:sera/backend/shared_web_service.dart';
import 'package:sera/helper/shared_preference_helper.dart';
import 'package:sera/ui/auth/add_address/add_address_state.dart';

class NewAddressScreenBloc extends Cubit<NewAddressScreenState> {
  final TextEditingController countryController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController address1Controller = TextEditingController();
  final TextEditingController address2Controller = TextEditingController();
  final TextEditingController houseNoController = TextEditingController();
  final SharedWebService _sharedWebService = SharedWebService.instance();

  final SharedPreferenceHelper sharedPreferenceHelper =
      SharedPreferenceHelper.instance();

  NewAddressScreenBloc() : super(const NewAddressScreenState.initial());

  void updateErrorText(String error) => emit(state.copyWith(errorText: error));

  void updateCountryValidation(bool value, String errorText) =>
      emit(state.copyWith(countryValidate: value, errorText: errorText));
  void updateStateError(bool value, String errorText) =>
      emit(state.copyWith(stateValidate: value, errorText: errorText));
  void updateCityError(bool value, String errorText) =>
      emit(state.copyWith(cityValidate: value, errorText: errorText));
  void updateAddress1Error(bool value, String errorText) =>
      emit(state.copyWith(address1Validate: value, errorText: errorText));
  void updateAddress2Error(bool value, String errorText) =>
      emit(state.copyWith(address2Validate: value, errorText: errorText));
  void updateHouseNoError(bool value, String errorText) =>
      emit(state.copyWith(houseNoValidate: value, errorText: errorText));

  void toogleHouseSelect(value) {
    emit(state.copyWith(isHouseSelect: value));
  }

  void toogleFlatSelect(value) {
    emit(state.copyWith(isFlatSelect: value));
  }

  Future<AddUserAddressResponse> addAddress() async {
    final user = await sharedPreferenceHelper.user;
    try {
      final response = await _sharedWebService.addAddress(
          country: countryController.text,
          city: cityController.text,
          address1: address1Controller.text,
          address2: address2Controller.text,
          state: stateController.text,
          appUserId: user!.id!.toString(),
          houseNumber: houseNoController.text,
          addressType: state.isHouseSelect == true ? "Home" : "Flat");
      return response;
    } catch (error) {
      log(error.toString());
      return AddUserAddressResponse(
          address: null,
          addresses: null,
          status: false,
          message: "Something Went Wrong");
    }
  }

  @override
  Future<void> close() {
    countryController.dispose();
    stateController.dispose();
    cityController.dispose();
    address1Controller.dispose();
    address2Controller.dispose();
    houseNoController.dispose();

    return super.close();
  }
}
