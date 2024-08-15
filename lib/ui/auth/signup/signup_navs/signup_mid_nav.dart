// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sera/backend/server_response.dart';
import 'package:sera/data/material_dailog_content.dart';
import 'package:sera/data/meta_data.dart';
import 'package:sera/data/snackbar_message.dart';
import 'package:sera/extensions/context_extension.dart';
import 'package:sera/helper/dialog_helper.dart';
import 'package:sera/helper/snackbar_helper.dart';
import 'package:sera/ui/auth/add_address/add_address_screen.dart';
import 'package:sera/ui/auth/signup/signup_screen_bloc.dart';
import 'package:sera/ui/auth/signup/signup_screen_state.dart';
import 'package:sera/ui/common/app_text_field.dart';
import 'package:sera/ui/common/custom_checkbox.dart';
import 'package:sera/ui/common/customer_step_slider.dart';
import 'package:sera/ui/common/vendor_step_slider.dart';
import 'package:sera/ui/main/main_screen.dart';
import '../../../../util/app_strings.dart';
import '../../../../util/base_constants.dart';
import '../../../common/app_button.dart';

class SignupMidNav extends StatelessWidget {
  static const String key_title = '/signup_mid_key_title';
  const SignupMidNav({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
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
              return state.isCustomerSelect == true
                  ? CustomerStepIndicator(
                      currentIndex: 1,
                      defaultColor: BaseConstant.signupSliderColor,
                      activeColor: theme.colorScheme.secondary)
                  : VendorStepIndicator(
                      currentIndex: 1,
                      defaultColor: BaseConstant.signupSliderColor,
                      activeColor: theme.colorScheme.secondary);
            }),
            BlocBuilder<SignupScreenBloc, SignupScreenState>(
                builder: (context, state) {
              return state.isCustomerSelect == true
                  ? const Expanded(child: AddressTab())
                  : Expanded(child: BrandIdentity());
            })
          ]),
        ));
  }
}

