import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sera/backend/server_response.dart';
import 'package:sera/backend/shared_web_service.dart';
import 'package:sera/data/meta_data.dart';
import 'package:sera/helper/shared_preference_helper.dart';
import 'package:sera/ui/addressess/addressess_state.dart';

class AddressessBloc extends Cubit<AddressessState> {
  AddressessBloc() : super(const AddressessState.initial());
  final SharedPreferenceHelper _sharedPreferenceHelper =
      SharedPreferenceHelper.instance();
  final SharedWebService _sharedWebService = SharedWebService.instance();
////////////////// CHOOSE YOURSELF //////////////////////
  void updateSizeIndex(value) {
    emit(state.copyWith(sizeIndex: value));
  }

  void updateLengthIndex(value) {
    emit(state.copyWith(lengthIndex: value));
  }

  Future<IBaseResponse> getAllAddress() async {
    log("afsdddddddddddddddddddd");
    final user = await _sharedPreferenceHelper.user;
    try {
      final response = await _sharedWebService.getAddress(
        id: user!.id!,
      );
      if (response.status == true) {
        emit(state.copyWith(
          addressessData: Data(data: response.addresses),
        ));
      }
      return response;
    } catch (error) {
      log(error.toString());
      return StatusMessageResponse(status: false, message: "Invalid Data");
    }
  }
}
