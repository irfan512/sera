import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sera/extensions/context_extension.dart';
import 'package:sera/helper/snackbar_helper.dart';
import 'package:sera/ui/auth/choose_yourself/choose_yourself_bloc.dart';
import 'package:sera/ui/auth/choose_yourself/choose_yourself_state.dart';
import 'package:sera/ui/auth/signup/signup_main_screen.dart';
import 'package:sera/ui/common/app_button.dart';
import 'package:sera/util/app_strings.dart';
import 'package:sera/util/base_constants.dart';


class ChooseScreen extends StatelessWidget {
  static const String route = 'choose_screen';
  const ChooseScreen({super.key});

  SnackbarHelper get _snackbarHelper => SnackbarHelper.instance();

  @override
  Widget build(BuildContext context) {
    final size = context.mediaSize;
    final theme = context.theme;
    final colorScheme = theme.colorScheme;
    final bloc = context.read<ChooseScreenBloc>();
    return Scaffold(
        backgroundColor: theme.colorScheme.onPrimary,
        body: Stack(children: [
          Positioned(
            top: -70,
            left: -115,
            child: Container(
              height: 220,
              width: 220,
              decoration: BoxDecoration(
                color: theme.colorScheme.primary.withOpacity(0.3),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 100),
                    Text(AppStrings.CHOOSE_YOURSELF,
                        style: TextStyle(
                            color: theme.colorScheme.secondary,
                            fontWeight: FontWeight.w600,
                            fontFamily: BaseConstant.poppinsBold,
                            fontSize: 22)),
                    Text(AppStrings.LETS_CREATE_YOUR_PROFILE,
                        style: TextStyle(
                            color: theme.colorScheme.secondaryContainer,
                            fontFamily: BaseConstant.poppinsLight,
                            fontWeight: FontWeight.w400,
                            fontSize: 16)),
                    Divider(
                      color: theme.colorScheme.onSecondaryContainer,
                    ),
                    const SizedBox(height: 50),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        BlocBuilder<ChooseScreenBloc, ChooseScreenState>(
                            builder: (context, state) {
                          return state.isCustomerSelect == true
                              ? GestureDetector(
                                  onTap: () {
                                    bloc.toogleCustomerSelect(false);
                                  },
                                  child: Image.asset(
                                    "assets/3x/customer_selected.png",
                                    height: 260,
                                    width: size.width * .4,
                                  ),
                                )
                              : GestureDetector(
                                  onTap: () {
                                    bloc.toogleCustomerSelect(true);
                                    bloc.toogleVendorSelect(false);
                                  },
                                  child: Image.asset(
                                    "assets/3x/customer.png",
                                    height: 260,
                                    width: size.width * .4,
                                  ),
                                );
                        }),
                        BlocBuilder<ChooseScreenBloc, ChooseScreenState>(
                            builder: (context, state) {
                          return state.isVendorSelect == true
                              ? GestureDetector(
                                  onTap: () {
                                    bloc.toogleVendorSelect(false);
                                  },
                                  child: Image.asset(
                                    "assets/3x/vendor_selected.png",
                                    height: 260,
                                    width: size.width * .4,
                                  ),
                                )
                              : GestureDetector(
                                  onTap: () {
                                    bloc.toogleVendorSelect(true);
                                    bloc.toogleCustomerSelect(false);
                                  },
                                  child: Image.asset(
                                    "assets/3x/vendor.png",
                                    height: 260,
                                    width: size.width * .4,
                                  ),
                                );
                        }),
                      ],
                    ),
                    const Spacer(),
                    SizedBox(
                        height: 40,
                        width: MediaQuery.of(context).size.width,
                        child: AppButton(
                            textColor: const Color.fromRGBO(255, 255, 255, 1),
                            borderRadius: 8,
                            fontSize: 16,
                            color: colorScheme.primary,
                            text: AppStrings.NEXT,
                            onClick: () {
                              context.unfocus();
                              // if (bloc.state.isCustomerSelect == false &&
                              //     bloc.state.isVendorSelect == false) {
                              //   _snackbarHelper
                              //     ..injectContext(context)
                              //     ..showSnackbar(
                              //         snackbarMessage: const SnackbarMessage
                              //             .smallMessageError(
                              //             content: "Select YourSelf"));
                              // } else {
                                Navigator.pushNamed(
                                    context, SignupMainScreen.route,
                                    arguments:
                                        bloc.state.isCustomerSelect == true
                                            ? "Customer"
                                            : "Vendor");
                              // }
                            })),
                    const SizedBox(
                      height: 30,
                    ),
                  ])),
          SizedBox(height: context.isHaveBottomNotch ? 25 : 15)
        ]));
  }
}
