// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sera/data/material_dailog_content.dart';
import 'package:sera/data/snackbar_message.dart';
import 'package:sera/extensions/context_extension.dart';
import 'package:sera/helper/dialog_helper.dart';
import 'package:sera/helper/snackbar_helper.dart';
import 'package:sera/ui/auth/add_address/add_address_bloc.dart';
import 'package:sera/ui/auth/add_address/add_address_state.dart';
import 'package:sera/ui/common/app_bar.dart';
import 'package:sera/ui/common/app_button.dart';
import 'package:sera/ui/common/app_text_field.dart';
import 'package:sera/util/app_strings.dart';
import 'package:sera/util/base_constants.dart';

class AddAddress extends StatelessWidget {
  static const String route = "new_address_screen";
  final bool? iseditScreen;
  AddAddress({super.key, this.iseditScreen});

  DialogHelper get _dialogHelper => DialogHelper.instance();
  SnackbarHelper get _snackbarHelper => SnackbarHelper.instance();

  Future<void> _addAddress(NewAddressScreenBloc bloc, BuildContext context,
      DialogHelper dialogHelper) async {
    dialogHelper
      ..injectContext(context)
      ..showProgressDialog(AppStrings.LOADING);
    try {
      final response = await bloc.addAddress();
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

      Navigator.pop(context, response.address);

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
          () => _addAddress(bloc, context, dialogHelper));
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final textTheme = context.theme.textTheme;
    final bloc = context.read<NewAddressScreenBloc>();
    return Scaffold(
      backgroundColor: theme.colorScheme.onPrimary,
      appBar: CustomAppBar(
        isbottom: true,
        elevation: 0.0,
        backgroundColor: theme.colorScheme.onPrimary,
        iscenterTitle: true,
        title: iseditScreen == true
            ? Text(
                AppStrings.EDIT_ADDRESS,
                style: theme.textTheme.titleLarge!.copyWith(
                    color: theme.colorScheme.secondary,
                    fontSize: 14,
                    fontWeight: FontWeight.w500),
              )
            : Text(
                AppStrings.NEW_ADDRESS,
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BlocBuilder<NewAddressScreenBloc, NewAddressScreenState>(
                      builder: (context, state) {
                    return InkWell(
                      onTap: () {
                        bloc.toogleFlatSelect(false);
                        bloc.toogleHouseSelect(true);
                      },
                      child: Container(
                        height: 60,
                        width: context.mediaSize.width * .43,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(06),
                            color: theme.colorScheme.onSecondary),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset("assets/3x/house.png",
                                height: 30,
                                width: 30,
                                color: state.isFlatSelect == true
                                    ? BaseConstant.addressSelectionColor
                                    : theme.colorScheme.secondary),
                            Text(AppStrings.HOUSE,
                                style: textTheme.titleMedium!.copyWith(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                    color: state.isFlatSelect == true
                                        ? BaseConstant.addressSelectionColor
                                        : theme.colorScheme.secondary)),
                          ],
                        ),
                      ),
                    );
                  }),
                  BlocBuilder<NewAddressScreenBloc, NewAddressScreenState>(
                      builder: (context, state) {
                    return InkWell(
                      onTap: () {
                        bloc.toogleFlatSelect(true);
                        bloc.toogleHouseSelect(false);
                      },
                      child: Container(
                        height: 60,
                        width: context.mediaSize.width * .43,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(06),
                            color: theme.colorScheme.onSecondary),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset("assets/3x/Flat.png",
                                height: 30,
                                width: 30,
                                color: state.isFlatSelect != true
                                    ? BaseConstant.addressSelectionColor
                                    : theme.colorScheme.secondary),
                            Text(AppStrings.Flat,
                                style: textTheme.titleMedium!.copyWith(
                                   fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                    color: state.isFlatSelect != true
                                        ? BaseConstant.addressSelectionColor
                                        : theme.colorScheme.secondary)),
                          ],
                        ),
                      ),
                    );
                  })
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Text(AppStrings.COUNTRY, style: textTheme.titleMedium),
              BlocBuilder<NewAddressScreenBloc, NewAddressScreenState>(
                  buildWhen: (previous, current) =>
                      previous.countryValidate != current.countryValidate,
                  builder: (_, state) => AppTextField(
                      radius: 8,
                      isError: state.countryValidate,
                      onChanged: (String? value) {
                        if (value == null) return;
                        if (value.isNotEmpty && state.countryValidate) {
                          bloc.updateCountryValidation(false, '');
                        }
                      },
                      hint: AppStrings.ENTER_COUNTRY,
                      textInputType: TextInputType.emailAddress,
                      controller: bloc.countryController)),
              Text(AppStrings.STATE_GOVERN, style: textTheme.titleMedium),
              BlocBuilder<NewAddressScreenBloc, NewAddressScreenState>(
                  buildWhen: (previous, current) =>
                      previous.stateValidate != current.stateValidate,
                  builder: (_, state) => AppTextField(
                      radius: 8,
                      isError: state.stateValidate,
                      onChanged: (String? value) {
                        if (value == null) return;
                        if (value.isNotEmpty && state.stateValidate) {
                          bloc.updateStateError(false, '');
                        }
                      },
                      hint: AppStrings.ENTER_STATE,
                      textInputType: TextInputType.emailAddress,
                      controller: bloc.stateController)),
              Text(AppStrings.CITY, style: textTheme.titleMedium),
              BlocBuilder<NewAddressScreenBloc, NewAddressScreenState>(
                  buildWhen: (previous, current) =>
                      previous.cityValidate != current.cityValidate,
                  builder: (_, state) => AppTextField(
                      radius: 8,
                      isError: state.cityValidate,
                      onChanged: (String? value) {
                        if (value == null) return;
                        if (value.isNotEmpty && state.cityValidate) {
                          bloc.updateCityError(false, '');
                        }
                      },
                      hint: AppStrings.ENTER_CITY,
                      textInputType: TextInputType.emailAddress,
                      controller: bloc.cityController)),
              Text(AppStrings.ADDRESS1, style: textTheme.titleMedium),
              BlocBuilder<NewAddressScreenBloc, NewAddressScreenState>(
                  buildWhen: (previous, current) =>
                      previous.address1Validate != current.address1Validate,
                  builder: (_, state) => AppTextField(
                      radius: 8,
                      isError: state.address1Validate,
                      onChanged: (String? value) {
                        if (value == null) return;
                        if (value.isNotEmpty && state.address1Validate) {
                          bloc.updateAddress1Error(false, '');
                        }
                      },
                      hint: AppStrings.ENTER_BLOCK,
                      textInputType: TextInputType.emailAddress,
                      controller: bloc.address1Controller)),
              Text(AppStrings.ADDRESS2, style: textTheme.titleMedium),
              BlocBuilder<NewAddressScreenBloc, NewAddressScreenState>(
                  buildWhen: (previous, current) =>
                      previous.address2Validate != current.address2Validate,
                  builder: (_, state) => AppTextField(
                      radius: 8,
                      isError: state.address2Validate,
                      onChanged: (String? value) {
                        if (value == null) return;
                        if (value.isNotEmpty && state.address2Validate) {
                          bloc.updateAddress2Error(false, '');
                        }
                      },
                      hint: AppStrings.ENTER_STREET,
                      textInputType: TextInputType.emailAddress,
                      controller: bloc.address2Controller)),
              Text(AppStrings.HOUSE_NUMBER, style: textTheme.titleMedium),
              BlocBuilder<NewAddressScreenBloc, NewAddressScreenState>(
                  buildWhen: (previous, current) =>
                      previous.houseNoValidate != current.houseNoValidate,
                  builder: (_, state) => AppTextField(
                      radius: 8,
                      isError: state.houseNoValidate,
                      onChanged: (String? value) {
                        if (value == null) return;
                        if (value.isNotEmpty && state.houseNoValidate) {
                          bloc.updateHouseNoError(false, '');
                        }
                      },
                      hint: AppStrings.ENTER_HOUSE_NUMBER,
                      textInputType: TextInputType.emailAddress,
                      controller: bloc.houseNoController)),
              const SizedBox(height: 10),
              BlocBuilder<NewAddressScreenBloc, NewAddressScreenState>(
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
                      text: AppStrings.ADD,
                      onClick: () {
                        context.unfocus();
// Navigator.pop(context);
                        if (bloc.countryController.text.isEmpty) {
                          bloc.updateCountryValidation(
                              true, AppStrings.COUNTRY_NAME_IS_EMPTY);
                          return;
                        } else if (bloc.stateController.text.isEmpty) {
                          bloc.updateStateError(
                              true, AppStrings.STATE_IS_EMPTY);
                          return;
                        } else if (bloc.cityController.text.isEmpty) {
                          bloc.updateCityError(true, AppStrings.CITY_IS_EMPTY);
                          return;
                        } else if (bloc.address1Controller.text.isEmpty) {
                          bloc.updateAddress1Error(
                              true, AppStrings.ADDRESS1_IS_EMPTY);
                          return;
                        } else if (bloc.address2Controller.text.isEmpty) {
                          bloc.updateAddress2Error(
                              true, AppStrings.ADDRESS2_IS_EMPTY);
                          return;
                        } else if (bloc.houseNoController.text.isEmpty) {
                          bloc.updateHouseNoError(
                              true, AppStrings.HOUSE_NO_IS_EMPTY);
                          return;
                        } else {
                          _addAddress(bloc, context, _dialogHelper);
                        }
                      })),
            ],
          ),
        ),
      ),
    );
  }
}
