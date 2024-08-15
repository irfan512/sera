import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:sera/backend/server_response.dart';
import 'package:sera/data/meta_data.dart';

import 'navItems/add_options_screen.dart';

class AddProductState extends Equatable {
  final int pagerIndex;
  final String errorText;
  final bool productNameValidate;
  final bool categoryValidate;
  final bool weightValidate;
  final bool preparationValidate;
  final bool preparationTimeValidate;
  final bool infoValidate;
  final bool passwordValidate;
  final bool sortValidate;
  final bool salePriceValidate;
  final bool costValidation;
  final bool isCustomerSelect;
  final bool isVendorSelect;
  final bool isaddressShow;
  final bool isAnnounceShow;
  final bool isWomenSelect;
  final bool isKidsSelect;
  final bool isMenSelect;
  final bool isStock;
  final bool stockOnHandValidate;
  final bool stockCostValidate;
  final DataEvent fileDataEvent;
  final List<AllCategoriesModel> categoryData;
  final List<AllCollectionsModel> collectionData;
  final List<ProductOption> productOptions;
  final List<TextEditingController> valueControllers;
  final List<TextEditingController> quantityControllers;
  final bool optionNameController;

  const AddProductState({
    required this.valueControllers,
    required this.quantityControllers,
    required this.productOptions,
    required this.isAnnounceShow,
    required this.fileDataEvent,
    required this.isStock,
    required this.isCustomerSelect,
    required this.isaddressShow,
    required this.isVendorSelect,
    required this.pagerIndex,
    required this.errorText,
    required this.productNameValidate,
    required this.categoryValidate,
    required this.weightValidate,
    required this.preparationValidate,
    required this.preparationTimeValidate,
    required this.infoValidate,
    required this.passwordValidate,
    required this.sortValidate,
    required this.salePriceValidate,
    required this.costValidation,
    required this.isWomenSelect,
    required this.isKidsSelect,
    required this.isMenSelect,
    required this.stockOnHandValidate,
    required this.stockCostValidate,
    required this.categoryData,
    required this.collectionData,
    required this.optionNameController,
  });

  AddProductState.initial()
      : this(
            pagerIndex: 0,
            fileDataEvent: const Initial(),
            productOptions: [],
            valueControllers: [],
            quantityControllers: [],
            isStock: false,
            isAnnounceShow: false,
            isaddressShow: false,
            isCustomerSelect: false,
            isVendorSelect: false,
            errorText: '',
            productNameValidate: false,
            categoryValidate: false,
            weightValidate: false,
            preparationValidate: false,
            preparationTimeValidate: false,
            infoValidate: false,
            passwordValidate: false,
            sortValidate: false,
            salePriceValidate: false,
            costValidation: false,
            isWomenSelect: false,
            isMenSelect: false,
            isKidsSelect: false,
            stockCostValidate: false,
            stockOnHandValidate: false,
            optionNameController: false,
            categoryData: [],
            collectionData: []);

  AddProductState copyWith({
    bool? isWomenSelect,
    bool? isStock,
    bool? isMenSelect,
    bool? isKidsSelect,
    bool? isCustomerSelect,
    bool? isAnnounceShow,
    bool? isVendorSelect,
    int? pagerIndex,
    String? errorText,
    bool? productNameValidate,
    bool? categoryValidate,
    bool? weightValidate,
    bool? preparationValidate,
    bool? preparationTimeValidate,
    bool? infoValidate,
    bool? passwordValidate,
    bool? sortValidate,
    bool? salePriceValidate,
    bool? costValidation,
    bool? isaddressShow,
    bool? stockOnHandValidate,
    bool? stockCostValidate,
    DataEvent? fileDataEvent,
    List<AllCategoriesModel>? categoryData,
    List<AllCollectionsModel>? collectionData,
    List<ProductOption>? productOptions,
    List<TextEditingController>? valueControllers,
    List<TextEditingController>? quantityControllers,
    bool? optionNameController,
  }) =>
      AddProductState(
        valueControllers: valueControllers ?? this.valueControllers,
        quantityControllers: quantityControllers ?? this.quantityControllers,
        productOptions: productOptions ?? this.productOptions,
        collectionData: collectionData ?? this.collectionData,
        fileDataEvent: fileDataEvent ?? this.fileDataEvent,
        isWomenSelect: isWomenSelect ?? this.isWomenSelect,
        isStock: isStock ?? this.isStock,
        stockOnHandValidate: stockOnHandValidate ?? this.stockOnHandValidate,
        stockCostValidate: stockCostValidate ?? this.stockCostValidate,
        isMenSelect: isMenSelect ?? this.isMenSelect,
        isKidsSelect: isKidsSelect ?? this.isKidsSelect,
        isAnnounceShow: isAnnounceShow ?? this.isAnnounceShow,
        isaddressShow: isaddressShow ?? this.isaddressShow,
        isCustomerSelect: isCustomerSelect ?? this.isCustomerSelect,
        isVendorSelect: isVendorSelect ?? this.isVendorSelect,
        pagerIndex: pagerIndex ?? this.pagerIndex,
        errorText: errorText ?? this.errorText,
        productNameValidate: productNameValidate ?? this.productNameValidate,
        categoryValidate: categoryValidate ?? this.categoryValidate,
        weightValidate: weightValidate ?? this.weightValidate,
        preparationValidate: preparationValidate ?? this.preparationValidate,
        preparationTimeValidate:
            preparationTimeValidate ?? this.preparationTimeValidate,
        infoValidate: infoValidate ?? this.infoValidate,
        passwordValidate: passwordValidate ?? this.passwordValidate,
        sortValidate: sortValidate ?? this.sortValidate,
        salePriceValidate: salePriceValidate ?? this.salePriceValidate,
        categoryData: categoryData ?? this.categoryData,
        costValidation: costValidation ?? this.costValidation,
        optionNameController: optionNameController ?? this.optionNameController,
      );

  @override
  List<Object> get props => [
        valueControllers,
        quantityControllers,
        productOptions,
        categoryData,
        collectionData,
        stockCostValidate,
        fileDataEvent,
        stockOnHandValidate,
        isStock,
        isMenSelect,
        isWomenSelect,
        isKidsSelect,
        isAnnounceShow,
        isaddressShow,
        isCustomerSelect,
        isVendorSelect,
        pagerIndex,
        errorText,
        productNameValidate,
        categoryValidate,
        weightValidate,
        preparationValidate,
        preparationTimeValidate,
        infoValidate,
        passwordValidate,
        salePriceValidate,
        costValidation,
        sortValidate,
        optionNameController,
      ];

  @override
  bool get stringify => true;
}
