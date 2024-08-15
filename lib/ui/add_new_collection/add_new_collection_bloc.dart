import 'dart:developer';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sera/backend/server_response.dart';
import 'package:sera/backend/shared_web_service.dart';
import 'package:sera/data/meta_data.dart';
import 'package:sera/helper/shared_preference_helper.dart';
import 'package:sera/ui/add_new_collection/add_new_collection_state.dart';

class AddCollectionBloc extends Cubit<AddCollectionState> {
  final TextEditingController collectionNameController =
      TextEditingController();

  final PageController pageSliderController = PageController();
  SharedWebService _sharedWebService = SharedWebService.instance();
 final SharedPreferenceHelper sharedPreferenceHelper =
      SharedPreferenceHelper.instance();

  AddCollectionBloc() : super(const AddCollectionState.initial());

  void updateErrorText(String error) => emit(state.copyWith(errorText: error));

  void updateCollectionNameValidate(bool value, String errorText) =>
      emit(state.copyWith(collectionNameValidate: value, errorText: errorText));

  void updateBusinessNameValidate(bool value, String errorText) =>
      emit(state.copyWith(collectionNameValidate: value, errorText: errorText));

  void handleImageSelection(XFile file) =>
      emit(state.copyWith(fileDataEvent: Data(data: file)));

  Future<IBaseResponse> addCollection() async {
    final bool isbrandLogoSelected = state.fileDataEvent is Data;
    final user = await sharedPreferenceHelper.user;

    try {
      final response = await _sharedWebService.addNewCollection(
        appUserId:user!.id!,
        name: collectionNameController.text,
        imagePath:
            isbrandLogoSelected ? (state.fileDataEvent as Data).data.path : "",
      );
      if (response.status == true) {}
      return response;
    } catch (error) {
      log(error.toString());
      return StatusMessageResponse(status: false, message: "Invalid Data");
    }
  }








  @override
  Future<void> close() {
    collectionNameController.clear();
    return super.close();
  }
}
