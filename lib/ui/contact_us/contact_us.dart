// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sera/data/material_dailog_content.dart';
import 'package:sera/data/snackbar_message.dart';
import 'package:sera/extensions/context_extension.dart';
import 'package:sera/helper/dialog_helper.dart';
import 'package:sera/helper/snackbar_helper.dart';
import 'package:sera/ui/common/app_bar.dart';
import 'package:sera/ui/common/app_button.dart';
import 'package:sera/ui/common/app_text_field.dart';
import 'package:sera/ui/contact_us/contact_us_bloc.dart';
import 'package:sera/ui/contact_us/contact_us_state.dart';
import 'package:sera/util/app_strings.dart';
import 'package:sera/util/base_constants.dart';

class ContactUs extends StatelessWidget {
  static const String route = '/contact_us_screen';
  const ContactUs({super.key});
  DialogHelper get _dialogHelper => DialogHelper.instance();
  SnackbarHelper get _snackbarHelper => SnackbarHelper.instance();

  Future<void> _contactUs(ContactUsBloc bloc, BuildContext context,
      DialogHelper dialogHelper) async {
    dialogHelper
      ..injectContext(context)
      ..showProgressDialog(AppStrings.LOGGING);
    try {
      final response = await bloc.contactUs();
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
                content: "Message sent! We'll be in touch soon."),
            margin: EdgeInsets.only(
                left: 25,
                right: 25,
                bottom: context.isHaveBottomNotch ? 100 : 90));

      Future.delayed(const Duration(seconds: 1), () {
        Navigator.pop(context);
      });
    } catch (_) {
      dialogHelper.dismissProgress();
      dialogHelper.showTitleContentDialog(MaterialDialogContent.networkError(),
          () => _contactUs(bloc, context, dialogHelper));
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final textTheme = context.theme.textTheme;
    final bloc = context.read<ContactUsBloc>();

    return Scaffold(
      backgroundColor: theme.colorScheme.onPrimary,
      appBar: CustomAppBar(
        isbottom: true,
        elevation: 0.0,
        backgroundColor: theme.colorScheme.onPrimary,
        iscenterTitle: true,
        title: Text(
          AppStrings.CONTACT_US,
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
                  child: Text(AppStrings.EMAIL, style: textTheme.titleMedium)),
              BlocBuilder<ContactUsBloc, ContactUsState>(
                  buildWhen: (previous, current) =>
                      previous.emailValidate != current.emailValidate,
                  builder: (_, state) => AppTextField(
                      isError: state.emailValidate,
                      textInputAction: TextInputAction.next,
                      onChanged: (String? value) {
                        if (value == null) return;
                        if (value.isNotEmpty && state.emailValidate) {
                          bloc.updateEmailValidate(false, '');
                        }
                      },
                      hint: AppStrings.ENTER_YOUR_EMAIL,
                      textInputType: TextInputType.name,
                      radius: 8,
                      controller: bloc.emailController)),
              Padding(
                  padding: const EdgeInsets.only(left: 2),
                  child:
                      Text(AppStrings.MESSAGE, style: textTheme.titleMedium)),
              const SizedBox(
                height: 10,
              ),
              BlocBuilder<ContactUsBloc, ContactUsState>(
                  buildWhen: (previous, current) =>
                      previous.messageValidate != current.messageValidate,
                  builder: (_, state) => Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.only(right: 10, left: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                                color: theme.colorScheme.onPrimaryContainer),
                            color: Colors.white),
                        child: TextFormField(
                            maxLines: 12,
                            textInputAction: TextInputAction.next,
                            onChanged: (String? value) {
                              if (value == null) return;
                              if (value.isNotEmpty && state.messageValidate) {
                                bloc.updateMessageValidate(false, '');
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
                            controller: bloc.messageController),
                      )),
              BlocBuilder<ContactUsBloc, ContactUsState>(
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
                height: 50,
              ),
              SizedBox(
                  height: 40,
                  width: MediaQuery.of(context).size.width,
                  child: AppButton(
                      textColor: Colors.white,
                      fontSize: 16,
                      borderRadius: 8,
                      color: theme.colorScheme.primary,
                      text: AppStrings.SEND,
                      onClick: () {
                        context.unfocus();
                        if (bloc.emailController.text.isEmpty) {
                          bloc.updateEmailValidate(
                              true, AppStrings.ENTER_YOUR_EMAIL);
                          return;
                        } else if (bloc.messageController.text.isEmpty) {
                          bloc.updateMessageValidate(
                              true, AppStrings.ENTER_YOUR_MESSAGE);
                          return;
                        }
                        _contactUs(bloc, context, _dialogHelper);
                      })),
            ],
          ),
        ),
      ),
    );
  }
}
