import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sera/extensions/context_extension.dart';
import 'package:sera/ui/messages/nessage_list.dart';
import 'package:sera/ui/orders/orders_bloc.dart';
import 'package:sera/ui/orders/orders_state.dart';

class OrderScreen extends StatelessWidget {
  static const String route = "_orders_screen";
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final size = context.mediaSize;

    final bloc = context.read<OrdersBloc>();
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
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, UserMessagesScreen.route);
                },
                child: Image.asset("assets/3x/messages.png")),
          )
        ],
      ),
      body: SizedBox(
        height: size.height,
        child: Stack(
          children: [
            Positioned(
              top: -90,
              right: -65,
              child: Container(
                height: 250,
                width: 260,
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary.withOpacity(0.3),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Column(
              children: [
                const SizedBox(height: 130),
                SizedBox(
                  height: 40,
                  width: size.width,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: ListView.builder(
                      itemCount: bloc.dataList.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      physics: const ScrollPhysics(),
                      itemBuilder: (context, index) {
                        return BlocBuilder<OrdersBloc, OrdersScreenState>(
                          builder: (context, state) {
                            return GestureDetector(
                              onTap: () {
                                bloc.updatePagerIndex(index);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: state.pagerIndex == index
                                          ? theme.colorScheme.secondary
                                          : theme.colorScheme.primaryContainer,
                                      width:
                                          state.pagerIndex == index ? 2.0 : 1.0,
                                    ),
                                  ),
                                ),
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12.0),
                                    child: Text(
                                      bloc.dataList[index],
                                      style:
                                          theme.textTheme.titleLarge!.copyWith(
                                        color: state.pagerIndex == index
                                            ? theme.colorScheme.secondary
                                            : theme
                                                .colorScheme.primaryContainer,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
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
                ),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: BlocBuilder<OrdersBloc, OrdersScreenState>(
                    builder: (context, state) {
                      return state.pagerIndex == 0
                          ? const PendingOrder()
                          : state.pagerIndex == 1
                              ? const PreparingOrder()
                              : state.pagerIndex == 2
                                  ? const ReadyForPickup()
                                  : state.pagerIndex == 3
                                      ? const OutOfDelivery()
                                      : const Delivered();
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
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
                padding: const EdgeInsets.only(top: 4.0),
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
                      style: theme.textTheme.titleLarge!.copyWith(
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
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    "|",
                    style: theme.textTheme.titleMedium!.copyWith(
                      color: theme.colorScheme.primaryContainer,
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    order['time']!,
                    style: theme.textTheme.titleMedium!.copyWith(
                      color: theme.colorScheme.primaryContainer,
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                    ),
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
                padding: const EdgeInsets.only(top: 4.0),
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
                      style: theme.textTheme.titleLarge!.copyWith(
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
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    "|",
                    style: theme.textTheme.titleMedium!.copyWith(
                      color: theme.colorScheme.primaryContainer,
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    order['time']!,
                    style: theme.textTheme.titleMedium!.copyWith(
                      color: theme.colorScheme.primaryContainer,
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                    ),
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
                padding: const EdgeInsets.only(top: 4.0),
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
                      style: theme.textTheme.titleLarge!.copyWith(
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
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    "|",
                    style: theme.textTheme.titleMedium!.copyWith(
                      color: theme.colorScheme.primaryContainer,
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    order['time']!,
                    style: theme.textTheme.titleMedium!.copyWith(
                      color: theme.colorScheme.primaryContainer,
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                    ),
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
                padding: const EdgeInsets.only(top: 4.0),
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
                      style: theme.textTheme.titleLarge!.copyWith(
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
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    "|",
                    style: theme.textTheme.titleMedium!.copyWith(
                      color: theme.colorScheme.primaryContainer,
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    order['time']!,
                    style: theme.textTheme.titleMedium!.copyWith(
                      color: theme.colorScheme.primaryContainer,
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                    ),
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
                padding: const EdgeInsets.only(top: 4.0),
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
                      style: theme.textTheme.titleLarge!.copyWith(
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
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    "|",
                    style: theme.textTheme.titleMedium!.copyWith(
                      color: theme.colorScheme.primaryContainer,
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    order['time']!,
                    style: theme.textTheme.titleMedium!.copyWith(
                      color: theme.colorScheme.primaryContainer,
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                    ),
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
