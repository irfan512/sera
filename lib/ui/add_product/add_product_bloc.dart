import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sera/backend/server_response.dart';
import 'package:sera/backend/shared_web_service.dart';
import 'package:sera/data/meta_data.dart';
import 'package:sera/helper/shared_preference_helper.dart';
import 'package:sera/ui/add_product/add_product_state.dart';

import 'navItems/add_options_screen.dart';

class AddProductBloc extends Cubit<AddProductState> {
  final SharedPreferenceHelper _sharedPreferenceHelper =
      SharedPreferenceHelper.instance();
  final SharedWebService _sharedWebService = SharedWebService.instance();

  final TextEditingController productNameController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController prepartionTimeController =
      TextEditingController();
  final TextEditingController daysController = TextEditingController();
  final TextEditingController infoController = TextEditingController();
  final TextEditingController chooseCollectionController =
      TextEditingController();
  final TextEditingController sortController = TextEditingController();
  final TextEditingController salePriceController = TextEditingController();
  final TextEditingController costController = TextEditingController();
  final TextEditingController barcodeController = TextEditingController();
  final TextEditingController stockSalePriceController =
      TextEditingController();
  final TextEditingController stockCostController = TextEditingController();
  final TextEditingController stockOnHandController = TextEditingController();
  final TextEditingController optionSizeController = TextEditingController();
  final TextEditingController optionColorController = TextEditingController();
  final TextEditingController optionLengthController = TextEditingController();
  final TextEditingController sizeController = TextEditingController();
  final TextEditingController colorController = TextEditingController();
  final TextEditingController lengthController = TextEditingController();
  final TextEditingController selectedCategoryid = TextEditingController();
  final TextEditingController selectedCollectionid = TextEditingController();

  final TextEditingController optionNameController = TextEditingController();

  final PageController pageSliderController = PageController();

  AddProductBloc() : super(AddProductState.initial()) {
    getCategories();
    [];
    [];
    [];
  }

  void updatePagerIndex(int index) {
    if (state.pagerIndex == index) return;
    pageSliderController.jumpToPage(index);
    emit(state.copyWith(pagerIndex: index));
  }

  void updateErrorText(String error) => emit(state.copyWith(errorText: error));

  void updateProductNameValidate(bool value, String errorText) =>
      emit(state.copyWith(productNameValidate: value, errorText: errorText));

  void updateCategoryValidate(bool value, String errorText) =>
      emit(state.copyWith(categoryValidate: value, errorText: errorText));

  void updateWeightValidate(bool value, String errorText) =>
      emit(state.copyWith(weightValidate: value, errorText: errorText));

  void updatePreparationValidate(bool value, String errorText) =>
      emit(state.copyWith(preparationValidate: value, errorText: errorText));

  void updateInfoValidate(bool value, String errorText) =>
      emit(state.copyWith(infoValidate: value, errorText: errorText));

  void updateSortValidate(bool value, String errorText) =>
      emit(state.copyWith(sortValidate: value, errorText: errorText));

  void updatePreprationTimeValidate(bool value, String errorText) => emit(
      state.copyWith(preparationTimeValidate: value, errorText: errorText));

  void updateSalePriceValidate(bool value, String errorText) =>
      emit(state.copyWith(salePriceValidate: value, errorText: errorText));

  void updateCostPriceValidate(bool value, String errorText) =>
      emit(state.copyWith(costValidation: value, errorText: errorText));

  void updateStockCostValidate(bool value, String errorText) =>
      emit(state.copyWith(costValidation: value, errorText: errorText));

  void updateStockOnHand(bool value, String errorText) =>
      emit(state.copyWith(costValidation: value, errorText: errorText));

////////////////// CHOOSE YOURSELF //////////////////////
  void toogleCustomerSelect(value) {
    emit(state.copyWith(isCustomerSelect: value));
    log(state.isCustomerSelect.toString());
  }





 void validateOptionName(bool value, String errorText) =>
      emit(state.copyWith(optionNameController: value, errorText: errorText));

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

  void updateiStockValue(value) {
    emit(state.copyWith(isStock: value));
  }

  Future<AllCategory> getCategories() async {
    final user = await _sharedPreferenceHelper.user;
    try {
      final response = await _sharedWebService.getAllCategory(
        id: user!.id,
      );
      if (response.status == true) {
        emit(state.copyWith(
          categoryData: response.categories,
        ));
      }
      return response;
    } catch (error) {
      log("$error");
      return AllCategory(
          status: false, message: "Invalid Data", categories: []);
    }
  }

