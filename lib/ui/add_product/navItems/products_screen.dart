import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sera/backend/server_response.dart';
import 'package:sera/data/meta_data.dart';
import 'package:sera/extensions/context_extension.dart';
import 'package:sera/ui/add_product/add_product_bloc.dart';
import 'package:sera/ui/add_product/add_product_state.dart';
import 'package:sera/ui/common/app_button.dart';
import 'package:sera/ui/common/app_text_field.dart';
import 'package:sera/util/app_strings.dart';
import 'package:sera/util/base_constants.dart';

class ProductsScreen extends StatelessWidget {
  static const String key_title = '/product_key_title';

  const ProductsScreen({super.key});

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
                          color: theme.colorScheme.secondary),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        AppStrings.PRODUCTS,
                        style: theme.textTheme.titleLarge!.copyWith(
                          color: theme.colorScheme.secondary,
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
                    BlocBuilder<AddProductBloc, AddProductState>(
                        builder: (context, state) {
                      final eventData = state.fileDataEvent;
                      ImageProvider image;
                      if (eventData is Data) {
                        final imageData = eventData.data as XFile;
                        image = FileImage(File(imageData.path));
                        return Center(
                          child: InkWell(
                            onTap: () async {
                              final image = await ImagePicker()
                                  .pickImage(source: ImageSource.gallery);
                              if (image == null) return;
                              bloc.handleImageSelection(image);
                            },
                            child: Container(
                                height: 100,
                                width: size.width * .5,
                                decoration: BoxDecoration(
                                    image: DecorationImage(image: image),
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                        color: theme
                                            .colorScheme.secondaryContainer))),
                          ),
                        );
                      } else {
                        return InkWell(
                          onTap: () async {
                            final image = await ImagePicker()
                                .pickImage(source: ImageSource.gallery);
                            if (image == null) return;
                            bloc.handleImageSelection(image);
                          },
                          child: Center(
                            child: Container(
                              height: 100,
                              width: size.width * .5,
                              decoration: BoxDecoration(
                                  color: theme.colorScheme.onPrimaryContainer,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                      color: theme
                                          .colorScheme.secondaryContainer)),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset("assets/3x/empty_image.png"),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(AppStrings.ADD_IMAGE,
                                        style: theme.textTheme.titleSmall),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }
                    }),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                        padding: const EdgeInsets.only(left: 2),
                        child: Text(AppStrings.PRODUCT_NAME,
                            style: theme.textTheme.titleMedium)),
                    BlocBuilder<AddProductBloc, AddProductState>(
                        buildWhen: (previous, current) =>
                            previous.productNameValidate !=
                            current.productNameValidate,
                        builder: (_, state) => AppTextField(
                            isError: state.productNameValidate,
                            textInputAction: TextInputAction.next,
                            onChanged: (String? value) {
                              if (value == null) return;
                              if (value.isNotEmpty &&
                                  state.productNameValidate) {
                                bloc.updateProductNameValidate(false, '');
                              }
                            },
                            hint: AppStrings.ENTER_PRODUCT_NAME,
                            textInputType: TextInputType.name,
                            radius: 8,
                            controller: bloc.productNameController)),
                    Padding(
                        padding: const EdgeInsets.only(left: 2),
                        child: Text(AppStrings.CATERGORY,
                            style: theme.textTheme.titleMedium)),
                    BlocBuilder<AddProductBloc, AddProductState>(
                        builder: (context, state) {
                      return SizedBox(
                        child: PopupMenuButton<AllCategoriesModel>(
                          color: Colors.white,
                          shadowColor: Colors.transparent,
                          offset: const Offset(0, 50),
                          elevation: 0,
                          tooltip: '',
                          splashRadius: 0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                              side: BorderSide(
                                  color: theme.colorScheme.onPrimaryContainer)),
                          constraints:
                              BoxConstraints(minWidth: size.width - 30),
                          position: PopupMenuPosition.over,
                          itemBuilder: (context) {
                            return state.categoryData
                                .map((AllCategoriesModel country) {
                              return PopupMenuItem<AllCategoriesModel>(
                                value: country,
                                child: Text(
                                  country.name,
                                  style: TextStyle(
                                    fontFamily: BaseConstant.poppinsMedium,
                                    fontSize: 15,
                                    color: theme.colorScheme.onSurface,
                                  ),
                                ),
                              );
                            }).toList();
                          },
                          onSelected: (selectedItem) {
                            bloc.categoryController.text = selectedItem.name;
                            bloc.selectedCategoryid.text =
                                selectedItem.id.toString();
                          },
                          child: AppTextField(
                            controller: bloc.categoryController,
                            enabled: false,
                            isError: state.categoryValidate,
                            readOnly: true,
                            onChanged: (String? value) {
                              if (value == null) return;
                              if (value.isNotEmpty && state.categoryValidate) {
                                bloc.updateCategoryValidate(false, '');
                              }
                            },
                            textInputAction: TextInputAction.next,
                            hint: AppStrings.SELECT_CATEGORY,
                            textInputType: TextInputType.name,
                            suffixIcon: Icon(
                              Icons.keyboard_arrow_down_rounded,
                              color: theme.colorScheme.secondary,
                              size: 22,
                            ),
                            radius: 8,
                          ),
                        ),
                      );
                    }),
                    Padding(
                        padding: const EdgeInsets.only(left: 2),
                        child: Text(AppStrings.WEIGHT,
                            style: theme.textTheme.titleMedium)),
                    BlocBuilder<AddProductBloc, AddProductState>(
                        buildWhen: (previous, current) =>
                            previous.weightValidate != current.weightValidate,
                        builder: (_, state) => AppTextField(
                            isError: state.weightValidate,
                            textInputAction: TextInputAction.next,
                            onChanged: (String? value) {
                              if (value == null) return;
                              if (value.isNotEmpty && state.weightValidate) {
                                bloc.updateWeightValidate(false, '');
                              }
                            },
                            hint: AppStrings.ENTER_WEIGHT,
                            textInputType: TextInputType.name,
                            radius: 8,
                            controller: bloc.weightController)),
                    Padding(
                        padding: const EdgeInsets.only(left: 2),
                        child: Text(AppStrings.PREPARATION_TIME,
                            style: theme.textTheme.titleMedium)),
                    Row(children: [
                      Expanded(
                        child: BlocBuilder<AddProductBloc, AddProductState>(
                            buildWhen: (previous, current) =>
                                previous.preparationValidate !=
                                current.preparationValidate,
                            builder: (_, state) => AppTextField(
                                isError: state.preparationValidate,
                                textInputAction: TextInputAction.next,
                                onChanged: (String? value) {
                                  if (value == null) return;
                                  if (value.isNotEmpty &&
                                      state.preparationValidate) {
                                    bloc.updatePreparationValidate(false, '');
                                  }
                                },
                                hint: AppStrings.ENTER_PREPARATION_TIME,
                                textInputType: TextInputType.number,
                                radius: 8,
                                controller: bloc.prepartionTimeController)),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      SizedBox(
                          width: 100,
                          child: BlocBuilder<AddProductBloc, AddProductState>(
                              builder: (context, state) {
                            return SizedBox(
                                width: 80,
                                child: PopupMenuButton<String>(
                                    color: Colors.white,
                                    shadowColor: Colors.transparent,
                                    offset: const Offset(0, 45),
                                    elevation: 0,
                                    tooltip: '',
                                    splashRadius: 0,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        side: BorderSide(
                                            color: theme.colorScheme
                                                .onPrimaryContainer)),
                                    constraints:
                                        const BoxConstraints(minWidth: 80),
                                    position: PopupMenuPosition.over,
                                    itemBuilder: (context) {
                                      return [
                                        "Hours",
                                        "Days",
                                        "Weeks",
                                        "Months"
                                      ].map((String item) {
                                        return PopupMenuItem<String>(
                                          value: item,
                                          child: Text(
                                            item,
                                            style: TextStyle(
                                              fontFamily:
                                                  BaseConstant.poppinsMedium,
                                              fontSize: 15,
                                              color:
                                                  theme.colorScheme.onSurface,
                                            ),
                                          ),
                                        );
                                      }).toList();
                                    },
                                    onSelected: (selectedItem) {
                                      bloc.daysController.text = selectedItem;
                                    },
                                    child: AppTextField(
                                      controller: bloc.daysController,
                                      isError: state.preparationTimeValidate,
                                      readOnly: true,
                                      suffixIcon: Icon(
                                        Icons.keyboard_arrow_down_rounded,
                                        color: theme.colorScheme.secondary,
                                        size: 22,
                                      ),
                                      onChanged: (String? value) {
                                        if (value == null) return;
                                        if (value.isNotEmpty &&
                                            state.preparationTimeValidate) {
                                          bloc.updatePreprationTimeValidate(
                                              false, '');
                                        }
                                      },
                                      hint: AppStrings.DAYS,
                                      textInputType: TextInputType.name,
                                      radius: 8,
                                    )));
                          }))
                    ]),
                    Padding(
                        padding: const EdgeInsets.only(left: 2),
                        child: Text(AppStrings.INFO,
                            style: theme.textTheme.titleMedium)),
                    BlocBuilder<AddProductBloc, AddProductState>(
                        buildWhen: (previous, current) =>
                            previous.infoValidate != current.infoValidate,
                        builder: (_, state) => AppTextField(
                            isError: state.infoValidate,
                            textInputAction: TextInputAction.next,
                            onChanged: (String? value) {
                              if (value == null) return;
                              if (value.isNotEmpty && state.infoValidate) {
                                bloc.updateInfoValidate(false, '');
                              }
                            },
                            hint: AppStrings.ENTER_INFO,
                            textInputType: TextInputType.name,
                            radius: 8,
                            controller: bloc.infoController)),
                    Padding(
                      padding: const EdgeInsets.only(left: 2),
                      child: RichText(
                        text: TextSpan(
                          text: AppStrings.LINK_TO_COLLECTION,
                          style: theme.textTheme.titleMedium,
                          children: [
                            TextSpan(
                              text: ' ( optional )',
                              style: theme.textTheme.bodySmall!.copyWith(
                                  fontSize: 10,
                                  color:
                                      const Color(0xff9D9D9D).withOpacity(0.4),
                                  fontFamily: BaseConstant.poppinsSemibold,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                      ),
                    ),
                    BlocBuilder<AddProductBloc, AddProductState>(
                        builder: (_, state) => AppTextField(
                            isError: false,
                            textInputAction: TextInputAction.next,
                            onChanged: (String? value) {},
                            hint: AppStrings.CHOSSE_A_COLLECTION,
                            textInputType: TextInputType.name,
                            readOnly: true,
                            suffixIcon: Icon(
                              Icons.keyboard_arrow_down_rounded,
                              color: theme.colorScheme.secondary,
                              size: 22,
                            ),
                            radius: 8,
                            controller: bloc.chooseCollectionController)),
                    Padding(
                        padding: const EdgeInsets.only(left: 2),
                        child: Text(AppStrings.SORT,
                            style: theme.textTheme.titleMedium)),
                    BlocBuilder<AddProductBloc, AddProductState>(
                        buildWhen: (previous, current) =>
                            previous.sortValidate != current.sortValidate,
                        builder: (_, state) => AppTextField(
                            isError: state.sortValidate,
                            textInputAction: TextInputAction.next,
                            onChanged: (String? value) {
                              if (value == null) return;
                              if (value.isNotEmpty && state.sortValidate) {
                                bloc.updateSortValidate(false, '');
                              }
                            },
                            hint: AppStrings.ENTER_SORT,
                            textInputType: TextInputType.name,
                            radius: 8,
                            controller: bloc.sortController)),
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
                      height: 20,
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
                              if (bloc.productNameController.text.isEmpty) {
                                bloc.updateProductNameValidate(
                                    true, AppStrings.PRODUCT_IS_EMPTY);
                                return;
                              } else if (bloc.categoryController.text.isEmpty) {
                                bloc.updateCategoryValidate(
                                    true, AppStrings.CATEGORY_IS_EMPTY);
                                return;
                              } else if (bloc.weightController.text.isEmpty) {
                                bloc.updateWeightValidate(
                                    true, AppStrings.WEIGHT_IS_EMPTY);
                                return;
                              } else if (bloc
                                  .prepartionTimeController.text.isEmpty) {
                                bloc.updatePreparationValidate(
                                    true, AppStrings.PREPARATION_TIME_IS_EMPTY);
                                return;
                              } else if (bloc.daysController.text.isEmpty) {
                                bloc.updatePreprationTimeValidate(
                                    true, AppStrings.PREPARATION_DAYS_IS_EMPTY);
                                return;
                              } else if (bloc.infoController.text.isEmpty) {
                                bloc.updateInfoValidate(
                                    true, AppStrings.PRODUCT_INFO_IS_EMPTY);
                                return;
                              } else if (bloc.sortController.text.isEmpty) {
                                bloc.updateSortValidate(
                                    true, AppStrings.SORT_IS_EMPTY);
                                return;
                              }
                              bloc.updatePagerIndex(1);
                            })),
                    const SizedBox(
                      height: 20,
                    ),
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