class AddressTab extends StatelessWidget {
  const AddressTab({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final colorScheme = theme.colorScheme;
    final bloc = context.read<SignupScreenBloc>();
    return Column(children: [
      const SizedBox(
        height: 20,
      ),
      FittedBox(
        child: Text(
          AppStrings.TRENDY_STYLES_ARE_ON_THEIR_WAY,
          textAlign: TextAlign.center,
          style: TextStyle(
              color: theme.colorScheme.secondary,
              fontWeight: FontWeight.w600,
              fontFamily: BaseConstant.poppinsBold,
              fontSize: 20),
        ),
      ),
      Text(AppStrings.TO_THIS_DESTINATION,
          style: TextStyle(
              color: theme.colorScheme.primaryContainer,
              fontFamily: BaseConstant.poppinsLight,
              fontSize: 16)),
      const SizedBox(
        height: 10,
      ),
      Container(
        color: theme.colorScheme.secondary,
        height: 0.5,
      ),
      const SizedBox(
        height: 70,
      ),
      BlocBuilder<SignupScreenBloc, SignupScreenState>(
          builder: (context, state) {
        return state.userAddress.isNotEmpty
            ? Expanded(
                child: Column(
                  children: [
                    ListView.builder(
                        itemCount: state.userAddress.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            child: Material(
                              elevation: 2,
                              borderRadius: BorderRadius.circular(8),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: theme.colorScheme.onPrimary,
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                        color: theme
                                            .colorScheme.onPrimaryContainer,
                                        width: 0.4)),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color:
                                                    theme.colorScheme.primary),
                                            child: Image.asset(
                                                "assets/3x/house.png",
                                                height: 30,
                                                width: 30,
                                                color: theme
                                                    .colorScheme.secondary),
                                          ),
                                          const SizedBox(
                                            width: 6,
                                          ),
                                          Text(
                                              state.userAddress[index]
                                                  .addressType
                                                  .toString(),
                                              style: theme
                                                  .textTheme.titleMedium!
                                                  .copyWith(
                                                      color: theme.colorScheme
                                                          .secondary))
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            AppStrings.NAME,
                                            style: theme.textTheme.titleMedium!
                                                .copyWith(
                                                    color: theme
                                                        .colorScheme.secondary,
                                                    fontSize: 14,
                                                    fontFamily: BaseConstant
                                                        .poppinsMedium),
                                          ),
                                          const SizedBox(
                                            width: 6,
                                          ),
                                          Text(
                                            bloc.firstNameController.text +
                                                bloc.lastNameController.text,
                                            style: theme.textTheme.titleMedium!
                                                .copyWith(
                                                    color: BaseConstant
                                                        .selectedUserdataColor,
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.w400),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "${AppStrings.PHONE}:",
                                            style: theme.textTheme.titleMedium!
                                                .copyWith(
                                                    color: theme
                                                        .colorScheme.secondary,
                                                    fontSize: 14,
                                                    fontFamily: BaseConstant
                                                        .poppinsMedium),
                                          ),
                                          const SizedBox(
                                            width: 6,
                                          ),
                                          Text(
                                            bloc.mobileCodeController.text +
                                                bloc.mobileNumberController
                                                    .text,
                                            style: theme.textTheme.titleMedium!
                                                .copyWith(
                                                    color: BaseConstant
                                                        .selectedUserdataColor,
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.w400),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        // "Kuwait ,hawalli, bayan",
                                        "${state.userAddress[index].country} ${state.userAddress[index].state} ${state.userAddress[index].city}",
                                        style: theme.textTheme.titleMedium!
                                            .copyWith(
                                                color: BaseConstant
                                                    .selectedUserdataColor,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400),
                                      ),
                                      Text(
                                        // "block 9, st 11, house 9999",
                                        "${state.userAddress[index].address1} ${state.userAddress[index].address2} ${state.userAddress[index].houseNumber}",

                                        style: theme.textTheme.titleMedium!
                                            .copyWith(
                                                color: BaseConstant
                                                    .selectedUserdataColor,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      AppStrings.ADDED,
                      style: theme.textTheme.titleMedium!.copyWith(
                          color: theme.colorScheme.primaryContainer,
                          fontSize: 12,
                          fontWeight: FontWeight.w400),
                    ),
                    Text(
                      AppStrings.YOU_CAN_ADD_MORE,
                      style: theme.textTheme.titleMedium!.copyWith(
                          color: theme.colorScheme.primaryContainer,
                          fontSize: 12,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              )
            : const SizedBox();
      }),
      SizedBox(
          height: 40,
          width: MediaQuery.of(context).size.width,
          child: AppButton(
              textColor: theme.colorScheme.secondary,
              elevation: 0.0,
              isborder: true,
              borderColor: theme.colorScheme.primaryContainer,
              borderRadius: 8,
              fontSize: 16,
              color: colorScheme.onPrimary,
              text: AppStrings.ADD_ADDRESS,
              onClick: () {
                context.unfocus();
                Navigator.pushNamed(context, AddAddress.route, arguments: false)
                    .then((value) {
                  if (value != null && value is AddressModel) {
                    bloc.addUserAddressInState(value);
                  }
                });
                // bloc.updatePagerIndex(2);
              })),
      BlocBuilder<SignupScreenBloc, SignupScreenState>(
          builder: (context, state) {
        return state.userAddress.isNotEmpty
            ? const SizedBox(
                height: 10,
              )
            : const Spacer();
      }),
      SizedBox(
          height: 40,
          width: MediaQuery.of(context).size.width,
          child: AppButton(
              textColor: Colors.white,
              fontSize: 16,
              color: colorScheme.onPrimaryContainer,
              borderRadius: 8,
              text: AppStrings.LETS_START_SHOPPING,
              onClick: () {
                // context.unfocus();
                Navigator.pushNamedAndRemoveUntil(
                    context,
                    MainScreen.route,
                    arguments: false,
                    (route) => false);
              })),
    ]);
  }
}

class BrandIdentity extends StatelessWidget {
  BrandIdentity({super.key});

  DialogHelper get _dialogHelper => DialogHelper.instance();
  SnackbarHelper get _snackbarHelper => SnackbarHelper.instance();

  Future<void> _vendorRegister(SignupScreenBloc bloc, BuildContext context,
      DialogHelper dialogHelper) async {
    dialogHelper
      ..injectContext(context)
      ..showProgressDialog(AppStrings.CREATING_ACCOUNT);
    try {
      final response = await bloc.vendorRegister();
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
      bloc.updatePagerIndex(2);
    } catch (_) {
      dialogHelper.dismissProgress();
      dialogHelper.showTitleContentDialog(MaterialDialogContent.networkError(),
          () => _vendorRegister(bloc, context, dialogHelper));
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final colorScheme = theme.colorScheme;
    final bloc = context.read<SignupScreenBloc>();
    return SingleChildScrollView(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 20,
        ),
        Center(
          child: Text(AppStrings.BRAND_IDENTIFY,
              style: TextStyle(
                  color: theme.colorScheme.secondary,
                  fontWeight: FontWeight.w600,
                  fontFamily: BaseConstant.poppinsBold,
                  fontSize: 22)),
        ),
        const Center(
          child: Text(AppStrings.LETS_GET_TO_KNOW_YOU,
              style: TextStyle(
                  color: Color(0xffCACACA),
                  fontFamily: BaseConstant.poppinsLight,
                  fontWeight: FontWeight.w400,
                  fontSize: 16)),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          color: theme.colorScheme.secondary,
          height: 0.5,
        ),
        const SizedBox(
          height: 40,
        ),
        BlocBuilder<SignupScreenBloc, SignupScreenState>(
            builder: (context, state) {
          final eventData = state.fileDataEvent;
          ImageProvider image;
          if (eventData is! Data) {
            if (state.userImage.isNotEmpty) {
              image = NetworkImage(state.userImage);
            } else {
              image = const AssetImage("assets/3x/empty_image.png");
            }
          } else {
            final imageData = eventData.data as XFile;
            image = FileImage(File(imageData.path));
          }
          return Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: BaseConstant.brandIdentityColor,
                    shape: BoxShape.circle,
                    image: DecorationImage(image: image),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: InkWell(
                    onTap: () async {
                      final image = await ImagePicker()
                          .pickImage(source: ImageSource.gallery);
                      if (image == null) return;
                      bloc.handleImageSelection(image);
                    },
                    child: Container(
                      width: 30,
                      height: 30,
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
          );
        }),
        const SizedBox(
          height: 20,
        ),
        Padding(
            padding: const EdgeInsets.only(left: 2),
            child: Text(AppStrings.BRAND_IDENTIFY,
                style: theme.textTheme.titleMedium!.copyWith(fontSize: 14))),
        BlocBuilder<SignupScreenBloc, SignupScreenState>(
            buildWhen: (previous, current) =>
                previous.brandNameValidate != current.brandNameValidate,
            builder: (_, state) => AppTextField(
                isError: state.brandNameValidate,
                radius: 8,
                textInputAction: TextInputAction.next,
                onChanged: (String? value) {
                  if (value == null) return;
                  if (value.isNotEmpty && state.brandNameValidate) {
                    bloc.updateBrandValidate(false, '');
                  }
                },
                hint: AppStrings.ENTER_YOUR_BRAND_NAME,
                textInputType: TextInputType.emailAddress,
                controller: bloc.brandController)),
        Padding(
            padding: const EdgeInsets.only(left: 2),
            child: Text(AppStrings.SLOGAN,
                style: theme.textTheme.titleMedium!.copyWith(fontSize: 14))),
        BlocBuilder<SignupScreenBloc, SignupScreenState>(
            buildWhen: (previous, current) =>
                previous.salognNameValidate != current.salognNameValidate,
            builder: (_, state) => AppTextField(
                isError: state.salognNameValidate,
                radius: 8,
                textInputAction: TextInputAction.next,
                onChanged: (String? value) {
                  if (value == null) return;
                  if (value.isNotEmpty && state.salognNameValidate) {
                    bloc.updateSaloganValidate(false, '');
                  }
                },
                hint: AppStrings.ENTER_YOUR_SLOGAN,
                textInputType: TextInputType.emailAddress,
                controller: bloc.salognController)),
        Padding(
            padding: const EdgeInsets.only(left: 2),
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                      text: AppStrings.MY_BRAND_IS_FOR,
                      style:
                          theme.textTheme.titleMedium!.copyWith(fontSize: 14)),
                  const WidgetSpan(
                      alignment: PlaceholderAlignment.baseline,
                      baseline: TextBaseline.alphabetic,
                      child: SizedBox(width: 4)),
                  TextSpan(
                      text: AppStrings.MULTIPLE_OPTIONS,
                      style: theme.textTheme.titleMedium!.copyWith(
                          color: BaseConstant.addressSelectionColor,
                          fontSize: 10)),
                ],
              ),
            )),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            BlocBuilder<SignupScreenBloc, SignupScreenState>(
                builder: (context, state) {
              return CustomCheckbox(
                  value: state.isWomenSelect,
                  fillColor: theme.colorScheme.onPrimary,
                  onChanged: (value) {
                    bloc.updateWomenValue(value);
                  });
            }),
            const SizedBox(
              width: 5,
            ),
            BlocBuilder<SignupScreenBloc, SignupScreenState>(
                builder: (context, state) {
              return Text(AppStrings.WOMEN,
                  style: theme.textTheme.titleMedium!.copyWith(
                      color: state.isWomenSelect == true
                          ? theme.colorScheme.secondary
                          : const Color(0xff999999),
                      fontSize: 14));
            }),
            const SizedBox(
              width: 10,
            ),
            BlocBuilder<SignupScreenBloc, SignupScreenState>(
                builder: (context, state) {
              return CustomCheckbox(
                  fillColor: theme.colorScheme.onPrimary,
                  value: state.isKidsSelect,
                  onChanged: (value) {
                    bloc.updateKidValue(value);
                  });
            }),
            const SizedBox(
              width: 5,
            ),
            BlocBuilder<SignupScreenBloc, SignupScreenState>(
                builder: (context, state) {
              return Text(AppStrings.Kids,
                  style: theme.textTheme.titleMedium!.copyWith(
                      color: state.isKidsSelect == true
                          ? theme.colorScheme.secondary
                          : const Color(0xff999999),
                      fontSize: 14));
            }),
            const SizedBox(
              width: 10,
            ),
            BlocBuilder<SignupScreenBloc, SignupScreenState>(
                builder: (context, state) {
              return CustomCheckbox(
                  fillColor: theme.colorScheme.onPrimary,
                  value: state.isMenSelect,
                  onChanged: (value) {
                    bloc.updateMenValue(value);
                  });
            }),
            const SizedBox(
              width: 5,
            ),
            BlocBuilder<SignupScreenBloc, SignupScreenState>(
                builder: (context, state) {
              return Text(AppStrings.MEN,
                  style: theme.textTheme.titleMedium!.copyWith(
                      color: state.isMenSelect == true
                          ? theme.colorScheme.secondary
                          : const Color(0xff999999),
                      fontSize: 14));
            }),
          ],
        ),
        BlocBuilder<SignupScreenBloc, SignupScreenState>(
            buildWhen: (previous, current) =>
                previous.errorText != current.errorText,
            builder: (_, state) {
              if (state.errorText.isEmpty) {
                return const SizedBox();
              }
              return Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
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
          height: 70,
        ),
        SizedBox(
            height: 40,
            width: MediaQuery.of(context).size.width,
            child: AppButton(
                textColor: Colors.white,
                fontSize: 16,
                color: colorScheme.onPrimaryContainer,
                borderRadius: 8,
                text: AppStrings.NEXT,
                onClick: () {
                  context.unfocus();
                  final bool isbrandLogoSelected =
                      bloc.state.fileDataEvent is Data;
                  if (isbrandLogoSelected == false) {
                    bloc.updateErrorText(AppStrings.BRAND_LOGO_IS_EMPTY);
                    return;
                  } else if (bloc.brandController.text.isEmpty) {
                    bloc.updateBrandValidate(
                        true, AppStrings.BRAND_NAME_IS_EMPTY);
                    return;
                  } else if (bloc.salognController.text.isEmpty) {
                    bloc.updateSaloganValidate(
                        true, AppStrings.SALOGAN_IS_EMPTY);
                    return;
                  }
                  _vendorRegister(bloc, context, _dialogHelper);

                  // bloc.updatePagerIndex(2);
                }))
      ],
    ));
  }
}
