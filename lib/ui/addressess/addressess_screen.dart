import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sera/backend/server_response.dart';
import 'package:sera/data/meta_data.dart';
import 'package:sera/extensions/context_extension.dart';
import 'package:sera/ui/addressess/addressess_bloc.dart';
import 'package:sera/ui/addressess/addressess_state.dart';
import 'package:sera/ui/auth/add_address/add_address_screen.dart';
import 'package:sera/ui/common/app_bar.dart';
import 'package:sera/util/app_strings.dart';
import 'package:sera/util/base_constants.dart';

class AddressScreen extends StatefulWidget {
  static const String route = "_address_screen";
  const AddressScreen({super.key});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<AddressessBloc>().getAllAddress();
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Scaffold(
      appBar: CustomAppBar(
        isbottom: true,
        elevation: 0.0,
        backgroundColor: theme.colorScheme.onPrimary,
        iscenterTitle: true,
        title: Text(
          AppStrings.ADDRESSESS,
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(
            context,
            AddAddress.route,
            arguments: false,
          );
        },
        backgroundColor: theme.colorScheme.secondary,
        elevation: 4,
        child: Icon(
          Icons.add,
          color: theme.colorScheme.onPrimary,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            children: [
              BlocBuilder<AddressessBloc, AddressessState>(
                  builder: (context, state) {
                final data = state.addressessData;
                if (data is Data) {
                  final addressList = data.data as List<AddressModel>;
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: addressList.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Material(
                            elevation: 2,
                            borderRadius: BorderRadius.circular(8),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: theme.colorScheme.onPrimary,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                      color: theme.colorScheme.onPrimaryContainer,
                                      width: 0.4)),
                              child: Stack(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            addressList[index].addressType ==
                                                    "Home"
                                                ? Container(
                                                    decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color: theme
                                                            .colorScheme.primary),
                                                    child: Image.asset(
                                                        "assets/3x/house.png",
                                                        height: 30,
                                                        width: 30,
                                                        color: theme.colorScheme
                                                            .secondary),
                                                  )
                                                : Container(
                                                    decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color: theme
                                                            .colorScheme.primary),
                                                    child: Image.asset(
                                                        "assets/3x/Flat.png",
                                                        height: 30,
                                                        width: 30,
                                                        color: theme.colorScheme
                                                            .secondary),
                                                  ),
                                            const SizedBox(
                                              width: 6,
                                            ),
                                            addressList[index].addressType ==
                                                    "Home"
                                                ? Text(AppStrings.HOME,
                                                    style: theme
                                                        .textTheme.titleMedium!
                                                        .copyWith(
                                                            color: theme
                                                                .colorScheme
                                                                .secondary))
                                                : Text(AppStrings.Flat,
                                                    style: theme
                                                        .textTheme.titleMedium!
                                                        .copyWith(
                                                            color: theme
                                                                .colorScheme
                                                                .secondary)),
                                            const Spacer(),
                                            GestureDetector(
                                              onTap: () {
                                                Navigator.pushNamed(
                                                    context, AddAddress.route,
                                                    arguments: true);
                                              },
                                              child: Image.asset(
                                                  "assets/3x/edit_profile.png",
                                                  height: 20,
                                                  width: 20,
                                                  color: theme
                                                      .colorScheme.secondary),
                                            ),
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
                                              "${addressList[index].appUser!.firstName} ${addressList[index].appUser!.lastName}",
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
                                              addressList[index]
                                                  .appUser!
                                                  .phoneNumber
                                                  .toString(),
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "${addressList[index].country} ${addressList[index].state} ${addressList[index].city}",
                                                  style: theme
                                                      .textTheme.titleMedium!
                                                      .copyWith(
                                                          color: BaseConstant
                                                              .selectedUserdataColor,
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                ),
                                                Text(
                                                  "${addressList[index].address1} ${addressList[index].address2} ${addressList[index].houseNumber}",
                                                  style: theme
                                                      .textTheme.titleMedium!
                                                      .copyWith(
                                                          color: BaseConstant
                                                              .selectedUserdataColor,
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                )
                                              ]
                                            )
                                          ]
                                        )
                                      ]
                                    )
                                  ),
                                  Positioned(
                                    bottom: 0,
                                    right: 0,
                                    child: Transform.rotate(
                                      angle: -0.785398,
                                      //  45 degrees in radians ,
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 4, horizontal: 16),
                                        color: Colors.black,
                                        child: const Text(
                                          'Default',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      });
                } else {
                  return const SizedBox();
                }
              }),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CornerBannerPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(size.width - 80, size.height - 70)
      ..lineTo(size.width - 80, size.height)
      ..lineTo(size.width, size.height - 80)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
