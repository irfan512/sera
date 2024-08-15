// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sera/data/material_dailog_content.dart';
import 'package:sera/data/snackbar_message.dart';
import 'package:sera/extensions/context_extension.dart';
import 'package:sera/helper/dialog_helper.dart';
import 'package:sera/helper/snackbar_helper.dart';
import 'package:sera/ui/common/customer_step_slider.dart';
import 'package:sera/ui/common/vendor_step_slider.dart';
import 'package:sera/util/base_constants.dart';
import '../../../../util/app_strings.dart';
import '../../../common/app_button.dart';
import '../../../common/app_text_field.dart';
import '../signup_screen_bloc.dart';
import '../signup_screen_state.dart';

class SignupStartNav extends StatelessWidget {
  static const String key_title = '/signup_start_key_title';

  SignupStartNav({super.key});

  DialogHelper get _dialogHelper => DialogHelper.instance();
  SnackbarHelper get _snackbarHelper => SnackbarHelper.instance();

  Future<void> _customerRegister(SignupScreenBloc bloc, BuildContext context,
      DialogHelper dialogHelper) async {
    dialogHelper
      ..injectContext(context)
      ..showProgressDialog(AppStrings.CREATING_ACCOUNT);
    try {
      final response = await bloc.customerRegister();
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
      _snackbarHelper
        ..injectContext(context)
        ..showSnackbar(
            snackbarMessage: const SnackbarMessage.smallMessage(
                content: AppStrings.SUCCESSFULLY_SIGN_UP),
            margin: EdgeInsets.only(
                left: 25,
                right: 25,
                bottom: context.isHaveBottomNotch ? 100 : 90));
      bloc.updatePagerIndex(1);
    } catch (_) {
      dialogHelper.dismissProgress();
      dialogHelper.showTitleContentDialog(MaterialDialogContent.networkError(),
          () => _customerRegister(bloc, context, dialogHelper));
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;
    final bloc = context.read<SignupScreenBloc>();
    return SafeArea(
        bottom: false,
        child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(children: [
              const SizedBox(
                height: 10,
              ),
              BlocBuilder<SignupScreenBloc, SignupScreenState>(
                  builder: (context, state) {
                log(state.isCustomerSelect.toString());
                return state.isCustomerSelect == true
                    ? CustomerStepIndicator(
                        currentIndex: 0,
                        defaultColor: BaseConstant.signupSliderColor,
                        activeColor: theme.colorScheme.secondary)
                    : VendorStepIndicator(
                        currentIndex: 0,
                        defaultColor: BaseConstant.signupSliderColor,
                        activeColor: theme.colorScheme.secondary);
              }),
              const SizedBox(
                height: 20,
              ),
              BlocBuilder<SignupScreenBloc, SignupScreenState>(
                  builder: (context, state) {
                return state.isCustomerSelect == true
                    ? Column(
                        children: [
                          Text(AppStrings.HELLO_STYLISH_SHOPPER,
                              style: TextStyle(
                                  color: theme.colorScheme.secondary,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: BaseConstant.poppinsBold,
                                  fontSize: 22)),
                          const Text(AppStrings.LET_GET_STARTED,
                              style: TextStyle(
                                  color: Color(0xffCACACA),
                                  fontFamily: BaseConstant.poppinsLight,
                                  fontSize: 16)),
                        ],
                      )
                    : Column(
                        children: [
                          Text(AppStrings.HELLO_STYLISH_DESIGNER,
                              style: TextStyle(
                                  color: theme.colorScheme.secondary,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: BaseConstant.poppinsBold,
                                  fontSize: 20)),
                          const Text(AppStrings.LETS_START,
                              style: TextStyle(
                                  color: Color(0xffCACACA),
                                  fontFamily: BaseConstant.poppinsLight,
                                  fontSize: 16)),
                        ],
                      );
              }),
              const SizedBox(
                height: 10,
              ),
              Container(
                color: theme.colorScheme.secondary,
                height: 0.5,
              ),
              const SizedBox(
                height: 30,
              ),
              Expanded(
                  child: SingleChildScrollView(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                    BlocBuilder<SignupScreenBloc, SignupScreenState>(
                        builder: (context, state) {
                      return state.isCustomerSelect == true
                          ? Padding(
                              padding: const EdgeInsets.only(left: 2),
                              child: Row(
                                children: [
                                  Text(
                                    AppStrings.FIRST_NAME,
                                    style: textTheme.titleMedium,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    ' ( Personal name is hidden )',
                                    style: theme.textTheme.bodySmall!.copyWith(
                                        fontSize: 10,
                                        color: const Color(0xff9D9D9D)
                                            .withOpacity(0.4),
                                        fontFamily:
                                            BaseConstant.poppinsSemibold,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                            )
                          : Padding(
                              padding: const EdgeInsets.only(left: 2),
                              child: Text(
                                AppStrings.FIRST_NAME,
                                style: textTheme.titleMedium,
                              ),
                            );
                    }),
                    BlocBuilder<SignupScreenBloc, SignupScreenState>(
                        buildWhen: (previous, current) =>
                            previous.firstNameValidate !=
                            current.firstNameValidate,
                        builder: (_, state) => AppTextField(
                            isError: state.firstNameValidate,
                            textInputAction: TextInputAction.next,
                            onChanged: (String? value) {
                              if (value == null) return;
                              if (value.isNotEmpty && state.firstNameValidate) {
                                bloc.updateFirstNameValidate(false, '');
                              }
                            },
                            hint: AppStrings.ENTER_FIRST_NAME,
                            textInputType: TextInputType.name,
                            radius: 8,
                            controller: bloc.firstNameController)),
                    Padding(
                        padding: const EdgeInsets.only(left: 2),
                        child: Text(AppStrings.LAST_NAME,
                            style: textTheme.titleMedium)),
                    BlocBuilder<SignupScreenBloc, SignupScreenState>(
                        buildWhen: (previous, current) =>
                            previous.lastNameValidate !=
                            current.lastNameValidate,
                        builder: (_, state) => AppTextField(
                            isError: state.lastNameValidate,
                            radius: 8,
                            textInputAction: TextInputAction.next,
                            onChanged: (String? value) {
                              if (value == null) return;
                              if (value.isNotEmpty && state.lastNameValidate) {
                                bloc.updateLastNameValidate(false, '');
                              }
                            },
                            hint: AppStrings.ENTER_LAST_NAME,
                            textInputType: TextInputType.name,
                            controller: bloc.lastNameController)),
                    Padding(
                        padding: const EdgeInsets.only(left: 2),
                        child: Text(AppStrings.EMAIL,
                            style: textTheme.titleMedium)),
                    BlocBuilder<SignupScreenBloc, SignupScreenState>(
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
                            hint: AppStrings.ENTER_YOUR_EMAIL,
                            textInputType: TextInputType.emailAddress,
                            controller: bloc.emailController)),
                    Padding(
                        padding: const EdgeInsets.only(left: 2),
                        child: Text(AppStrings.PASSWORD,
                            style: textTheme.titleMedium)),
                    BlocBuilder<SignupScreenBloc, SignupScreenState>(
                        buildWhen: (previous, current) =>
                            (previous.passwordValidate !=
                                    current.passwordValidate ||
                                previous.isPasswordShown !=
                                    current.isPasswordShown),
                        builder: (_, state) => AppTextField(
                            onChanged: (String? value) {
                              if (value == null) return;
                              bool hasCapitalLetter =
                                  value.contains(RegExp(r'[A-Z]'));
                              bool hasNumber = value.contains(RegExp(r'\d'));
                              bool hasSpecialCharacter = value
                                  .contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
                              if (value.isNotEmpty && state.passwordValidate) {
                                bloc.updatePasswordValidate(false, '');
                              } else if (hasCapitalLetter &&
                                  hasNumber &&
                                  hasSpecialCharacter &&
                                  state.passwordValidate) {
                                bloc.updatePasswordValidate(false, '');
                              }
                            },
                            textInputAction: TextInputAction.next,
                            radius: 8,
                            isError: state.passwordValidate,
                            onSuffixClick: () =>
                                bloc.togglePasswordVisibilityState(),
                            hint: AppStrings.ENTER_YOUR_PASSWORD,
                            suffixIcon: Icon(
                                !state.isPasswordShown
                                    ? Icons.visibility_outlined
                                    : Icons.visibility_off_outlined,
                                size: 22,
                                color: colorScheme.onPrimaryContainer),
                            isObscure: !state.isPasswordShown,
                            textInputType: TextInputType.visiblePassword,
                            controller: bloc.passwordController)),
                    Padding(
                        padding: const EdgeInsets.only(left: 2),
                        child: Text(AppStrings.MOBILE_NUMBER,
                            style: textTheme.titleMedium)),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        BlocBuilder<SignupScreenBloc, SignupScreenState>(
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            itemList[i],
                                            style: theme.textTheme.bodySmall!
                                                .copyWith(
                                              fontSize: 14,
                                              fontFamily:
                                                  BaseConstant.poppinsMedium,
                                              color: theme.colorScheme
                                                  .onSecondaryContainer,
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
                                              color: theme.colorScheme
                                                  .secondaryContainer
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
                                onChanged: (String? value) {},
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
                          child:
                              BlocBuilder<SignupScreenBloc, SignupScreenState>(
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
                                          bloc.updateMobileNumberValidate(
                                              false, '');
                                        }
                                      },
                                      hint: AppStrings.NUMBER,
                                      textInputType: TextInputType.number,
                                      controller: bloc.mobileNumberController)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    BlocBuilder<SignupScreenBloc, SignupScreenState>(
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
                    const SizedBox(height: 30),
                    SizedBox(
                        height: 40,
                        width: MediaQuery.of(context).size.width,
                        child: AppButton(
                            textColor: Colors.white,
                            fontSize: 16,
                            borderRadius: 8,
                            color: colorScheme.onPrimaryContainer,
                            text: AppStrings.NEXT,
                            onClick: () {
                              context.unfocus();

                              if (bloc.firstNameController.text.isEmpty) {
                                bloc.updateFirstNameValidate(
                                    true, AppStrings.FIRST_NAME_IS_EMPTY);
                                return;
                              } else if (bloc.lastNameController.text.isEmpty) {
                                bloc.updateLastNameValidate(
                                    true, AppStrings.LAST_NAME_IS_EMPTY);
                                return;
                              } else if (bloc.emailController.text.isEmpty) {
                                bloc.updateEmailValidate(
                                    true, AppStrings.EMAIL_IS_EMPTY);
                                return;
                              } else if (bloc.passwordController.text.isEmpty) {
                                bloc.updatePasswordValidate(
                                    true, AppStrings.PASSWORD_IS_EMPTY);
                                return;
                              } else if (bloc
                                  .mobileCodeController.text.isEmpty) {
                                bloc.updateMobileCodeValidate(
                                    true, AppStrings.PHONE_CODE_IS_EMPTY);
                                return;
                              } else if (bloc
                                  .mobileNumberController.text.isEmpty) {
                                bloc.updatePasswordValidate(
                                    true, AppStrings.PHONE_NUMBER_IS_EMPTY);
                                return;
                              } else {
                                bloc.state.isCustomerSelect == true
                                    ? _customerRegister(
                                        bloc, context, _dialogHelper)
                                    : bloc.updatePagerIndex(1);
                              }

                              // bloc.updatePagerIndex(1);
                            })),
                    const SizedBox(height: 20),
                  ])))
            ])));
  }
}
