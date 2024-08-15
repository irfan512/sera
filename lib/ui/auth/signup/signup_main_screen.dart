import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sera/extensions/context_extension.dart';
import 'package:sera/ui/auth/signup/signup_navs/signup_finished_nav.dart';
import 'package:sera/ui/auth/signup/signup_navs/signup_mid_nav.dart';
import 'package:sera/ui/auth/signup/signup_navs/signup_start_nav.dart';
import 'package:sera/ui/auth/signup/signup_screen_bloc.dart';
import 'package:sera/ui/auth/signup/signup_screen_state.dart';
import 'package:sera/ui/main/main_screen.dart';
import 'package:sera/util/app_strings.dart';

class SignupMainScreen extends StatefulWidget {
  static const String route = '/signup_main_screen_route';
  final String usertype;
  const SignupMainScreen({super.key, required this.usertype});

  @override
  State<SignupMainScreen> createState() => _SignupMainScreenState();
}

class _SignupMainScreenState extends State<SignupMainScreen> {
  final pageSliderIndexedMap = <PageStorageKey<String>, Widget>{};
  static const _signupStartScreenNavigationKey =
      PageStorageKey(SignupStartNav.key_title);
  static const _signupMidScreenNavigationKey =
      PageStorageKey(SignupMidNav.key_title);
  static const _signupFinishedScreenNavigationKey =
      PageStorageKey(SignupFinishedNav.key_title);

  @override
  void initState() {
    pageSliderIndexedMap[_signupStartScreenNavigationKey] =
        SignupStartNav(key: _signupStartScreenNavigationKey);
    pageSliderIndexedMap[_signupMidScreenNavigationKey] =
        const SignupMidNav(key: _signupMidScreenNavigationKey);
    pageSliderIndexedMap[_signupFinishedScreenNavigationKey] =
        const SignupFinishedNav(key: _signupFinishedScreenNavigationKey);
    context
        .read<SignupScreenBloc>()
        .toogleCustomerSelect(widget.usertype == "Customer" ? true : false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final bloc = context.read<SignupScreenBloc>();
    return Scaffold(
      backgroundColor: theme.colorScheme.onPrimary,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
          automaticallyImplyLeading: false,
          scrolledUnderElevation: 0.0,
          backgroundColor: const Color.fromRGBO(0, 0, 0, 0),
          elevation: 0,
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
          actions: widget.usertype == "Customer"
              ? [
                  Padding(
                    padding: const EdgeInsets.only(right: 18.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, MainScreen.route);
                      },
                      child: Text(
                        AppStrings.SKIP,
                        style: theme.textTheme.titleMedium!.copyWith(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: theme.colorScheme.primaryContainer),
                      ),
                    ),
                  )
                ]
              : null),
      body: Stack(children: [
        Positioned(
          top: -65,
          left: -100,
          child: Container(
            height: 180,
            width: 180,
            decoration: BoxDecoration(
              color: theme.colorScheme.primary.withOpacity(0.3),
              shape: BoxShape.circle,
            ),
          ),
        ),
        PageView.builder(
            controller: bloc.pageSliderController,
            physics: const NeverScrollableScrollPhysics(),
            onPageChanged: (int? index) {
              if (index == null) return;
              final pageStorageKey = pageSliderIndexedMap.keys.elementAt(index);
              final pagerItem = pageSliderIndexedMap[pageStorageKey];
              if (pagerItem == null || pagerItem is SizedBox) {
                final newPagerWidget = _getNavigationWidget(index);
                pageSliderIndexedMap[pageStorageKey] = newPagerWidget;
              }
              bloc.updatePagerIndex(index);
            },
            itemBuilder: (_, index) {
              return BlocBuilder<SignupScreenBloc, SignupScreenState>(
                  buildWhen: (previous, current) =>
                      previous.pagerIndex != current.pagerIndex,
                  builder: (_, state) {
                    state.pagerIndex;
                    return IndexedStack(
                        index: index,
                        children: pageSliderIndexedMap.values.toList());
                  });
            },
            scrollDirection: Axis.horizontal,
            itemCount: 3),
      ]),
    );
  }

  Widget _getNavigationWidget(int index) {
    switch (index) {
      case 0:
        return SignupStartNav(key: _signupStartScreenNavigationKey);
      case 1:
        return const SignupMidNav(key: _signupMidScreenNavigationKey);
      case 2:
        return const SignupFinishedNav(key: _signupFinishedScreenNavigationKey);
      default:
        return const SizedBox();
    }
  }
}
