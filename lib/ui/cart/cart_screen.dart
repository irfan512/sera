import 'package:flutter/material.dart';
import 'package:sera/extensions/context_extension.dart';
import 'package:sera/ui/cart_checkout/cart_checkout.dart';
import 'package:sera/ui/common/app_bar.dart';
import 'package:sera/ui/common/app_button.dart';
import 'package:sera/util/app_strings.dart';

class CartScreen extends StatelessWidget {
  static const String route = "_cart_screen";
  const CartScreen({super.key});

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
            AppStrings.CART,
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
        body: Padding(
            padding: const EdgeInsets.all(15.0),
            child: SingleChildScrollView(
                child: Column(children: [
              ListView.builder(
                itemCount: 3,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: CartCard(),
                  );
                },
              ),
              const SizedBox(
                height: 30,
              ),
              Divider(
                color: theme.colorScheme.onSecondaryContainer,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppStrings.ITEMS,
                    style: theme.textTheme.titleMedium!.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: theme.colorScheme.primaryContainer),
                  ),
                  Text("3",
                      style: theme.textTheme.titleMedium!.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: theme.colorScheme.secondary)),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppStrings.DELIVERY_CHARGES,
                    style: theme.textTheme.titleMedium!.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: theme.colorScheme.primaryContainer),
                  ),
                  Text("10.00 KD",
                      style: theme.textTheme.titleMedium!.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: theme.colorScheme.secondary)),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppStrings.SUB_TOTAL,
                    style: theme.textTheme.titleMedium!.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: theme.colorScheme.primaryContainer),
                  ),
                  Text("107.7 KD",
                      style: theme.textTheme.titleMedium!.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: theme.colorScheme.secondary)),
                ],
              ),
              Divider(
                color: theme.colorScheme.onSecondaryContainer,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppStrings.TOTAL,
                    style: theme.textTheme.titleLarge!.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: theme.colorScheme.secondary),
                  ),
                  Text("107.7 KD",
                      style: theme.textTheme.titleLarge!.copyWith(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: theme.colorScheme.secondary)),
                ],
              ),
              Divider(
                color: theme.colorScheme.onSecondaryContainer,
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                  height: 40,
                  width: MediaQuery.of(context).size.width,
                  child: AppButton(
                      textColor: Colors.white,
                      fontSize: 16,
                      borderRadius: 8,
                      color: theme.colorScheme.primary,
                      text: AppStrings.CHECK_OUT,
                      onClick: () {
                        context.unfocus();

                        Navigator.pushNamed(context, CartCheckout.route);
                      })),
            ]))));
  }
}

class CartCard extends StatelessWidget {
  const CartCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final size = context.mediaSize;

    return Material(
        color: theme.colorScheme.onPrimary,
        elevation: 4,
        borderRadius: BorderRadius.circular(8),
        child: Container(
            height: 85,
            width: size.width,
            decoration: BoxDecoration(
              color: theme.colorScheme.onPrimary,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
                child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(children: [
                            Container(
                                height: 70,
                                width: 70,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    image: const DecorationImage(
                                        image: AssetImage(
                                          "assets/3x/image2.png",
                                        ),
                                        fit: BoxFit.cover))),
                            const SizedBox(
                              width: 20,
                            ),
                            Expanded(
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                  Row(
                                    children: [
                                      Text(
                                        "Badacore Tshirt",
                                        style: theme.textTheme.titleMedium!
                                            .copyWith(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                                color: theme
                                                    .colorScheme.secondary),
                                      ),
                                      Spacer(),
                                      Row(
                                        children: [
                                          Container(
                                            height: 15,
                                            width: 15,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: theme.colorScheme
                                                        .primaryContainer),
                                                color: theme
                                                    .colorScheme.onTertiary,
                                                borderRadius:
                                                    BorderRadius.circular(2)),
                                            child: Center(
                                              child: Text("+",
                                                  style: theme
                                                      .textTheme.bodySmall!
                                                      .copyWith(
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.bold)),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            "1",
                                            style: theme.textTheme.titleMedium!
                                                .copyWith(
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.w500,
                                                    color: theme.colorScheme
                                                        .secondary),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Container(
                                            height: 15,
                                            width: 15,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: theme.colorScheme
                                                        .primaryContainer),
                                                color: theme
                                                    .colorScheme.onTertiary,
                                                borderRadius:
                                                    BorderRadius.circular(2)),
                                            child: Center(
                                              child: Text("-",
                                                  style: theme
                                                      .textTheme.titleMedium!
                                                      .copyWith(
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.bold)),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Text("35.90 KD",
                                      style: theme.textTheme.titleLarge!
                                          .copyWith(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              color:
                                                  theme.colorScheme.secondary)),
                                  Row(children: [
                                    Text(
                                      "${AppStrings.SIZE}:",
                                      style: theme.textTheme.titleMedium!
                                          .copyWith(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w400,
                                              color: theme.colorScheme
                                                  .onSecondaryContainer),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              width: 0.4,
                                              color: theme.colorScheme
                                                  .primaryContainer),
                                          color: theme.colorScheme.onTertiary,
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 2, horizontal: 10.0),
                                        child: Text("L",
                                            style: theme.textTheme.titleSmall!
                                                .copyWith(
                                                    color: theme
                                                        .colorScheme.secondary,
                                                    fontSize: 10,
                                                    fontWeight:
                                                        FontWeight.w500)),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      "${AppStrings.LENGTH}:",
                                      style: theme.textTheme.titleMedium!
                                          .copyWith(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w400,
                                              color: theme.colorScheme
                                                  .onSecondaryContainer),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              width: 0.4,
                                              color: theme.colorScheme
                                                  .primaryContainer),
                                          color: theme.colorScheme.onTertiary,
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 3, horizontal: 10.0),
                                        child: Text("60",
                                            style: theme.textTheme.titleSmall!
                                                .copyWith(
                                                    color: theme
                                                        .colorScheme.secondary,
                                                    fontSize: 10,
                                                    fontWeight:
                                                        FontWeight.w500)),
                                      ),
                                    ),
                                    const Spacer(),
                                    GestureDetector(
                                      onTap: () {},
                                      child: const Icon(Icons.delete),
                                    )
                                  ])
                                ]))
                          ])
                        ])))));
  }
}
