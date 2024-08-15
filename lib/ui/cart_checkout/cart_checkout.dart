import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:sera/extensions/context_extension.dart';
import 'package:sera/helper/dialog_helper.dart';
import 'package:sera/ui/common/app_bar.dart';
import 'package:sera/ui/common/app_button.dart';
import 'package:sera/util/app_strings.dart';
import 'package:sera/util/base_constants.dart';
import 'package:http/http.dart' as http;

import 'cart_checkout_bloc.dart';

class CartCheckout extends StatelessWidget {
  static const String route = "_cart_checkout_screen";
  CartCheckout({super.key});
  DialogHelper get _dialogHelper => DialogHelper.instance();

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    // final textTheme = context.theme.textTheme;
    final bloc = context.read<CartCheckoutBloc>();

    return Scaffold(
      backgroundColor: theme.colorScheme.onPrimary,
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(AppStrings.PAYMENT_METHOD,
                  style: theme.textTheme.titleLarge!.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: theme.colorScheme.secondary)),
              const SizedBox(
                height: 10,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      makePayment(context, 100, bloc, _dialogHelper);
                    },
                    child: Material(
                      elevation: 2,
                      color: theme.colorScheme.onPrimary,
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        height: 90,
                        width: 100,
                        decoration: BoxDecoration(
                          color: theme.colorScheme.onPrimary,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset("assets/3x/masterCard.png"),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(AppStrings.CREDIT_CARD,
                                  style: theme.textTheme.titleMedium!.copyWith(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400,
                                      color: theme.colorScheme.secondary)),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  Material(
                    elevation: 2,
                    color: theme.colorScheme.onPrimary,
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      height: 90,
                      width: 100,
                      decoration: BoxDecoration(
                        color: theme.colorScheme.onPrimary,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset("assets/3x/knet.png"),
                            const SizedBox(
                              width: 10,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(AppStrings.KNET,
                                style: theme.textTheme.titleMedium!.copyWith(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w400,
                                    color: theme.colorScheme.secondary)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Divider(
                color: theme.colorScheme.secondaryContainer,
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppStrings.ADDRESS,
                    style: theme.textTheme.titleMedium!.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: theme.colorScheme.secondary),
                  ),
                  Text(AppStrings.CHANGE,
                      style: theme.textTheme.titleMedium!.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: theme.colorScheme.secondary)),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Material(
                elevation: 2,
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  decoration: BoxDecoration(
                      color: theme.colorScheme.onPrimary,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                          color: theme.colorScheme.onPrimaryContainer,
                          width: 0.4)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: theme.colorScheme.primary),
                              child: Image.asset("assets/3x/house.png",
                                  height: 30,
                                  width: 30,
                                  color: theme.colorScheme.secondary),
                            ),
                            const SizedBox(
                              width: 6,
                            ),
                            Text(AppStrings.HOME,
                                style: theme.textTheme.titleMedium!.copyWith(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: theme.colorScheme.secondary)),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Text(
                              AppStrings.NAME,
                              style: theme.textTheme.titleMedium!.copyWith(
                                  color: theme.colorScheme.secondary,
                                  fontSize: 14,
                                  fontFamily: BaseConstant.poppinsMedium),
                            ),
                            const SizedBox(
                              width: 6,
                            ),
                            Text(
                              "User Name",
                              style: theme.textTheme.titleMedium!.copyWith(
                                  color: BaseConstant.selectedUserdataColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              "${AppStrings.PHONE}:",
                              style: theme.textTheme.titleMedium!.copyWith(
                                  color: theme.colorScheme.secondary,
                                  fontSize: 14,
                                  fontFamily: BaseConstant.poppinsMedium),
                            ),
                            const SizedBox(
                              width: 6,
                            ),
                            Text(
                              "+1 234 567 89",
                              style: theme.textTheme.titleMedium!.copyWith(
                                  color: BaseConstant.selectedUserdataColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Kuwait ,hawalli, bayan",
                                  style: theme.textTheme.titleMedium!.copyWith(
                                      color: BaseConstant.selectedUserdataColor,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400),
                                ),
                                Text(
                                  "block 9, st 11, house 9999",
                                  style: theme.textTheme.titleMedium!.copyWith(
                                      color: BaseConstant.selectedUserdataColor,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Divider(
                color: theme.colorScheme.secondaryContainer,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  AppStrings.ORDERED_ITEMS,
                  style: theme.textTheme.titleLarge!.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: theme.colorScheme.secondary),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "3 x badacore tshirt",
                      style: theme.textTheme.bodySmall!.copyWith(
                          color: theme.colorScheme.secondary,
                          fontSize: 14,
                          fontFamily: BaseConstant.poppinsMedium),
                    ),
                    Text(
                      "35.90 KD",
                      style: theme.textTheme.bodySmall!.copyWith(
                          color: theme.colorScheme.secondary,
                          fontSize: 14,
                          fontFamily: BaseConstant.poppinsMedium),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "-L",
                      style: theme.textTheme.bodySmall!.copyWith(
                          color: theme.colorScheme.secondary,
                          fontSize: 14,
                          fontFamily: BaseConstant.poppinsMedium),
                    ),
                    Text(
                      "0.000",
                      style: theme.textTheme.bodySmall!.copyWith(
                          color: theme.colorScheme.secondary,
                          fontSize: 14,
                          fontFamily: BaseConstant.poppinsMedium),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "-60",
                      style: theme.textTheme.bodySmall!.copyWith(
                          color: theme.colorScheme.secondary,
                          fontSize: 14,
                          fontFamily: BaseConstant.poppinsMedium),
                    ),
                    Text(
                      "0.000",
                      style: theme.textTheme.bodySmall!.copyWith(
                          color: theme.colorScheme.secondary,
                          fontSize: 14,
                          fontFamily: BaseConstant.poppinsMedium),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Divider(
                color: theme.colorScheme.secondaryContainer,
              ),
              const SizedBox(
                height: 20,
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                  height: 40,
                  width: MediaQuery.of(context).size.width,
                  child: AppButton(
                      textColor: Colors.white,
                      fontSize: 16,
                      borderRadius: 8,
                      color: theme.colorScheme.primary,
                      text: " ${AppStrings.PAY_NOW} 117.17 KD",
                      onClick: () {
                        context.unfocus();
                      })),
            ],
          ),
        ),
      ),
    );
  }

  ////////// STRIPEEEEEEEEEEEEEE   //////////
  Map<String, dynamic>? paymentIntent;

  Future<void> makePayment(
    context,
    amount,
    bloc,
    dialogHelper,
  ) async {
    try {
      paymentIntent = await createPaymentIntent('$amount', 'USD');

      //STEP 2: Initialize Payment Sheet
      await Stripe.instance
          .initPaymentSheet(
              paymentSheetParameters: SetupPaymentSheetParameters(
                  paymentIntentClientSecret: paymentIntent![
                      'client_secret'], //Gotten from payment intent
                  style: ThemeMode.dark,
                  merchantDisplayName: 'sera'))
          .then((value) {
        displayPaymentSheet(
          context: context,
          transactionId: paymentIntent!['id'],
          paymentIntent: paymentIntent!,
          amount: amount,
          bloc: bloc,
          dialogHelper: dialogHelper,
        );
      });
      //STEP 3: Display Payment sheet
    } catch (err) {
      throw Exception(err);
    }
  }

  displayPaymentSheet(
      {context,
      required String transactionId,
      paymentIntent,
      amount,
      bloc,
      dialogHelper}) async {
    try {
      await Stripe.instance
          .presentPaymentSheet(options: const PaymentSheetPresentOptions())
          .then((value) async {
        final confirmedPaymentIntent = await confirmPayment(transactionId);
        log("/////////////////////////////$confirmedPaymentIntent");
        if (confirmedPaymentIntent['status'] == 'succeeded') {
         
         paymentIntent = null;
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return const AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Icon(
                      size: 45,
                      Icons.check_circle,
                      color: Colors.green,
                    ),
                    Text("Payment Success"),
                  ],
                ),
              ],
            ),
          );
        },
      );

        } else {
paymentIntent = null;
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return const AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.cancel,
                      color: Colors.red,
                    ),
                    Text("Payment Failed"),
                  ],
                ),
              ],
            ),
          );
        },
      );
        }
      }).onError((error, stackTrace) {
        throw Exception(error);
      });
    } on StripeException catch (e) {
      const AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Icon(
                  Icons.cancel,
                  color: Colors.red,
                ),
                Text("Payment Failed"),
              ],
            ),
          ],
        ),
      );
    } catch (e) {
      debugPrint('$e');
    }
  }

  createPaymentIntent(String amount, String currency) async {
    try {
      //Request body
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
      };
      //Make post request to Stripe
      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization': 'Bearer ${dotenv.env['STRIPE_SECRET']}',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: body,
      );
      return json.decode(response.body);
    } catch (err) {
      throw Exception(err.toString());
    }
  }

  calculateAmount(String amount) {
    final calculatedAmout = (int.parse(amount)) * 100;
    return calculatedAmout.toString();
  }

// This function checks the payment status by retrieving the payment intent
  Future<Map<String, dynamic>> confirmPayment(String paymentIntentId) async {
    try {
      var response = await http.get(
        Uri.parse('https://api.stripe.com/v1/payment_intents/$paymentIntentId'),
        headers: {
          'Authorization': 'Bearer ${dotenv.env['STRIPE_SECRET']}',
          'Content-Type': 'application/x-www-form-urlencoded',
        },
      );

      return json.decode(response.body);
    } catch (err) {
      throw Exception('Failed to confirm payment: ${err.toString()}');
    }
  }
}
