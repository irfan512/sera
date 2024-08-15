import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sera/extensions/context_extension.dart';
import 'package:sera/ui/main/main_bloc.dart';
import 'package:sera/ui/main/main_state.dart';
import 'package:sera/ui/messages/nessage_list.dart';
import 'package:sera/util/app_strings.dart';
import 'package:sera/util/base_constants.dart';

class AnalysisScreen extends StatelessWidget {
  static const String key_title = "_analysis_screen";
  const AnalysisScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final size = context.mediaSize;
    final bloc = context.read<MainScreenBloc>();
    return SafeArea(
      child: Stack(
        children: [
          Positioned(
            top: -110,
            right: -65,
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, UserMessagesScreen.route);
              },
              child: Container(
                height: 300,
                width: 250,
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary.withOpacity(0.3),
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, UserMessagesScreen.route);
            },
            child: const Padding(
              padding: EdgeInsets.only(top: 60.0, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [Image(image: AssetImage("assets/3x/messages.png"))],
              ),
            ),
          ),
          Column(
            children: [
              const SizedBox(height: 120),
              SizedBox(
                height: 35,
                width: size.width,
                child: Center(
                  child: ListView.builder(
                    itemCount: bloc.analysisScreen.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    physics: const ScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: BlocBuilder<MainScreenBloc, MainScreenState>(
                          builder: (context, state) {
                            return GestureDetector(
                              onTap: () {
                                bloc.updateVendorAnalysisIndex(index);
                              },
                              child: Material(
                                elevation: 0.3,
                                borderRadius: BorderRadius.circular(12),
                                color: state.vendorAnalysisScreen == index
                                    ? theme.colorScheme.secondary
                                    : theme.colorScheme.onPrimary,
                                child: Container(
                                  width: size.width * .45,
                                  decoration: BoxDecoration(
                                      color: state.vendorAnalysisScreen == index
                                          ? theme.colorScheme.secondary
                                          : theme.colorScheme.onPrimary,
                                      border: Border.all(
                                        color:
                                            state.vendorAnalysisScreen == index
                                                ? theme.colorScheme.secondary
                                                : theme.colorScheme
                                                    .primaryContainer,
                                        width: 0.3,
                                      ),
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12.0),
                                      child: Text(
                                        bloc.analysisScreen[index],
                                        style: theme.textTheme.titleMedium!
                                            .copyWith(
                                          color: state.vendorAnalysisScreen ==
                                                  index
                                              ? theme.colorScheme.onPrimary
                                              : theme.colorScheme
                                                  .secondaryContainer,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              BlocBuilder<MainScreenBloc, MainScreenState>(
                  builder: (context, state) {
                return state.vendorAnalysisScreen == 0
                    ? SizedBox(
                        height: 40,
                        width: size.width,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: ListView.builder(
                            itemCount: bloc.orderDataList.length,
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            physics: const ScrollPhysics(),
                            itemBuilder: (context, index) {
                              return BlocBuilder<MainScreenBloc,
                                  MainScreenState>(
                                builder: (context, state) {
                                  return GestureDetector(
                                    onTap: () {
                                      bloc.updateVendorOrderIndex(index);
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border(
                                          bottom: BorderSide(
                                            color: state.vendorOrderIndex ==
                                                    index
                                                ? theme.colorScheme.secondary
                                                : theme.colorScheme
                                                    .primaryContainer,
                                            width:
                                                state.vendorOrderIndex == index
                                                    ? 2.0
                                                    : 1.0,
                                          ),
                                        ),
                                      ),
                                      child: Center(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 12.0),
                                          child: Text(
                                            bloc.orderDataList[index],
                                            style: theme.textTheme.titleLarge!
                                                .copyWith(
                                              color: state.vendorOrderIndex ==
                                                      index
                                                  ? theme.colorScheme.secondary
                                                  : theme.colorScheme
                                                      .primaryContainer,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      )
                    : SizedBox(
                        height: 40,
                        width: size.width,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: ListView.builder(
                            itemCount: bloc.saleDataList.length,
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            physics: const ScrollPhysics(),
                            itemBuilder: (context, index) {
                              return BlocBuilder<MainScreenBloc,
                                  MainScreenState>(
                                builder: (context, state) {
                                  return GestureDetector(
                                    onTap: () {
                                      bloc.updateVendorSalesIndex(index);
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border(
                                          bottom: BorderSide(
                                            color: state.vendorSalesIndex ==
                                                    index
                                                ? theme.colorScheme.secondary
                                                : theme.colorScheme
                                                    .primaryContainer,
                                            width:
                                                state.vendorSalesIndex == index
                                                    ? 2.0
                                                    : 1.0,
                                          ),
                                        ),
                                      ),
                                      child: Center(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 12.0),
                                          child: Text(
                                            bloc.saleDataList[index],
                                            style: theme.textTheme.titleLarge!
                                                .copyWith(
                                              color: state.vendorSalesIndex ==
                                                      index
                                                  ? theme.colorScheme.secondary
                                                  : theme.colorScheme
                                                      .primaryContainer,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      );
              }),
              Expanded(
                child: BlocBuilder<MainScreenBloc, MainScreenState>(
                  builder: (context, state) {
                    return state.vendorAnalysisScreen == 1
                        ? SalesScreen()
                        : state.vendorOrderIndex == 0
                            ? const PendingOrder()
                            : state.vendorOrderIndex == 1
                                ? const PreparingOrder()
                                : state.vendorOrderIndex == 2
                                    ? const ReadyForPickup()
                                    : state.vendorOrderIndex == 3
                                        ? const OutOfDelivery()
                                        : const Delivered();
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class PendingOrder extends StatelessWidget {
  const PendingOrder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final orders = [
      {
        'id': '#EYUD-6792',
        'name': 'Jacob Jones',
        'time': 'Friday 13:32',
        'amount': '30.00 KD'
      },
      {
        'id': '#EYUD-6792',
        'name': 'Jacob Jones',
        'time': 'Friday 13:32',
        'amount': '30.00 KD'
      },
    ];
    final theme = context.theme;
    final bloc = context.read<MainScreenBloc>();

    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: orders.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        final order = orders[index];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 3.0),
          child: Material(
            color: theme.colorScheme.onPrimary,
            elevation: 2,
            child: ListTile(
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      order['name']!,
                      style: theme.textTheme.titleMedium!.copyWith(
                        color: theme.colorScheme.secondary,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      order['amount']!,
                      style: theme.textTheme.titleMedium!.copyWith(
                        color: theme.colorScheme.secondary,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    order['id']!,
                    style: theme.textTheme.titleMedium!.copyWith(
                      color: theme.colorScheme.primaryContainer,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    "|",
                    style: theme.textTheme.titleMedium!.copyWith(
                      color: theme.colorScheme.primaryContainer,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    order['time']!,
                    style: theme.textTheme.titleMedium!.copyWith(
                      color: theme.colorScheme.primaryContainer,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Spacer(),

//.....................popup button ..................//

                  BlocBuilder<MainScreenBloc, MainScreenState>(
                    builder: (context, state) {
                      return PopupMenuButton<int>(
                          color: Colors.white,
                          shadowColor: Colors.transparent,
                          offset: const Offset(0, 40),
                          elevation: 0,
                          tooltip: '',
                          splashRadius: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          constraints: const BoxConstraints(minWidth: 120),
                          position: PopupMenuPosition.over,
                          itemBuilder: (context) {
                            return bloc.orderStatusList.entries
                                .map((MapEntry<int, String> entry) {
                              return PopupMenuItem<int>(
                                value: entry.key,
                                child: Text(
                                  entry.value,
                                  style: theme.textTheme.titleMedium!.copyWith(
                                    fontSize: 15,
                                    color: theme.colorScheme.secondary,
                                  ),
                                ),
                              );
                            }).toList();
                          },
                          onSelected: (selectedUserType) {
                            bloc.orderStatusController.text =
                                bloc.orderStatusList[selectedUserType] ??
                                    'None';
                            bloc.updateOrderSelectedIndex(index);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: BaseConstant.orderStatus1Color),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 3.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    bloc.orderStatusList[0].toString(),
                                    style: theme.textTheme.titleMedium!
                                        .copyWith(
                                            color: theme.colorScheme.secondary,
                                            fontSize: 10,
                                            fontWeight: FontWeight.w500),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Icon(
                                    Icons.keyboard_arrow_down_rounded,
                                    color: theme.colorScheme.secondary
                                        .withOpacity(0.8),
                                    size: 22,
                                  )
                                ],
                              ),
                            ),
                          ));
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class PreparingOrder extends StatelessWidget {
  const PreparingOrder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // Sample data
    final orders = [
      {
        'id': '#EYUD-6792',
        'name': 'Jacob Jones',
        'time': 'Friday 13:32',
        'amount': '30.00 KD'
      },
      {
        'id': '#EYUD-6792',
        'name': 'Jacob Jones',
        'time': 'Friday 13:32',
        'amount': '30.00 KD'
      },
      {
        'id': '#EYUD-6792',
        'name': 'Jacob Jones',
        'time': 'Friday 13:32',
        'amount': '30.00 KD'
      },
    ];
    final theme = context.theme;
    final bloc = context.read<MainScreenBloc>();

    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: orders.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        final order = orders[index];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 3.0),
          child: Material(
            color: theme.colorScheme.onPrimary,
            elevation: 2,
            child: ListTile(
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      order['name']!,
                      style: theme.textTheme.titleMedium!.copyWith(
                        color: theme.colorScheme.secondary,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      order['amount']!,
                      style: theme.textTheme.titleMedium!.copyWith(
                        color: theme.colorScheme.secondary,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    order['id']!,
                    style: theme.textTheme.titleMedium!.copyWith(
                      color: theme.colorScheme.primaryContainer,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    "|",
                    style: theme.textTheme.titleMedium!.copyWith(
                      color: theme.colorScheme.primaryContainer,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    order['time']!,
                    style: theme.textTheme.titleMedium!.copyWith(
                      color: theme.colorScheme.primaryContainer,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Spacer(),
                  BlocBuilder<MainScreenBloc, MainScreenState>(
                    builder: (context, state) {
                      return PopupMenuButton<int>(
                          color: Colors.white,
                          shadowColor: Colors.transparent,
                          offset: const Offset(0, 40),
                          elevation: 0,
                          tooltip: '',
                          splashRadius: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          constraints: const BoxConstraints(minWidth: 120),
                          position: PopupMenuPosition.over,
                          itemBuilder: (context) {
                            return bloc.orderStatusList.entries
                                .map((MapEntry<int, String> entry) {
                              return PopupMenuItem<int>(
                                value: entry.key,
                                child: Text(
                                  entry.value,
                                  style: theme.textTheme.titleSmall!.copyWith(
                                    fontSize: 15,
                                    color: theme.colorScheme.secondary,
                                  ),
                                ),
                              );
                            }).toList();
                          },
                          onSelected: (selectedUserType) {
                            bloc.orderStatusController.text =
                                bloc.orderStatusList[selectedUserType] ??
                                    'None';
                            bloc.updateOrderSelectedIndex(index);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: BaseConstant.orderStatus2Color),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 3.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    bloc.orderStatusList[1].toString(),
                                    style: theme.textTheme.titleMedium!
                                        .copyWith(
                                            color: theme.colorScheme.secondary,
                                            fontSize: 10,
                                            fontWeight: FontWeight.w500),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Icon(
                                    Icons.keyboard_arrow_down_rounded,
                                    color: theme.colorScheme.secondary
                                        .withOpacity(0.8),
                                    size: 22,
                                  )
                                ],
                              ),
                            ),
                          ));
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class ReadyForPickup extends StatelessWidget {
  const ReadyForPickup({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // Sample data
    final orders = [
      {
        'id': '#EYUD-6792',
        'name': 'Jacob Jones',
        'time': 'Friday 13:32',
        'amount': '30.00 KD'
      },
      {
        'id': '#EYUD-6792',
        'name': 'Jacob Jones',
        'time': 'Friday 13:32',
        'amount': '30.00 KD'
      },
      {
        'id': '#EYUD-6792',
        'name': 'Jacob Jones',
        'time': 'Friday 13:32',
        'amount': '30.00 KD'
      },
      {
        'id': '#EYUD-6792',
        'name': 'Jacob Jones',
        'time': 'Friday 13:32',
        'amount': '30.00 KD'
      },
      {
        'id': '#EYUD-6792',
        'name': 'Jacob Jones',
        'time': 'Friday 13:32',
        'amount': '30.00 KD'
      },
      {
        'id': '#EYUD-6792',
        'name': 'Jacob Jones',
        'time': 'Friday 13:32',
        'amount': '30.00 KD'
      },
      {
        'id': '#EYUD-6792',
        'name': 'Jacob Jones',
        'time': 'Friday 13:32',
        'amount': '30.00 KD'
      },
    ];
    final theme = context.theme;
    final bloc = context.read<MainScreenBloc>();
    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: orders.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        final order = orders[index];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 3.0),
          child: Material(
            color: theme.colorScheme.onPrimary,
            elevation: 2,
            child: ListTile(
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      order['name']!,
                      style: theme.textTheme.titleMedium!.copyWith(
                        color: theme.colorScheme.secondary,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      order['amount']!,
                      style: theme.textTheme.titleMedium!.copyWith(
                        color: theme.colorScheme.secondary,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    order['id']!,
                    style: theme.textTheme.titleMedium!.copyWith(
                      color: theme.colorScheme.primaryContainer,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    "|",
                    style: theme.textTheme.titleMedium!.copyWith(
                      color: theme.colorScheme.primaryContainer,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    order['time']!,
                    style: theme.textTheme.titleMedium!.copyWith(
                      color: theme.colorScheme.primaryContainer,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Spacer(),
                  BlocBuilder<MainScreenBloc, MainScreenState>(
                    builder: (context, state) {
                      return PopupMenuButton<int>(
                          color: Colors.white,
                          shadowColor: Colors.transparent,
                          offset: const Offset(0, 40),
                          elevation: 0,
                          tooltip: '',
                          splashRadius: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          constraints: const BoxConstraints(minWidth: 120),
                          position: PopupMenuPosition.over,
                          itemBuilder: (context) {
                            return bloc.orderStatusList.entries
                                .map((MapEntry<int, String> entry) {
                              return PopupMenuItem<int>(
                                value: entry.key,
                                child: Text(
                                  entry.value,
                                  style: theme.textTheme.titleSmall!.copyWith(
                                    fontSize: 15,
                                    color: theme.colorScheme.secondary,
                                  ),
                                ),
                              );
                            }).toList();
                          },
                          onSelected: (selectedUserType) {
                            bloc.orderStatusController.text =
                                bloc.orderStatusList[selectedUserType] ??
                                    'None';
                            bloc.updateOrderSelectedIndex(index);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: BaseConstant.orderStatus3Color),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 3.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    bloc.orderStatusList[2].toString(),
                                    style: theme.textTheme.titleMedium!
                                        .copyWith(
                                            color: theme.colorScheme.secondary,
                                            fontSize: 10,
                                            fontWeight: FontWeight.w500),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Icon(
                                    Icons.keyboard_arrow_down_rounded,
                                    color: theme.colorScheme.secondary
                                        .withOpacity(0.8),
                                    size: 22,
                                  )
                                ],
                              ),
                            ),
                          ));
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class OutOfDelivery extends StatelessWidget {
  const OutOfDelivery({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // Sample data
    final orders = [
      {
        'id': '#EYUD-6792',
        'name': 'Jacob Jones',
        'time': 'Friday 13:32',
        'amount': '30.00 KD'
      },
      {
        'id': '#EYUD-6792',
        'name': 'Jacob Jones',
        'time': 'Friday 13:32',
        'amount': '30.00 KD'
      },
    ];
    final theme = context.theme;
    final bloc = context.read<MainScreenBloc>();
    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: orders.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        final order = orders[index];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 3.0),
          child: Material(
            color: theme.colorScheme.onPrimary,
            elevation: 2,
            child: ListTile(
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      order['name']!,
                      style: theme.textTheme.titleMedium!.copyWith(
                        color: theme.colorScheme.secondary,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      order['amount']!,
                      style: theme.textTheme.titleMedium!.copyWith(
                        color: theme.colorScheme.secondary,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    order['id']!,
                    style: theme.textTheme.titleMedium!.copyWith(
                      color: theme.colorScheme.primaryContainer,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    "|",
                    style: theme.textTheme.titleMedium!.copyWith(
                      color: theme.colorScheme.primaryContainer,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    order['time']!,
                    style: theme.textTheme.titleMedium!.copyWith(
                      color: theme.colorScheme.primaryContainer,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Spacer(),
                  BlocBuilder<MainScreenBloc, MainScreenState>(
                    builder: (context, state) {
                      return PopupMenuButton<int>(
                          color: Colors.white,
                          shadowColor: Colors.transparent,
                          offset: const Offset(0, 40),
                          elevation: 0,
                          tooltip: '',
                          splashRadius: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          constraints: const BoxConstraints(minWidth: 120),
                          position: PopupMenuPosition.over,
                          itemBuilder: (context) {
                            return bloc.orderStatusList.entries
                                .map((MapEntry<int, String> entry) {
                              return PopupMenuItem<int>(
                                value: entry.key,
                                child: Text(
                                  entry.value,
                                  style: theme.textTheme.titleSmall!.copyWith(
                                    fontSize: 15,
                                    color: theme.colorScheme.secondary,
                                  ),
                                ),
                              );
                            }).toList();
                          },
                          onSelected: (selectedUserType) {
                            bloc.orderStatusController.text =
                                bloc.orderStatusList[selectedUserType] ??
                                    'None';
                            bloc.updateOrderSelectedIndex(index);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: BaseConstant.orderStatus4Color),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 3.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    bloc.orderStatusList[3].toString(),
                                    style: theme.textTheme.titleMedium!
                                        .copyWith(
                                            color: theme.colorScheme.secondary,
                                            fontSize: 10,
                                            fontWeight: FontWeight.w500),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Icon(
                                    Icons.keyboard_arrow_down_rounded,
                                    color: theme.colorScheme.secondary
                                        .withOpacity(0.8),
                                    size: 22,
                                  )
                                ],
                              ),
                            ),
                          ));
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class Delivered extends StatelessWidget {
  const Delivered({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // Sample data
    final orders = [
      {
        'id': '#EYUD-6792',
        'name': 'Jacob Jones',
        'time': 'Friday 13:32',
        'amount': '30.00 KD'
      },
      {
        'id': '#EYUD-6792',
        'name': 'Jacob Jones',
        'time': 'Friday 13:32',
        'amount': '30.00 KD'
      },
    ];
    final theme = context.theme;
    final bloc = context.read<MainScreenBloc>();
    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: orders.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        final order = orders[index];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 3.0),
          child: Material(
            color: theme.colorScheme.onPrimary,
            elevation: 2,
            child: ListTile(
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      order['name']!,
                      style: theme.textTheme.titleMedium!.copyWith(
                        color: theme.colorScheme.secondary,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      order['amount']!,
                      style: theme.textTheme.titleMedium!.copyWith(
                        color: theme.colorScheme.secondary,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    order['id']!,
                    style: theme.textTheme.titleMedium!.copyWith(
                      color: theme.colorScheme.primaryContainer,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    "|",
                    style: theme.textTheme.titleMedium!.copyWith(
                      color: theme.colorScheme.primaryContainer,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    order['time']!,
                    style: theme.textTheme.titleMedium!.copyWith(
                      color: theme.colorScheme.primaryContainer,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Spacer(),
                  BlocBuilder<MainScreenBloc, MainScreenState>(
                    builder: (context, state) {
                      return PopupMenuButton<int>(
                          color: Colors.white,
                          shadowColor: Colors.transparent,
                          offset: const Offset(0, 40),
                          elevation: 0,
                          tooltip: '',
                          splashRadius: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          constraints: const BoxConstraints(minWidth: 120),
                          position: PopupMenuPosition.over,
                          itemBuilder: (context) {
                            return bloc.orderStatusList.entries
                                .map((MapEntry<int, String> entry) {
                              return PopupMenuItem<int>(
                                value: entry.key,
                                child: Text(
                                  entry.value,
                                  style: theme.textTheme.titleSmall!.copyWith(
                                    fontSize: 15,
                                    color: theme.colorScheme.secondary,
                                  ),
                                ),
                              );
                            }).toList();
                          },
                          onSelected: (selectedUserType) {
                            bloc.orderStatusController.text =
                                bloc.orderStatusList[selectedUserType] ??
                                    'None';
                            bloc.updateOrderSelectedIndex(index);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: BaseConstant.orderStatus5Color),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 3.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    bloc.orderStatusList[4].toString(),
                                    style: theme.textTheme.titleMedium!
                                        .copyWith(
                                            color: theme.colorScheme.secondary,
                                            fontSize: 10,
                                            fontWeight: FontWeight.w500),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Icon(
                                    Icons.keyboard_arrow_down_rounded,
                                    color: theme.colorScheme.secondary
                                        .withOpacity(0.8),
                                    size: 22,
                                  )
                                ],
                              ),
                            ),
                          ));
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class SalesScreen extends StatelessWidget {
  const SalesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<SalesData> salesData = [
      SalesData(day: 'M', sales: 3),
      SalesData(day: 'T', sales: 5),
      SalesData(day: 'W', sales: 2),
      SalesData(day: 'T', sales: 6),
      SalesData(day: 'F', sales: 8),
      SalesData(day: 'S', sales: 7),
      SalesData(day: 'S', sales: 4),
    ];
    List imagesList = [
      'assets/3x/image3.png',
      'assets/3x/image3.png',
      'assets/3x/image2.png',
    ];
    List popularDataList = [
      'The IT Jumpsuit',
      'Skirt 158',
      'Casual 1105',
      'Summer Vibes 1200',
    ];
    final theme = context.theme;
    final size = context.mediaSize;
    return Container(
      height: size.height,
      width: size.width,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        color: const Color(0xfff8f8f7),
                        borderRadius: BorderRadius.circular(08)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            AppStrings.TOTAL_SALES,
                            style: theme.textTheme.titleMedium!.copyWith(
                              color: theme.colorScheme.primaryContainer,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            "356KD",
                            style: theme.textTheme.titleMedium!.copyWith(
                              color: theme.colorScheme.secondary,
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        color: const Color(0xfff8f8f7),
                        borderRadius: BorderRadius.circular(08)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            AppStrings.TOTAL_ORDERS,
                            style: theme.textTheme.titleMedium!.copyWith(
                              color: theme.colorScheme.primaryContainer,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            "23",
                            style: theme.textTheme.titleMedium!.copyWith(
                              color: theme.colorScheme.secondary,
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: BaseConstant.salesChartColor,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: theme.colorScheme.onPrimary),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Sale',
                        style: theme.textTheme.titleMedium!.copyWith(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'Average Sale',
                            style: theme.textTheme.titleMedium!.copyWith(
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                                color: theme.colorScheme.primaryContainer),
                          ),
                          Text(
                            '1459 KD',
                            style: theme.textTheme.titleMedium!.copyWith(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: theme.colorScheme.secondary),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: size.height * 0.2,
                    width: size.width,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Goal',
                          style: theme.textTheme.titleMedium!.copyWith(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: theme.colorScheme.primaryContainer),
                        ),
                        AspectRatio(
                          aspectRatio: 1.7,
                          child: BarChart(
                            BarChartData(
                              borderData: FlBorderData(show: false),
                              gridData: const FlGridData(show: false),
                              titlesData: FlTitlesData(
                                leftTitles: const AxisTitles(
                                    sideTitles: SideTitles(showTitles: false)),
                                rightTitles: const AxisTitles(
                                    sideTitles: SideTitles(showTitles: false)),
                                topTitles: const AxisTitles(
                                    sideTitles: SideTitles(showTitles: false)),
                                bottomTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                    showTitles: true,
                                    getTitlesWidget: (value, meta) {
                                      const style = TextStyle(
                                          color: Colors.black, fontSize: 10);
                                      switch (value.toInt()) {
                                        case 0:
                                          return const Text('M', style: style);
                                        case 1:
                                          return const Text('T', style: style);
                                        case 2:
                                          return const Text('W', style: style);
                                        case 3:
                                          return const Text('T', style: style);
                                        case 4:
                                          return const Text('F', style: style);
                                        case 5:
                                          return const Text('S', style: style);
                                        case 6:
                                          return const Text('S', style: style);
                                        default:
                                          return const Text('', style: style);
                                      }
                                    },
                                  ),
                                ),
                              ),
                              barGroups: salesData
                                  .asMap()
                                  .map((index, data) => MapEntry(
                                        index,
                                        BarChartGroupData(
                                          x: index,
                                          barRods: [
                                            BarChartRodData(
                                              toY: data.sales,
                                              color:
                                                  theme.colorScheme.onPrimary,
                                              width: 16,
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                          ],
                                        ),
                                      ))
                                  .values
                                  .toList(),
                              extraLinesData: ExtraLinesData(
                                horizontalLines: [
                                  HorizontalLine(
                                    y: 4,
                                    color: BaseConstant.salesChartGoalBarColor,
                                    strokeWidth: 2,
                                    dashArray: [1, 1],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
                height: 180,
                width: size.width,
                decoration: BoxDecoration(
                    color: BaseConstant.salesChartColor,
                    borderRadius: BorderRadius.circular(08)),
                child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppStrings.MOST_POPOULALR_ITEMS,
                            style: theme.textTheme.titleMedium!.copyWith(
                              color: theme.colorScheme.secondary,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Expanded(
                            child: ListView.builder(
                                itemCount: imagesList.length,
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(right: 12.0),
                                    child: Column(
                                      children: [
                                        Container(
                                          height: 90,
                                          width: 90,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              image: DecorationImage(
                                                  image: AssetImage(
                                                      imagesList[index]),
                                                  fit: BoxFit.cover)),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          "45 pcs",
                                          style: theme.textTheme.titleMedium!
                                              .copyWith(
                                            color: theme
                                                .colorScheme.primaryContainer,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                          ),
                        ]))),
            const SizedBox(
              height: 10,
            ),
            Container(
                height: 170,
                decoration: BoxDecoration(
                    color: BaseConstant.salesChartColor,
                    borderRadius: BorderRadius.circular(08)),
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppStrings.MOST_POPUALAR_CATEGORY_THROUGHT_THE_APP,
                            style: theme.textTheme.titleMedium!.copyWith(
                              color: theme.colorScheme.secondary,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Wrap(
                            spacing: 10,
                            children: [
                              for (int i = 0; i < 4; i++)
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 4.0),
                                  child: Material(
                                    elevation: 1,
                                    borderRadius: BorderRadius.circular(8),
                                    color: theme.colorScheme.onTertiary,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(25),
                                          color: theme.colorScheme.onTertiary),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          popularDataList[i],
                                          style: theme.textTheme.bodySmall!.copyWith(
                                            color:theme.colorScheme.secondary
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          )
                        ])))
          ]),
        ),
      ),
    );
  }
}

class SalesData {
  final String day;
  final double sales;

  SalesData({required this.day, required this.sales});
}
