import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sera/extensions/context_extension.dart';
import 'package:sera/ui/add_product/add_product_bloc.dart';
import 'package:sera/ui/add_product/add_product_state.dart';
import 'package:sera/ui/common/app_button.dart';
import 'package:sera/ui/common/app_text_field.dart';
import 'package:sera/util/app_strings.dart';
import 'package:sera/util/base_constants.dart';

class FinanceScreem extends StatelessWidget {
  static const String key_title = '/finance_key_title';

  const FinanceScreem({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final size = context.mediaSize;
    final bloc = context.read<AddProductBloc>();
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Container(
                          width: size.width * .27,
                          height: 2,
                          color: BaseConstant.salesChartGoalBarColor),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        AppStrings.PRODUCTS,
                        style: theme.textTheme.titleLarge!.copyWith(
                          color: BaseConstant.salesChartGoalBarColor,
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    children: [
                      Container(
                          width: size.width * .27,
                          height: 2,
                          color: theme.colorScheme.secondary),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        AppStrings.FINANCE,
                        style: theme.textTheme.titleLarge!.copyWith(
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                            color: theme.colorScheme.secondary),
                      )
                    ],
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    children: [
                      Container(
                        width: size.width * .27,
                        height: 2,
                        color: BaseConstant.salesChartGoalBarColor,
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        AppStrings.INVENTORY,
                        style: theme.textTheme.titleLarge!.copyWith(
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                            color: BaseConstant.salesChartGoalBarColor),
                      )
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                        padding: const EdgeInsets.only(left: 2),
                        child: Text(AppStrings.SALE_PRICE,
                            style: theme.textTheme.titleMedium)),
                    BlocBuilder<AddProductBloc, AddProductState>(
                        buildWhen: (previous, current) =>
                            previous.salePriceValidate !=
                            current.salePriceValidate,
                        builder: (_, state) => AppTextField(
                            isError: state.salePriceValidate,
                            textInputAction: TextInputAction.next,
                            onChanged: (String? value) {
                              if (value == null) return;
                              if (value.isNotEmpty && state.salePriceValidate) {
                                bloc.updateSalePriceValidate(false, '');
                              }
                            },
                            hint: AppStrings.ENTER_SALE_PRICE,
                            textInputType: TextInputType.name,
                            radius: 8,
                            controller: bloc.salePriceController)),
                    Padding(
                        padding: const EdgeInsets.only(left: 2),
                        child: Text(AppStrings.COST,
                            style: theme.textTheme.titleMedium)),
                    BlocBuilder<AddProductBloc, AddProductState>(
                        buildWhen: (previous, current) =>
                            previous.costValidation != current.costValidation,
                        builder: (_, state) => AppTextField(
                            isError: state.costValidation,
                            textInputAction: TextInputAction.next,
                            onChanged: (String? value) {
                              if (value == null) return;
                              if (value.isNotEmpty && state.costValidation) {
                                bloc.updateCostPriceValidate(false, '');
                              }
                            },
                            hint: AppStrings.ENTER_COST,
                            textInputType: TextInputType.name,
                            radius: 8,
                            controller: bloc.costController)),
                    Padding(
                      padding: const EdgeInsets.only(left: 2),
                      child: Row(
                        children: [
                          Text(
                            AppStrings.BARCODE,
                            style: theme.textTheme.titleMedium,
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          Text(
                            ' ( optional )',
                            style: theme.textTheme.bodySmall!.copyWith(
                                fontSize: 10,
                                color: const Color(0xff9D9D9D).withOpacity(0.4),
                                fontFamily: BaseConstant.poppinsSemibold,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ),
                    BlocBuilder<AddProductBloc, AddProductState>(
                        builder: (_, state) => AppTextField(
                            isError: false,
                            textInputAction: TextInputAction.next,
                            onChanged: (String? value) {},
                            hint: AppStrings.ENTER_BARCODE,
                            textInputType: TextInputType.name,
                            radius: 8,
                            controller: bloc.barcodeController)),
                    BlocBuilder<AddProductBloc, AddProductState>(
                        buildWhen: (previous, current) =>
                            previous.errorText != current.errorText,
                        builder: (_, state) {
                          if (state.errorText.isEmpty) {
                            return const SizedBox();
                          }
                          return Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 7),
                              margin:
                                  const EdgeInsets.only(bottom: 20, top: 15),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                      color: theme.colorScheme.error)),
                              child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(Icons.error_outline,
                                        color: theme.colorScheme.error),
                                    const SizedBox(width: 5),
                                    Text(state.errorText,
                                        style: TextStyle(
                                            color: theme.colorScheme.error,
                                            fontFamily:
                                                BaseConstant.poppinsRegular,
                                            fontSize: 12))
                                  ]));
                        }),
                    const SizedBox(
                      height: 70,
                    ),
                    SizedBox(
                        height: 40,
                        width: MediaQuery.of(context).size.width,
                        child: AppButton(
                            textColor: Colors.white,
                            fontSize: 16,
                            borderRadius: 8,
                            color: theme.colorScheme.primary,
                            text: AppStrings.NEXT,
                            onClick: () async {
                              context.unfocus();
                              if (bloc.salePriceController.text.isEmpty) {
                                bloc.updateSalePriceValidate(
                                    true, AppStrings.SALE_PRICE_IS_EMPTY);
                                return;
                              } else if (bloc.costController.text.isEmpty) {
                                bloc.updateCostPriceValidate(
                                    true, AppStrings.COST_IS_EMPTY);
                                return;
                              }
                              bloc.updatePagerIndex(2);
                            })),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
