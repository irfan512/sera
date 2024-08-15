import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sera/backend/server_response.dart';
import 'package:sera/backend/shared_web_service.dart';
import 'package:sera/data/meta_data.dart';
import 'package:sera/extensions/context_extension.dart';
import 'package:sera/ui/addressess/addressess_screen.dart';
import 'package:sera/ui/contact_us/contact_us.dart';
import 'package:sera/ui/edit_profile/edit_profile_screen.dart';
import 'package:sera/ui/notifications/notification_screen.dart';
import 'package:sera/ui/orders/orders_screen.dart';
import 'package:sera/ui/profile/profile_screen_bloc.dart';
import 'package:sera/ui/profile/profile_screen_state.dart';
import 'package:sera/util/app_strings.dart';
import 'package:sera/util/base_constants.dart';

class PersonalProfileScreen extends StatelessWidget {
  static const String route = '/my_profile_screen';

  const PersonalProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final bloc = context.read<ProfileScreenBloc>();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
          child: SafeArea(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
            SizedBox(
                height: 170,
                width: MediaQuery.sizeOf(context).width,
                child: Stack(children: [
                  Container(
                      height: 130,
                      width: MediaQuery.sizeOf(context).width,
                      decoration: const BoxDecoration(
                          color: BaseConstant.profileScreenBg,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(20.0),
                              bottomRight: Radius.circular(20.0)))),
                  Positioned(
                    top: 20,
                    left: 20,
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: theme.colorScheme.secondary,
                        size: 20,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: BlocBuilder<ProfileScreenBloc, ProfileScreenState>(
                          builder: (context, state) {
                        final data = state.currentUserData;
                        if (data is Data) {
                          final userdata = data.data as UserDataModel;
                          return userdata.profileImage != null
                              ? Container(
                                  height: 120,
                                  width: 120,
                                  decoration: BoxDecoration(
                                    color: theme.colorScheme.primary,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        color: theme.colorScheme.onPrimary,
                                        width: 3),
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            "$pictureUrl${userdata.profileImage}"),
                                        fit: BoxFit.cover),
                                  ))
                              : Container(
                                  height: 120,
                                  width: 120,
                                  decoration: BoxDecoration(
                                    color: theme.colorScheme.primary,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        color: theme.colorScheme.onPrimary,
                                        width: 3),
                                    image: const DecorationImage(
                                        image: AssetImage(
                                            'assets/3x/profile_picture.png'),
                                        fit: BoxFit.cover),
                                  ));
                        } else {
                          return Container(
                              height: 120,
                              width: 120,
                              decoration: BoxDecoration(
                                color: theme.colorScheme.primary,
                                shape: BoxShape.circle,
                                border: Border.all(
                                    color: theme.colorScheme.onPrimary,
                                    width: 3),
                                image: const DecorationImage(
                                    image: AssetImage(
                                        'assets/3x/profile_picture.png'),
                                    fit: BoxFit.cover),
                              ));
                        }
                      }),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 12.0, bottom: 8.0),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, EditProfile.route)
                              .then((value) {
                            bloc.getUserFromSharedPref();
                          });
                        },
                        child: Image.asset(
                          'assets/3x/edit_profile.png',
                          height: 30,
                          width: 30,
                        ),
                      ),
                    ),
                  )
                ])),
            const SizedBox(height: 10),
            BlocBuilder<ProfileScreenBloc, ProfileScreenState>(
                builder: (context, state) {
              final data = state.currentUserData;
              if (data is Data) {
                final userdata = data.data as UserDataModel;
                return Text("${userdata.firstName} ${userdata.lastName}",
                    style: theme.textTheme.titleMedium!.copyWith(
                        fontSize: 12,
                        color: theme.colorScheme.onPrimaryContainer,
                        fontWeight: FontWeight.w400));
              } else {
                return Text("",
                    style: theme.textTheme.titleLarge!
                        .copyWith(fontSize: 18, fontWeight: FontWeight.w500));
              }
            }),
            const SizedBox(height: 5),
            BlocBuilder<ProfileScreenBloc, ProfileScreenState>(
                builder: (context, state) {
              final data = state.currentUserData;
              if (data is Data) {
                final userdata = data.data as UserDataModel;
                return Text(userdata.email.toString(),
                    style: theme.textTheme.titleMedium!.copyWith(
                        fontSize: 12,
                        color: theme.colorScheme.onPrimaryContainer,
                        fontWeight: FontWeight.w400));
              } else {
                return Text("",
                    style: theme.textTheme.titleLarge!
                        .copyWith(fontSize: 18, fontWeight: FontWeight.w500));
              }
            }),
            const SizedBox(height: 20),
            Padding(
                padding: const EdgeInsets.all(12.0),
                child: Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 10,
                    children: [
                      ProfileOption(
                        image: "assets/3x/orders.png",
                        label: AppStrings.ORDERS,
                        onTap: () {
                          Navigator.pushNamed(context, OrderScreen.route);
                        },
                      ),
                      ProfileOption(
                        image: "assets/3x/notifications.png",
                        label: AppStrings.NOTIFICATIONS,
                        height: 23,
                        width: 23,
                        onTap: () {
                          Navigator.pushNamed(
                              context, NotificationScreen.route);
                        },
                      ),
                      ProfileOption(
                        image: "assets/3x/addressess.png",
                        label: AppStrings.ADDRESSESS,
                        onTap: () {
                          Navigator.pushNamed(context, AddressScreen.route);
                        },
                      ),
                      ProfileOption(
                        image: "assets/3x/currency.png",
                        label: AppStrings.CURRENCY,
                        onTap: () {},
                        height: 18,
                        width: 18,
                      ),
                      ProfileOption(
                        image: "assets/3x/privacy_policy.png",
                        label: AppStrings.PRIVACY_POLICY,
                        height: 18,
                        width: 18,
                        onTap: () {},
                      ),
                      ProfileOption(
                        image: "assets/3x/contact_us.png",
                        label: AppStrings.CONTACT_US,
                        height: 18,
                        width: 16,
                        onTap: () {
                          Navigator.pushNamed(context, ContactUs.route);
                        },
                      ),
                    ]))
          ]))),
    );
  }
}

class ProfileOption extends StatelessWidget {
  final String image;
  final String label;
  final VoidCallback onTap;
  final double height;
  final double width;

  const ProfileOption({
    super.key,
    required this.image,
    required this.label,
    required this.onTap,
    this.height = 16,
    this.width = 16,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final size = context.mediaSize;
    return GestureDetector(
        onTap: onTap,
        child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Container(
                width: size.width * .27,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        height: height,
                        width: width,
                        image,
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(height: 10),
                      Text(label,
                          style: theme.textTheme.titleMedium!.copyWith(
                            color: theme.colorScheme.secondary,
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                          ))
                    ]))));
  }
}
