import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sera/extensions/context_extension.dart';
import 'package:sera/ui/add_product/add_product_screen.dart';
import 'package:sera/ui/auth/signup/signup_screen_state.dart';
import 'package:sera/ui/common/customer_step_slider.dart';
import 'package:sera/ui/common/vendor_step_slider.dart';
import 'package:sera/ui/main/main_screen.dart';
import '../../../../util/app_strings.dart';
import '../../../../util/base_constants.dart';
import '../../../common/app_button.dart';
import '../signup_screen_bloc.dart';

class SignupFinishedNav extends StatelessWidget {
  static const String key_title = '/signup_end_key_title';
  const SignupFinishedNav({super.key});
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
                      currentIndex: 2,
                      defaultColor: BaseConstant.signupSliderColor,
                      activeColor: theme.colorScheme.secondary)
                  : VendorStepIndicator(
                      currentIndex: 2,
                      defaultColor: BaseConstant.signupSliderColor,
                      activeColor: theme.colorScheme.secondary);
            }),
            BlocBuilder<SignupScreenBloc, SignupScreenState>(
                builder: (context, state) {
              return state.isAnnounceShow == true
                  ? const Expanded(child: Announce())
                  : const Expanded(child: AddStyle());
            }),
          ]),
        ));
  }
}

class AddStyle extends StatelessWidget {
  const AddStyle({super.key});
  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final colorScheme = theme.colorScheme;
    final bloc = context.read<SignupScreenBloc>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(
          height: 20,
        ),
        Text(AppStrings.ADD_STYLE,
            style: TextStyle(
                color: theme.colorScheme.secondary,
                fontWeight: FontWeight.w600,
                fontFamily: BaseConstant.poppinsBold,
                fontSize: 22)),
      const  Text(AppStrings.ITS_TIME_TO_ADD_STYLE,
            style: TextStyle(
                color: Color(0xffCACACA),
                fontFamily: BaseConstant.poppinsLight,
                fontWeight: FontWeight.w400,
                fontSize: 16)),
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
                text: AppStrings.ADD_PRODUCT,
                onClick: () {
                  context.unfocus();
                  Navigator.pushNamed(context, AddProductScreen.route)
                      .then((value) {});
                })),
        const SizedBox(
          height: 20,
        ),
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
                text: AppStrings.ADD_A_FLITS,
                onClick: () {
                  context.unfocus();
                  // Navigator.pushNamed(context, AddAddress.route)
                  //     .then((value) {
                  //   bloc.toogleAddressShow(true);
                  // });
                  // bloc.updatePagerIndex(1);
                })),
        const SizedBox(
          height: 20,
        ),
        Text(AppStrings.MINIMUM_OF_1_PRODUCT_AND_1_VIDEO,
            style: TextStyle(
                color: theme.colorScheme.primaryContainer,
                fontFamily: BaseConstant.poppinsLight,

                fontSize: 14)),
    const SizedBox(height: 70,),
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
                  // Navigator.pushNamed(context, MainScreen.route);
                  bloc.updateAnnouncePage(true);
                })),
      ],
    );
  }
}

class Announce extends StatelessWidget {
  const Announce({super.key});
  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final colorScheme = context.theme.colorScheme;
    final bloc = context.read<SignupScreenBloc>();
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        Text(AppStrings.ANNOUNCE,
            style: TextStyle(
                color: theme.colorScheme.secondary,
                fontWeight: FontWeight.w600,
                fontFamily: BaseConstant.poppinsBold,
                fontSize: 20)),
       const Text(AppStrings.TIME_TO_ANNOUNCE_TO_THE_WORLD,
            style: TextStyle(
                  color: Color(0xffCACACA),
                fontFamily: BaseConstant.poppinsLight,
                fontSize: 16)),
        const SizedBox(
          height: 10,
        ),
        Container(
          color: const Color(0xff888F7F),
          height: 0.5,
        ),
        const SizedBox(
          height: 30,
        ),

        BlocBuilder<SignupScreenBloc, SignupScreenState>(
            // buildWhen: (previous, current) =>
            //     previous.bioValidate != current.bioValidate,
            builder: (_, state) => Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.only(right: 8, left: 8),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: const Color(0xfff8f8f7)),
                  child: TextFormField(
                      maxLines: 6,
                      textInputAction: TextInputAction.next,
                      onChanged: (String? value) {
                        // if (value == null) return;
                        // if (value.isNotEmpty && state.bioValidate) {
                        //   bloc.updateBioValidate(false, '');
                        // }
                      },
                      keyboardType: TextInputType.name,
                      style: theme.textTheme.labelLarge!.copyWith(
                          color: theme.colorScheme.onSecondaryContainer,
                          fontSize: 14),
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          hintText:
                              "${AppStrings.WRITE_HERE_YOUR_FIRST}\n\n${AppStrings.HOW_TO_ANNOUNCE_TO_THE_WORLD}",
                          hintStyle: theme.textTheme.labelLarge!.copyWith(
                              color: const Color(0xff999999),
                              fontSize: 14)),
                      controller: bloc.announceController),
                )),

        // Container(
        //   decoration: BoxDecoration(
        //     color: const Color(0xfff8f8f7),
        //     borderRadius: BorderRadius.circular(12),
        //   ),
        //   child: Padding(
        //     padding: const EdgeInsets.all(12.0),
        //     child: Column(
        //       children: [
        //         Text(AppStrings.WRITE_HERE_YOUR_FIRST,
        //             style: TextStyle(
        //                 color: theme.colorScheme.primaryContainer,
        //                 fontFamily: BaseConstant.poppinsLight,
        //                 fontSize: 14)),
        //         const SizedBox(
        //           height: 10,
        //         ),
        //         Text(AppStrings.HOW_TO_ANNOUNCE_TO_THE_WORLD,
        //             style: TextStyle(
        //                 color: theme.colorScheme.primaryContainer,
        //                 fontFamily: BaseConstant.poppinsLight,
        //                 fontSize: 14)),
        //       ],
        //     ),
        //   ),
        // ),

        const SizedBox(
          height: 40,
        ),
        const Text(AppStrings.DONT_WORRY,
            style: TextStyle(
                color: Color(0xffD5D1CD),
                fontFamily: BaseConstant.poppinsRegular,
                fontSize: 12)),
        const Text(AppStrings.ANNOUNCE_DESCRIPTION,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Color(0xffD5D1CD),
                fontFamily: BaseConstant.poppinsRegular,
                fontSize: 12)),
        const Spacer(),
        SizedBox(
            height: 40,
            width: MediaQuery.of(context).size.width,
            child: AppButton(
                textColor: Colors.white,
                fontSize: 16,
                color: colorScheme.onPrimaryContainer,
                borderRadius: 8,
                text: AppStrings.ANNOUNCE,
                onClick: () {
                  context.unfocus();
                  Navigator.pushNamedAndRemoveUntil(
                      context, MainScreen.route, (route) => false);
                  // bloc.updatePagerIndex(1);
                })),
      ],
    );
  }
}
