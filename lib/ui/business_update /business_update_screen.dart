import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sera/backend/shared_web_service.dart';
import 'package:sera/data/meta_data.dart';
import 'package:sera/extensions/context_extension.dart';
import 'package:sera/helper/dialog_helper.dart';
import 'package:sera/helper/snackbar_helper.dart';
import 'package:sera/ui/business_update%20/brand_edit_state.dart';
import 'package:sera/ui/business_update%20/brand_edit_bloc.dart';
import 'package:sera/ui/common/app_bar.dart';
import 'package:sera/ui/common/app_button.dart';
import 'package:sera/ui/common/app_text_field.dart';
import 'package:sera/util/app_strings.dart';
import 'package:sera/util/base_constants.dart';

class EditBrand extends StatelessWidget {
  static const String route = "_brand_update_screen";
  const EditBrand({super.key});

  DialogHelper get _dialogHelper => DialogHelper.instance();
  SnackbarHelper get _snackbarHelper => SnackbarHelper.instance();
  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final textTheme = context.theme.textTheme;
    final bloc = context.read<EditBrandBloc>();

    return Scaffold(
      backgroundColor: theme.colorScheme.onPrimary,
      appBar: CustomAppBar(
        isbottom: true,
        elevation: 0.0,
        backgroundColor: theme.colorScheme.onPrimary,
        iscenterTitle: true,
        title: Text(
          AppStrings.EDIT_PROFILE,
          style: theme.textTheme.titleLarge!.copyWith(
              color: theme.colorScheme.secondary,
              fontSize: 14,
              fontWeight: FontWeight.w500),
        ),
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: theme.colorScheme.secondary,
            size: 20,
          ),
        ),
        onLeadingPressed: () {
          Navigator.pop(context);
        },
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                  padding: const EdgeInsets.only(left: 2),
                  child: Text(AppStrings.HEADER, style: textTheme.titleMedium)),
              const SizedBox(
                height: 10,
              ),
              BlocBuilder<EditBrandBloc, EditBrandState>(
                  builder: (context, state) {
                final eventData = state.headerDataEvent;
                if (eventData is! Data) {
                  if (state.logoImage.isNotEmpty) {
                    return InkWell(
                      onTap: () async {
                        final image = await ImagePicker()
                            .pickImage(source: ImageSource.gallery);
                        if (image == null) return;
                        bloc.handleHeaderSelection(image);
                      },
                      child: Container(
                        height: 140,
                        decoration: BoxDecoration(
                            // color: theme.colorScheme.onPrimaryContainer,
                            image: DecorationImage(
                              image: NetworkImage("$pictureUrl${state.headerImage}")),
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(
                                color: theme.colorScheme.secondaryContainer)),
                      ),
                    );
                  } else {
                    return InkWell(
                      onTap: () async {
                        final image = await ImagePicker()
                            .pickImage(source: ImageSource.gallery);
                        if (image == null) return;
                        bloc.handleHeaderSelection(image);
                      },
                      child: Container(
                        height: 140,
                        decoration: BoxDecoration(
                            color: theme.colorScheme.onPrimaryContainer,
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(
                                color: theme.colorScheme.secondaryContainer)),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset("assets/3x/empty_image.png"),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(AppStrings.ADD_IMAGES,
                                  style: textTheme.titleSmall)
                            ],
                          ),
                        ),
                      ),
                    );
                  }
                } else {
                  final imageData = eventData.data as XFile;
                  // image = FileImage(File(imageData.path));
                  return InkWell(
                    onTap: () async {
                      final image = await ImagePicker()
                          .pickImage(source: ImageSource.gallery);
                      if (image == null) return;
                      bloc.handleHeaderSelection(image);
                    },
                    child: Container(
                      height: 140,
                      decoration: BoxDecoration(
                          color: theme.colorScheme.onPrimaryContainer,
                          image: DecorationImage(
                              image: FileImage(File(imageData.path))),
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(
                              color: theme.colorScheme.secondaryContainer)),
                    ),
                  );
                }
              }),
              const SizedBox(
                height: 10,
              ),
              Padding(
                  padding: const EdgeInsets.only(left: 2),
                  child: Text(AppStrings.LOGO, style: textTheme.titleMedium)),
              Center(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    BlocBuilder<EditBrandBloc, EditBrandState>(
                        builder: (context, state) {
                      final eventData = state.logoDataEvent;
                      ImageProvider image;
                      if (eventData is! Data) {
                        if (state.headerImage.isNotEmpty) {
                          image = NetworkImage("$pictureUrl${state.logoImage}");
                        } else {
                          image = const AssetImage('assets/3x/dummy_user.png');
                        }
                      } else {
                        final imageData = eventData.data as XFile;
                        image = FileImage(File(imageData.path));
                      }

                      return CircleAvatar(
                        backgroundColor: theme.colorScheme.secondary,
                        radius: 50,
                        backgroundImage: image,
                      );
                    }),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: InkWell(
                        onTap: () async {
                          final image = await ImagePicker()
                              .pickImage(source: ImageSource.gallery);
                          if (image == null) return;
                          bloc.handleLogoSelection(image);
                        },
                        child: Container(
                          width: 25,
                          height: 25,
                          decoration: BoxDecoration(
                            color: theme.colorScheme.onSecondaryContainer,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.edit,
                            size: 15,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                  padding: const EdgeInsets.only(left: 2),
                  child: Text(AppStrings.BUSINESS_NAME,
                      style: textTheme.titleMedium)),
              BlocBuilder<EditBrandBloc, EditBrandState>(
                  buildWhen: (previous, current) =>
                      previous.businessNameValidate !=
                      current.businessNameValidate,
                  builder: (_, state) => AppTextField(
                      isError: state.businessNameValidate,
                      textInputAction: TextInputAction.next,
                      onChanged: (String? value) {
                        if (value == null) return;
                        if (value.isNotEmpty && state.businessNameValidate) {
                          bloc.updateBusinessNameValidate(false, '');
                        }
                      },
                      hint: AppStrings.JACOB,
                      textInputType: TextInputType.name,
                      radius: 8,
                      controller: bloc.businessNameController)),
              Padding(
                  padding: const EdgeInsets.only(left: 2),
                  child: Text(AppStrings.BIO, style: textTheme.titleMedium)),
              BlocBuilder<EditBrandBloc, EditBrandState>(
                  buildWhen: (previous, current) =>
                      previous.bioValidate != current.bioValidate,
                  builder: (_, state) => Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.only(right: 00, left: 00),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                                color: theme.colorScheme.onPrimaryContainer),
                            color: Colors.white),
                        child: TextFormField(
                            maxLines: 4,
                            textInputAction: TextInputAction.next,
                            onChanged: (String? value) {
                              if (value == null) return;
                              if (value.isNotEmpty && state.bioValidate) {
                                bloc.updateBioValidate(false, '');
                              }
                            },
                            keyboardType: TextInputType.name,
                            style: textTheme.labelLarge!.copyWith(
                                color: theme.colorScheme.onSecondaryContainer,
                                fontSize: 14),
                            decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                hintText: AppStrings.ENTER_YOUR_MESSAGE,
                                hintStyle: textTheme.labelLarge!.copyWith(
                                    color: theme.colorScheme.primaryContainer,
                                    fontSize: 14)),
                            controller: bloc.bioController),
                      )),
              Padding(
                  padding: const EdgeInsets.only(left: 2),
                  child: Text(AppStrings.EMAIL, style: textTheme.titleMedium)),
              BlocBuilder<EditBrandBloc, EditBrandState>(
                  buildWhen: (previous, current) =>
                      previous.emailValidate != current.emailValidate,
                  builder: (_, state) => AppTextField(
                      isError: state.emailValidate,
                      radius: 8,
                      textInputAction: TextInputAction.next,
                      onChanged: (String? value) {
                        if (value == null) return;
                        if (value.isNotEmpty && state.emailValidate) {
                          bloc.updateEmailValidate(false, '');
                        }
                      },
                      hint: AppStrings.DUMMY_EMAIL,
                      textInputType: TextInputType.emailAddress,
                      controller: bloc.emailController)),
              Padding(
                padding: const EdgeInsets.only(left: 2),
                child: RichText(
                  text: TextSpan(
                    text: AppStrings.MOBILE,
                    style: textTheme.titleMedium,
                    children: [
                      TextSpan(
                        text: ' ( Hidden )',
                        style: theme.textTheme.bodySmall!.copyWith(
                            fontSize: 12,
                            color: const Color(0xff9D9D9D).withOpacity(0.4),
                            fontFamily: BaseConstant.poppinsSemibold,
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  BlocBuilder<EditBrandBloc, EditBrandState>(
                      builder: (context, state) {
                    return SizedBox(
                      width: 80,
                      child: PopupMenuButton<String>(
                        color: Colors.white,
                        shadowColor: Colors.transparent,
                        offset: const Offset(0.5, kToolbarHeight),
                        elevation: 0,
                        tooltip: '',
                        splashRadius: 0,
                        padding: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            width: 0.5,
                            color: theme.colorScheme.secondaryContainer,
                          ),
                        ),
                        constraints: const BoxConstraints(minWidth: 80),
                        position: PopupMenuPosition.over,
                        itemBuilder: (context) {
                          final List<String> itemList = [
                            "+1",
                            "+92",
                          ];
                          List<PopupMenuEntry<String>> menuItems = [];
                          for (int i = 0; i < itemList.length; i++) {
                            menuItems.add(
                              PopupMenuItem<String>(
                                value: itemList[i],
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      itemList[i],
                                      style:
                                          theme.textTheme.bodySmall!.copyWith(
                                        fontSize: 14,
                                        fontFamily: BaseConstant.poppinsMedium,
                                        color: theme
                                            .colorScheme.onSecondaryContainer,
                                      ),
                                    ),
                                    if (i != itemList.length - 1)
                                      const SizedBox(
                                        height: 8,
                                      ),
                                    if (i != itemList.length - 1)
                                      Container(
                                        height:
                                            1, // Adjust divider height as needed
                                        color: theme
                                            .colorScheme.secondaryContainer
                                            .withOpacity(0.2),
                                      ),
                                  ],
                                ),
                              ),
                            );
                          }
                          return menuItems;
                        },
                        onSelected: (selectedItem) {
                          bloc.mobileCodeController.text = selectedItem;
                        },
                        child: AppTextField(
                          controller: bloc.mobileCodeController,
                          enabled: false,
                          readOnly: true,
                          radius: 8,
                          isError: false,
                          onChanged: (String? value) {
                            if (value == null) return;
                            if (value.isNotEmpty && state.mobileCodeValidate) {
                              bloc.updateMobileCodeValidate(false, '');
                            }
                          },
                          textInputAction: TextInputAction.next,
                          hint: '+1',
                          textInputType: TextInputType.number,
                        ),
                      ),
                    );
                  }),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: BlocBuilder<EditBrandBloc, EditBrandState>(
                        buildWhen: (previous, current) =>
                            previous.mobileNumberValidate !=
                            current.mobileNumberValidate,
                        builder: (_, state) => AppTextField(
                            isError: state.mobileNumberValidate,
                            radius: 8,
                            textInputAction: TextInputAction.next,
                            onChanged: (String? value) {
                              if (value == null) return;
                              if (value.isNotEmpty &&
                                  state.mobileNumberValidate) {
                                bloc.updateMobileNumberValidate(false, '');
                              }
                            },
                            hint: AppStrings.ENTER_MOBILE,
                            textInputType: TextInputType.number,
                            controller: bloc.mobileNumberController)),
                  ),
                ],
              ),
              BlocBuilder<EditBrandBloc, EditBrandState>(
                  buildWhen: (previous, current) =>
                      previous.errorText != current.errorText,
                  builder: (_, state) {
                    if (state.errorText.isEmpty) {
                      return const SizedBox();
                    }
                    return Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 7),
                        margin: const EdgeInsets.only(bottom: 20, top: 15),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: theme.colorScheme.error)),
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(Icons.error_outline,
                                  color: theme.colorScheme.error),
                              const SizedBox(width: 5),
                              Text(state.errorText,
                                  style: TextStyle(
                                      color: theme.colorScheme.error,
                                      fontFamily: BaseConstant.poppinsRegular,
                                      fontSize: 12))
                            ]));
                  }),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                  height: 40,
                  width: MediaQuery.of(context).size.width,
                  child: AppButton(
                      textColor: Colors.white,
                      fontSize: 16,
                      borderRadius: 8,
                      color: theme.colorScheme.primary,
                      text: AppStrings.UPDATE,
                      onClick: () {
                        context.unfocus();

                        if (bloc.isValidEmail(bloc.emailController.text) ==
                            false) {
                          bloc.updateEmailValidate(
                              true, AppStrings.EMAIL_IS_NOT_VALID);
                        } else if (bloc.businessNameController.text.isEmpty) {
                          bloc.updateBusinessNameValidate(
                              true, AppStrings.BUSINESS_NAME);
                          return;
                        } else if (bloc.bioController.text.isEmpty) {
                          bloc.updateBioValidate(true, AppStrings.BIO_EMPTY);
                          return;
                        } else if (bloc.emailController.text.isEmpty) {
                          bloc.updateEmailValidate(
                              true, AppStrings.EMAIL_IS_EMPTY);
                          return;
                        } else if (bloc.mobileCodeController.text.isEmpty) {
                          bloc.updateMobileCodeValidate(
                              true, AppStrings.PHONE_CODE_IS_EMPTY);
                          return;
                        } else if (bloc.mobileNumberController.text.isEmpty) {
                          bloc.updateMobileNumberValidate(
                              true, AppStrings.PHONE_NUMBER_IS_EMPTY);
                          return;
                        } else {
                          bloc.updateBrand(bloc, context, _dialogHelper);
                        }
                      })),
            ],
          ),
        ),
      ),
    );
  }
}
