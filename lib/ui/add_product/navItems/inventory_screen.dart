// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sera/data/material_dailog_content.dart';
import 'package:sera/data/snackbar_message.dart';
import 'package:sera/extensions/context_extension.dart';
import 'package:sera/helper/dialog_helper.dart';
import 'package:sera/helper/snackbar_helper.dart';
import 'package:sera/ui/add_product/add_product_bloc.dart';
import 'package:sera/ui/add_product/add_product_state.dart';
import 'package:sera/ui/common/app_button.dart';
import 'package:sera/util/app_strings.dart';
import 'package:sera/util/base_constants.dart';

import 'add_options_screen.dart';
import 'edit_options_screen.dart';

class Inventory extends StatelessWidget {
  static const String key_title = '/inventory_key_title';

  const Inventory({super.key});

  DialogHelper get _dialogHelper => DialogHelper.instance();
  SnackbarHelper get _snackbarHelper => SnackbarHelper.instance();

  Future<void> _addProduct(AddProductBloc bloc, BuildContext context,
      DialogHelper dialogHelper) async {
    dialogHelper
      ..injectContext(context)
      ..showProgressDialog(AppStrings.LOADING);
    try {
      final response = await bloc.addProduct();

      dialogHelper.dismissProgress();

      if (response.status != true) {
        _snackbarHelper
          ..injectContext(context)
          ..showSnackbar(
              snackbarMessage:
                  SnackbarMessage.smallMessageError(content: response.message),
              margin: EdgeInsets.only(
                  left: 25,
                  right: 25,
                  bottom: context.isHaveBottomNotch ? 100 : 90));
        return;
      }
      Navigator.pop(context);

      _snackbarHelper
        ..injectContext(context)
        ..showSnackbar(
            snackbarMessage:
                SnackbarMessage.smallMessage(content: response.message),
            margin: EdgeInsets.only(
                left: 25,
                right: 25,
                bottom: context.isHaveBottomNotch ? 100 : 90));
    } catch (_) {
      dialogHelper.dismissProgress();
      dialogHelper.showTitleContentDialog(MaterialDialogContent.networkError(),
          () => _addProduct(bloc, context, dialogHelper));
    }
  }

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
                          color: BaseConstant.salesChartGoalBarColor),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        AppStrings.FINANCE,
                        style: theme.textTheme.titleLarge!.copyWith(
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                            color: BaseConstant.salesChartGoalBarColor),
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
                        color: theme.colorScheme.secondary,
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        AppStrings.INVENTORY,
                        style: theme.textTheme.titleLarge!.copyWith(
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                            color: theme.colorScheme.secondary),
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
                      height: 30,
                    ),
                    BlocBuilder<AddProductBloc, AddProductState>(
                      builder: (context, state) {
                        if (state.productOptions.isEmpty) {
                          return Column(
                            children: [
                              Text(
                                'No options added. Please add product options.',
                                style: theme.textTheme.titleMedium,
                              ),
                            ],
                          );
                        } else {
                          return Column(
                            children: state.productOptions
                                .asMap()
                                .entries
                                .map((entry) {
                              int index = entry.key;
                              ProductOption option = entry.value;
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12.0),
                                child: Container(
                                  height: 40,
                                  width: size.width,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                      width: 0.5,
                                      color:
                                          theme.colorScheme.onPrimaryContainer,
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12.0),
                                    child: Row(
                                      children: [
                                        Text(
                                          option.name,
                                          style: theme.textTheme.titleMedium,
                                        ),
                                        const Spacer(),
                                        Transform.scale(
                                          scale: 0.5,
                                          child: CupertinoSwitch(
                                            activeColor:
                                                theme.colorScheme.secondary,
                                            value: option.isEnabled,
                                            onChanged: (value) {
                                              context
                                                  .read<AddProductBloc>()
                                                  .toggleProductOptionEnabled(
                                                      index, value);
                                            },
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      EditOptionScreen(
                                                    index: index,
                                                    option: option,
                                                  ),
                                                )).then((updatedOption) {
                                              if (updatedOption != null) {
                                                context
                                                    .read<AddProductBloc>()
                                                    .updateProductOption(
                                                        index, updatedOption);
                                                // Handle additional logic if needed
                                              }
                                            });
                                          },
                                          child: Image.asset(
                                            'assets/3x/edit_profile.png',
                                            height: 30,
                                            width: 30,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          );
                        }
                      },
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () {
                            bloc.updatePagerIndex(3);
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
                    const SizedBox(
                      height: 40,
                    ),
                    SizedBox(
                        height: 40,
                        width: MediaQuery.of(context).size.width,
                        child: AppButton(
                            textColor: Colors.white,
                            fontSize: 16,
                            borderRadius: 8,
                            color: theme.colorScheme.primary,
                            text: AppStrings.ADD_PRODUCT,
                            onClick: () async {
                              context.unfocus();

                              _addProduct(bloc, context, _dialogHelper);
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
