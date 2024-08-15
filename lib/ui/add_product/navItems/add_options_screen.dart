import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sera/extensions/context_extension.dart';
import 'package:sera/ui/add_product/add_product_bloc.dart';
import 'package:sera/ui/add_product/add_product_state.dart';
import 'package:sera/ui/common/app_button.dart';
import 'package:sera/ui/common/app_text_field.dart';
import 'package:sera/util/app_strings.dart';

class ProductOption {
  String name;
  List<ProductOptionStockItem> productOptionStockItems;
  bool isEnabled;
  ProductOption(
      {required this.name,
      required this.productOptionStockItems,
      required this.isEnabled});
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'productOptionStockItems':
          productOptionStockItems.map((item) => item.toJson()).toList(),
      'isEnabled': isEnabled,
    };
  }

  ProductOption copyWith({
    String? name,
    List<ProductOptionStockItem>? productOptionStockItems,
    bool? isEnabled,
  }) {
    return ProductOption(
      name: name ?? this.name,
      productOptionStockItems:
          productOptionStockItems ?? this.productOptionStockItems,
      isEnabled: isEnabled ?? this.isEnabled,
    );
  }
}

class ProductOptionStockItem {
  String value;
  int quantity;

  ProductOptionStockItem({required this.value, required this.quantity});

  Map<String, dynamic> toJson() {
    return {
      'value': value,
      'quantity': quantity,
    };
  }
}

class AddOptionsScreen extends StatelessWidget {
  static const String key_title = '/add_option_key_title';

  const AddOptionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final bloc = context.read<AddProductBloc>();

    return SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                    padding: const EdgeInsets.only(left: 2),
                    child: Text(AppStrings.OPTION_NAME,
                        style: theme.textTheme.titleMedium)),
                BlocBuilder<AddProductBloc, AddProductState>(
                    builder: (context, state) {
                  return AppTextField(
                      isError: false,
                      controller: bloc.optionNameController,
                      textInputAction: TextInputAction.next,
                      onChanged: (String? value) {
                        if (value == null) return;
                        if (value.isNotEmpty && state.optionNameController) {
                          bloc.validateOptionName(false, '');
                        }
                      },
                      hint: AppStrings.ENTER_OPTION_NAME,
                      textInputType: TextInputType.name,
                      radius: 8);
                }),
                const SizedBox(height: 10),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                          padding: const EdgeInsets.only(left: 2),
                          child: Text(AppStrings.STOCK,
                              style: theme.textTheme.titleMedium)),
                      BlocBuilder<AddProductBloc, AddProductState>(
                          buildWhen: (previous, current) =>
                              previous.isStock != current.isStock,
                          builder: (_, state) => Transform.scale(
                              scale: 0.5,
                              child: CupertinoSwitch(
                                  activeColor: theme.colorScheme.secondary,
                                  value: true,
                                  onChanged: (value) {
                                    bloc.updateiStockValue(value);
                                  })))
                    ]),
                const SizedBox(height: 10),
                BlocBuilder<AddProductBloc, AddProductState>(
                  builder: (context, state) {
                    return Column(
                      children:
                          List.generate(state.valueControllers.length, (index) {
                        return Row(children: [
                          Expanded(
                              child: AppTextField(
                                  isError: false,
                                  textInputAction: TextInputAction.next,
                                  controller: state.valueControllers[index],
                                  hint: 'Value',
                                  textInputType: TextInputType.name,
                                  radius: 8)),
                          const SizedBox(width: 5),
                          Expanded(
                              child: AppTextField(
                                  isError: false,
                                  textInputAction: TextInputAction.done,
                                  controller: state.quantityControllers[index],
                                  hint: 'QTY',
                                  textInputType: TextInputType.number,
                                  radius: 8)),
                          const SizedBox(width: 5),
                        ]);
                      }),
                    );
                  },
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () {
                        bloc.addStockItemController();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: theme.colorScheme.secondary,
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.add,
                            color: theme.colorScheme.onPrimary,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 40),
                SizedBox(
                  height: 40,
                  width: context.mediaSize.width,
                  child: AppButton(
                      borderRadius: 8,
                      text: AppStrings.ADD_OPTION,
                      onClick: () {
                        if (bloc.optionNameController.text.isEmpty) {
                          bloc.validateOptionName(
                              true, AppStrings.OPTION_NAME_IS_EMPTY);
                          return;
                        } else {
                          List<ProductOptionStockItem> stockItems = [];
                          for (int i = 0;
                              i < bloc.state.valueControllers.length;
                              i++) {
                            stockItems.add(ProductOptionStockItem(
                              value: bloc.state.valueControllers[i].text,
                              quantity: int.parse(
                                  bloc.state.quantityControllers[i].text),
                            ));
                          }
                          bloc.addProductOption(ProductOption(
                              name: bloc.optionNameController.text,
                              productOptionStockItems: stockItems,
                              isEnabled: true));
                          bloc.updatePagerIndex(2);
                          log(bloc.getProductOptionsJson());
                          bloc.optionNameController.clear();
                          bloc.state.valueControllers.clear();
                          bloc.state.quantityControllers.clear();
                        }
                      },
                      color: context.theme.colorScheme.primary),
                )
              ]),
        ));
  }
}