  Future<GetAllCollectionsMethod> getCollections() async {
    final user = await _sharedPreferenceHelper.user;
    try {
      final response = await _sharedWebService.getCollections(
        id: user!.id,
      );
      if (response.status == true) {
        emit(state.copyWith(
          collectionData: response.collections,
        ));
      }
      return response;
    } catch (error) {
      log("$error");
      return GetAllCollectionsMethod(
          status: false, message: "Invalid Data", collections: []);
    }
  }

  bool isValidEmail(String email) {
    const pattern = r'^[\w-]+(\.[\w-]+)*@([a-zA-Z0-9-]+\.)+[a-zA-Z]{2,7}$';
    final regex = RegExp(pattern);
    return regex.hasMatch(email);
  }




  Future<IBaseResponse> addProduct() async {
    final user = await _sharedPreferenceHelper.user;
    final bool isImageSelect = state.fileDataEvent is Data;

    final productOptionsArray = state.productOptions.map((option) {
      return {
        "name": option.name,
        "productOptionStockItems": option.productOptionStockItems.map((item) {
          return {
            "value": item.value,
            "quantity": item.quantity,
          };
        }).toList(),
        "isEnabled": option.isEnabled,
      };
    }).toList();

    try {
      final response = await _sharedWebService.addProduct(
        userId: user!.id.toString(),
        name: productNameController.text,
        catergoryId: selectedCategoryid.text,
        weight: weightController.text,
        preparationTime: prepartionTimeController.text,
        preparationUnit: daysController.text,
        info: infoController.text,
        sortorder: sortController.text,
        salePrice: salePriceController.text,
        barcode: barcodeController.text,
        image: isImageSelect ? (state.fileDataEvent as Data).data.path : "",
        collectionId: selectedCollectionid.text,
        stockCost: stockCostController.text,
        stockOnHand: stockOnHandController.text,
        cost: costController.text,
        options: productOptionsArray.toString(),
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

  void handleImageSelection(XFile file) =>
      emit(state.copyWith(fileDataEvent: Data(data: file)));

  void addProductOption(ProductOption option) {
    final updatedOptions = List<ProductOption>.from(state.productOptions)
      ..add(option);
    emit(state.copyWith(productOptions: updatedOptions));
  }

  String getProductOptionsJson() {
    final Map<String, dynamic> data = {
      'productOptions':
          state.productOptions.map((option) => option.toJson()).toList(),
    };
    return jsonEncode(data);
  }

  void updateProductOption(int index, ProductOption updatedOption) {
    final updatedOptions = List<ProductOption>.from(state.productOptions);
    print('Current options: ${updatedOptions.length}, Updating index: $index');
    if (index >= 0 && index < updatedOptions.length) {
      updatedOptions[index] = updatedOption;
      print('Updated option at index $updatedOptions');
      emit(state.copyWith(productOptions: updatedOptions));
    } else {
      print('Index out of range: $index');
    }
  }

  void toggleProductOptionEnabled(int index, bool isEnabled) {
    final updatedOptions = List<ProductOption>.from(state.productOptions);
    if (index >= 0 && index < updatedOptions.length) {
      updatedOptions[index] =
          updatedOptions[index].copyWith(isEnabled: isEnabled);
      emit(state.copyWith(productOptions: updatedOptions));
    }
  }

  void addStockItemController() {
    final valueController = TextEditingController();
    final quantityController = TextEditingController();
    final updatedValueControllers =
        List<TextEditingController>.from(state.valueControllers)
          ..add(valueController);
    final updatedQuantityControllers =
        List<TextEditingController>.from(state.quantityControllers)
          ..add(quantityController);
    emit(state.copyWith(
      valueControllers: updatedValueControllers,
      quantityControllers: updatedQuantityControllers,
    ));
  }

  void removeStockItemController(int index) {
    final updatedValueControllers =
        List<TextEditingController>.from(state.valueControllers)
          ..removeAt(index);
    final updatedQuantityControllers =
        List<TextEditingController>.from(state.quantityControllers)
          ..removeAt(index);
    emit(state.copyWith(
      valueControllers: updatedValueControllers,
      quantityControllers: updatedQuantityControllers,
    ));
  }

  // void incrementAddOption(value) {
  //   emit(state.copyWith(optionvalues: value));
  // }

  @override
  Future<void> close() {
    return super.close();
  }
}
