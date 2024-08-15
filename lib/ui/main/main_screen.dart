import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sera/backend/server_response.dart';
import 'package:sera/backend/shared_web_service.dart';
import 'package:sera/data/meta_data.dart';
import 'package:sera/extensions/context_extension.dart';
import 'package:sera/ui/Liked_products/liked_products.dart';
import 'package:sera/ui/auth/login/login_screen.dart';
import 'package:sera/ui/cart/cart_screen.dart';
import 'package:sera/ui/notifications/notification_screen.dart';
import 'package:sera/ui/profile/profile_screen.dart';
import 'package:sera/util/app_strings.dart';
import 'package:sera/util/base_constants.dart';
import '../../helper/bottom_sheet_helper.dart';
import 'main_bloc.dart';
import 'main_state.dart';

class MainScreen extends StatefulWidget {
  static const String route = 'main_screen_route';

  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  BottomSheetHelper get _bottomSheetHelper => BottomSheetHelper.instance();
  @override
  void initState() {
    super.initState();
  }

  final customerIconList = <String>[
    'assets/3x/filter.png',
    'assets/3x/search.png',
    'assets/3x/like.png',
    'assets/3x/profile.png',
  ];

  final vendurIconList = <String>[
    'assets/3x/filter.png',
    'assets/3x/search.png',
    'assets/3x/analysis.png',
    'assets/3x/profile.png',
  ];

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<MainScreenBloc>();
    final theme = context.theme;
    final size = context.mediaSize;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light.copyWith(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness:
              context.isDarkTheme ? Brightness.light : Brightness.dark,
          statusBarBrightness:
              context.isDarkTheme ? Brightness.dark : Brightness.light),
      child: Scaffold(
          drawerEnableOpenDragGesture: false,
          backgroundColor: const Color(0xffffffff),
          resizeToAvoidBottomInset: false,
          key: bloc.scaffoldKey,
          appBar: MainScreenAppBar(trailingButton:
              BlocBuilder<MainScreenBloc, MainScreenState>(
                  builder: (context, state) {
            return state.usertype == "Vendor" || state.usertype == "vendor"
                ? const SizedBox()
                : GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, CartScreen.route);
                    },
                    child: Image.asset('assets/3x/cart.png'));
          })),
          floatingActionButton: BlocBuilder<MainScreenBloc, MainScreenState>(
              builder: (context, state) {
            return FloatingActionButton(
              backgroundColor: theme.colorScheme.onPrimary,
              shape: RoundedRectangleBorder(
                borderRadius: const BorderRadius.all(Radius.circular(100)),
                side: state.index == 4
                    ? BorderSide(color: theme.colorScheme.secondary)
                    : BorderSide.none,
              ),
              onPressed: () {
                bloc.handleOnSliderPageChange(4);
              },
              child: Image.asset(
                'assets/3x/home.png',
                color: theme.colorScheme.primary,
              ),
            );
          }),

          ///////////////////////// DRAWER   /////////////////////

          drawer: BlocBuilder<MainScreenBloc, MainScreenState>(
              builder: (context, state) {
            return Drawer(
                backgroundColor: Colors.white,
                elevation: 16.0,
                width: size.width / 1.3,
                child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 4.0, vertical: 15),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 40),
                          Column(
                            children: [
                              Row(
                                children: [
                                  PhysicalModel(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                    child: Padding(
                                      padding: EdgeInsets.all(4.0),
                                      child: BlocBuilder<MainScreenBloc,
                                              MainScreenState>(
                                          builder: (context, state) {
                                        final data = state.currentUserData;
                                        if (data is Data) {
                                          final userdata =
                                              data.data as UserDataModel;

                                          return userdata
                                                      .appUserBrand!.logoUrl !=
                                                  null
                                              ? CircleAvatar(
                                                  radius: 35,
                                                  backgroundColor: Colors.grey,
                                                  backgroundImage: NetworkImage(
                                                      "$pictureUrl${userdata.appUserBrand!.logoUrl}"),
                                                )
                                              : const CircleAvatar(
                                                  radius: 35,
                                                  backgroundColor: Colors.grey,
                                                  backgroundImage: AssetImage(
                                                      "assets/3x/dummy_user.png"),
                                                );
                                        } else {
                                          return const CircleAvatar(
                                            radius: 35,
                                            backgroundColor: Colors.grey,
                                            backgroundImage: AssetImage(
                                                "assets/3x/dummy_user.png"),
                                          );
                                        }
                                      }),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      BlocBuilder<MainScreenBloc,
                                              MainScreenState>(
                                          builder: (context, state) {
                                        final data = state.currentUserData;
                                        if (data is Data) {
                                          final userdata =
                                              data.data as UserDataModel;
                                          return Text(
                                              "${userdata.appUserBrand!.brandName}",
                                              style: theme
                                                  .textTheme.titleMedium!
                                                  .copyWith(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w500));
                                        } else {
                                          return Text("",
                                              style: theme
                                                  .textTheme.titleMedium!
                                                  .copyWith(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w500));
                                        }
                                      }),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      BlocBuilder<MainScreenBloc,
                                              MainScreenState>(
                                          builder: (context, state) {
                                        final data = state.currentUserData;
                                        if (data is Data) {
                                          final userdata =
                                              data.data as UserDataModel;
                                          return Text(
                                              "${userdata.appUserBrand!.bio} - ${userdata.appUserBrand!.slogan}",
                                              style: theme
                                                  .textTheme.titleMedium!
                                                  .copyWith(
                                                      fontSize: 14,
                                                      color: theme.colorScheme
                                                          .onPrimaryContainer,
                                                      fontWeight:
                                                          FontWeight.w400));
                                        } else {
                                          return Text("",
                                              style: theme
                                                  .textTheme.titleMedium!
                                                  .copyWith(
                                                      fontSize: 14,
                                                      color: theme.colorScheme
                                                          .onPrimaryContainer,
                                                      fontWeight:
                                                          FontWeight.w400));
                                        }
                                      }),
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 10),
                            child: Divider(
                                color: theme.colorScheme.secondary,
                                thickness: 1),
                          ),
                          ListTile(
                            title: Text(
                              AppStrings.NOTIFICATION,
                              style: theme.textTheme.titleMedium,
                            ),
                            onTap: () {
                              Navigator.pushNamed(
                                  context, NotificationScreen.route);
                            },
                          ),
                          ListTile(
                            title: Text(
                              AppStrings.MY_PERSONAL_POFILE,
                              style: theme.textTheme.titleMedium,
                            ),
                            onTap: () {
                              Navigator.pushNamed(
                                  context, PersonalProfileScreen.route);
                            },
                          ),
                          ListTile(
                            title: Text(
                              AppStrings.LIKED_PRODUCTS,
                              style: theme.textTheme.titleMedium,
                            ),
                            onTap: () {
                              Navigator.pushNamed(context, LikedProducts.route);
                            },
                          ),
                          const Spacer(),
                          ListTile(
                            onTap: () {},
                            title: Text(
                              AppStrings.DELETE_ACCOUNT.toUpperCase(),
                              style: theme.textTheme.titleLarge!.copyWith(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xffB30A0A)),
                            ),
                          ),
                          ListTile(
                            onTap: () {
                              bloc.close();
                              Navigator.pushNamedAndRemoveUntil(
                                  context, LoginScreen.route, (route) => false);
                            },
                            title: Text(
                              'Logout',
                              style: theme.textTheme.titleMedium!
                                  .copyWith(fontSize: 18),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ])));
          }),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: BlocBuilder<MainScreenBloc, MainScreenState>(
            buildWhen: (previous, current) => previous.index != current.index,
            builder: (_, state) => AnimatedBottomNavigationBar.builder(
              itemCount: customerIconList.length,
              tabBuilder: (int index, bool isActive) {
                final color = isActive
                    ? theme.colorScheme.secondary
                    : BaseConstant.bottombarUnSelectedColor;
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (state.usertype == "Customer") ...[
                      Image.asset(
                        customerIconList[index],
                        color: color,
                        height: 30,
                        width: 30,
                      )
                    ],
                    if (state.usertype == "Vendor" ||
                        state.usertype == "vendor") ...[
                      Image.asset(
                        vendurIconList[index],
                        color: color,
                        height: 30,
                        width: 30,
                      )
                    ],
                  ],
                );
              },
              // backgroundColor: theme.colorScheme.onPrimary,
              activeIndex: state.index,
              // splashColor: theme.colorScheme.primary,
              splashSpeedInMilliseconds: 300,
              gapLocation: GapLocation.center,
              notchSmoothness: NotchSmoothness.verySmoothEdge,
              leftCornerRadius: 0,
              rightCornerRadius: 0,
              splashRadius: 0,
              onTap: (int newIndex) {
                _bottomSheetHelper.hideSheet();
                if (state.index == newIndex) return;
                bloc.handleOnSliderPageChange(newIndex);
              },
            ),
          ),
          body: BlocBuilder<MainScreenBloc, MainScreenState>(
              buildWhen: (previous, current) => previous.index != current.index,
              builder: (_, state) =>
                  IndexedStack(index: state.index, children: bloc.bottomMap.values.toList()))),
    );
  }
}

class MainScreenAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget trailingButton;

  const MainScreenAppBar({super.key, required this.trailingButton});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return BlocBuilder<MainScreenBloc, MainScreenState>(
        buildWhen: (previous, current) => previous.index != current.index,
        builder: (_, state) => state.index == 3
            ? const SizedBox()
            : state.index == 2 &&
                    (state.usertype == "Vendor" || state.usertype == "vendor")
                ? const SizedBox()
                : AppBar(
                    scrolledUnderElevation: 0.0,
                    automaticallyImplyLeading: false,
                    elevation: 0,
                    title: Text(
                        state.index == 0
                            ? 'SERA'
                            : state.index == 1
                                ? 'SERA'
                                : state.index == 2
                                    ? 'SERA'
                                    : state.index == 3
                                        ? ''
                                        : 'SERA',
                        style: textTheme.titleLarge!.copyWith(
                            color: colorScheme.secondary,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            fontFamily: BaseConstant.poppinsSemibold)),
                    centerTitle: true,
                    bottom: PreferredSize(
                        preferredSize: const Size.fromHeight(4.0),
                        child: Container(
                          color: theme.colorScheme.secondary,
                          height: 0.2,
                        )),
                    actions: [
                      Padding(
                          padding: const EdgeInsets.only(right: 12.0),
                          child: trailingButton)
                    ],
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(10),
                            bottomLeft: Radius.circular(10))),
                    backgroundColor: colorScheme.onPrimary));
  }

  @override
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
