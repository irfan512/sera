// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sera/data/material_dailog_content.dart';
import 'package:sera/data/snackbar_message.dart';
import 'package:sera/extensions/context_extension.dart';
import 'package:sera/helper/dialog_helper.dart';
import 'package:sera/helper/shared_preference_helper.dart';
import 'package:sera/helper/snackbar_helper.dart';
import 'package:sera/ui/auth/choose_yourself/choose_yourself_screen.dart';
import 'package:sera/ui/main/main_screen.dart';
import 'package:sera/util/app_strings.dart';
import 'package:sera/util/base_constants.dart';
import '../../common/app_button.dart';
import '../../common/app_text_field.dart';
import 'login_screen_bloc.dart';
import 'login_screen_state.dart';

class LoginScreen extends StatelessWidget {
  static const String route = 'login_screen';
  LoginScreen({super.key});

  final _sharedPreferenceHelper = SharedPreferenceHelper.instance();
  DialogHelper get _dialogHelper => DialogHelper.instance();
  SnackbarHelper get _snackbarHelper => SnackbarHelper.instance();

  Future<void> _login(LoginScreenBloc bloc, BuildContext context,
      DialogHelper dialogHelper) async {
    dialogHelper
      ..injectContext(context)
      ..showProgressDialog(AppStrings.LOGGING);
    try {
      final response = await bloc.login();
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
                content: AppStrings.SUCCESSFULLY_LOGGED_IN),
            margin: EdgeInsets.only(
                left: 25,
                right: 25,
                bottom: context.isHaveBottomNotch ? 100 : 90));
      Navigator.pushNamedAndRemoveUntil(
          context, MainScreen.route, arguments: false, (route) => false);
    } catch (_) {
      dialogHelper.dismissProgress();
      dialogHelper.showTitleContentDialog(MaterialDialogContent.networkError(),
          () => _login(bloc, context, dialogHelper));
    }
  }

  Future<void> _socialLogin(LoginScreenBloc bloc, BuildContext context,
      DialogHelper dialogHelper, token, provider) async {
    dialogHelper
      ..injectContext(context)
      ..showProgressDialog(AppStrings.LOGGING);
    try {
      final response = await bloc.socialLogin(token, provider);
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
                content: AppStrings.SUCCESSFULLY_LOGGED_IN),
            margin: EdgeInsets.only(
                left: 25,
                right: 25,
                bottom: context.isHaveBottomNotch ? 100 : 90));
      Navigator.pushNamedAndRemoveUntil(
          context, MainScreen.route, arguments: false, (route) => false);
    } catch (_) {
      dialogHelper.dismissProgress();
      dialogHelper.showTitleContentDialog(MaterialDialogContent.networkError(),
          () => _socialLogin(bloc, context, dialogHelper, token, provider));
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;
    final bloc = context.read<LoginScreenBloc>();
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(children: [
          Positioned(
            top: -130,
            left: -120,
            child: Container(
              height: 320,
              width: 300,
              decoration: BoxDecoration(
                color: theme.colorScheme.primary.withOpacity(0.3),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(AppStrings.APP_NAME,
                        style: TextStyle(
                            color: theme.colorScheme.secondary,
                            fontWeight: FontWeight.w600,
                            fontFamily: BaseConstant.poppinsBold,
                            fontSize: 24)),
                  ),
                  const SizedBox(height: 60),
                  Text(AppStrings.EMAIL, style: textTheme.titleMedium),

                  BlocBuilder<LoginScreenBloc, LoginScreenState>(
                      buildWhen: (previous, current) =>
                          previous.emailValidate != current.emailValidate,
                      builder: (_, state) => AppTextField(
                          radius: 8,
                          isError: state.emailValidate,
                          onChanged: (String? value) {
                            if (value == null) return;
                            if (value.isNotEmpty && state.emailValidate) {
                              bloc.updateEmailValidation(false, '');
                            }
                          },
                          hint: AppStrings.ENTER_YOUR_EMAIL,
                          // prefixIcon: const Icon(Icons.email_outlined),
                          textInputType: TextInputType.emailAddress,
                          controller: bloc.emailController)),

                  Text(AppStrings.PASSWORD, style: textTheme.titleMedium),
                  BlocBuilder<LoginScreenBloc, LoginScreenState>(
                      buildWhen: (previous, current) =>
                          (previous.passwordError != current.passwordError ||
                              previous.isPasswordShown !=
                                  current.isPasswordShown),
                      builder: (_, state) => AppTextField(
                          radius: 8,
                          onChanged: (String? value) {
                            if (value == null) return;
                            if (value.isNotEmpty && state.passwordError) {
                              bloc.updatePasswordError(false, '');
                            }
                          },
                          textInputAction: TextInputAction.done,
                          isError: state.passwordError,
                          onSuffixClick: () =>
                              bloc.togglePasswordVisibilityState(),
                          hint: AppStrings.ENTER_YOUR_PASSWORD,
                          // suffixIcon: Icon(
                          //     !state.isPasswordShown
                          //         ? Icons.visibility_outlined
                          //         : Icons.visibility_off_outlined,
                          //     size: 22,
                          //     color: theme.primaryColor),
                          isObscure: !state.isPasswordShown,
                          textInputType: TextInputType.visiblePassword,
                          controller: bloc.passwordController)),
        
                  Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                            onTap: () {

//  _dialogHelper..injectContext(context)..

                            },
                            child: Text(AppStrings.FORGET_PASSWORD,
                                style: textTheme.labelLarge!.copyWith(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: colorScheme.primaryContainer)))
                      ]),
                  const SizedBox(height: 30),

                  BlocBuilder<LoginScreenBloc, LoginScreenState>(
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
                                border:
                                    Border.all(color: theme.colorScheme.error)),
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

                  const SizedBox(height: 10),
                  SizedBox(
                      height: 40,
                      width: MediaQuery.of(context).size.width,
                      child: AppButton(
                          textColor: Colors.white,
                          fontSize: 16,
                          borderRadius: 8,
                          color: colorScheme.primary,
                          text: AppStrings.LOGIN,
                          onClick: () async {
                            context.unfocus();
                            // await _sharedPreferenceHelper
                            //     .setUserType('Customer');
                            // Navigator.pushNamedAndRemoveUntil(
                            //     context, MainScreen.route, (route) => false);
                            // // // Navigator.pushNamed(context, KNET.route);

                            if (bloc.emailController.text.isEmpty) {
                              bloc.updateEmailValidation(
                                  true, AppStrings.ENTER_YOUR_EMAIL);
                              return;
                            } else if (bloc.passwordController.text.isEmpty) {
                              bloc.updatePasswordError(
                                  true, AppStrings.ENTER_YOUR_PASSWORD);
                              return;
                            }
                            _login(bloc, context, _dialogHelper);
                          })),
                  const SizedBox(height: 10),

                  Center(
                    child: GestureDetector(
                      onTap: () async {
                        await _sharedPreferenceHelper.setUserType('Customer');
                        Navigator.pushNamed(context, MainScreen.route);
                      },
                      child: Text(AppStrings.CONTINUE_AS_GUEST,
                          style: textTheme.labelLarge!.copyWith(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: colorScheme.secondary)),
                    ),
                  ),
                  const SizedBox(height: 30),

                  Center(
                    child: Text(AppStrings.OR_LOGIN_WITH,
                        style: textTheme.labelLarge!.copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: colorScheme.secondaryContainer)),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          FacebookAuth authIntance = FacebookAuth.instance;
                          try {
                            final result = await authIntance.login();
                            FacebookAuth.instance
                                .getUserData()
                                .then((value) {});
                            final tokencheck = result.accessToken!.isExpired;
                            if (!tokencheck) {
                              _socialLogin(
                                  bloc,
                                  context,
                                  _dialogHelper,
                                  result
                                      .accessToken!.token
                                      .toString(),
                                  'facebook');
                            } else {
                              _snackbarHelper
                                ..injectContext(context)
                                ..showSnackbar(
                                    snackbarMessage: const SnackbarMessage
                                        .smallMessage(
                                        content:
                                            'Your account is already connected with Facebook. Please remove app authentication from Facebook App Settings to login again.'),
                                    margin: EdgeInsets.only(
                                        left: 25,
                                        right: 25,
                                        bottom: context.isHaveBottomNotch
                                            ? 100
                                            : 90));
                            }
                          } catch (e) {}
                        },
                        child: Image.asset(
                          "assets/3x/facebook.png",
                          height: 30,
                          width: 30,
                        ),
                      ),
                      const SizedBox(
                        width: 40,
                      ),
                      GestureDetector(
                        onTap: () async {
                          GoogleSignIn _googleSignIn = GoogleSignIn();
                          try {
                            var result = await _googleSignIn.signIn();

                            if (result != null) {
                              var token = await result.authentication
                                  .then((value) => value.accessToken);

                              await _socialLogin(bloc, context, _dialogHelper,
                                  token.toString(), 'google');
                            }
                          } catch (error) {
                            debugPrint(error.toString());
                          }
                        },
                        child: Image.asset(
                          "assets/3x/google.png",
                          height: 27,
                          width: 27,
                        ),
                      ),
                      const SizedBox(
                        width: 40,
                      ),
                      Image.asset(
                        "assets/3x/apple.png",
                        height: 30,
                        width: 30,
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(AppStrings.DONT_HAVE_ACCOUNT,
                            style: textTheme.labelLarge!.copyWith(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: colorScheme.onPrimaryContainer)),
                        GestureDetector(
                            onTap: () {
                              context.unfocus();
                              Navigator.pushNamed(context, ChooseScreen.route);
                            },
                            child: Text(AppStrings.SIGN_UP,
                                style: textTheme.labelLarge!.copyWith(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: colorScheme.secondary)))
                      ]),
                  SizedBox(height: context.isHaveBottomNotch ? 20 : 15)
                ]),
          )
        ]));
  }
}
