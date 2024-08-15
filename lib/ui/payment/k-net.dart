import 'package:flutter/material.dart';
import 'package:myfatoorah_flutter/myfatoorah_flutter.dart';

// class KNET extends StatelessWidget {
//   static const String route = "_KNET_payment";
//   const KNET({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final theme = context.theme;
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('my_fatoorah Demo'),
//       ),
//       body: Center(
//         child: Container(
//           padding: const EdgeInsets.all(8.0),
//           child: MaterialButton(
//             color: theme.colorScheme.primary,
//             onPressed: () async {
//               var response = await MyFatoorah.startPayment(
//                 context: context,
//                 successChild: const Icon(Icons.abc),
//                 // afterPaymentBehaviour:
//                 //     AfterPaymentBehaviour.BeforeCallbackExecution,
//                 request: MyfatoorahRequest.test(
//                   currencyIso: Country.Kuwait,
//                   successUrl: 'https://pub.dev/packages/get',
//                   errorUrl: 'https://www.google.com/',
//                   invoiceAmount: 100,
//                   language: ApiLanguage.English,
//                   token:
//                       'rLtt6JWvbUHDDhsZnfpAhpYk4dxYDQkbcPTyGaKp2TYqQgG7FGZ5Th_WD53Oq8Ebz6A53njUoo1w3pjU1D4vs_ZMqFiz_j0urb_BH9Oq9VZoKFoJEDAbRZepGcQanImyYrry7Kt6MnMdgfG5jn4HngWoRdKduNNyP4kzcp3mRv7x00ahkm9LAK7ZRieg7k1PDAnBIOG3EyVSJ5kK4WLMvYr7sCwHbHcu4A5WwelxYK0GMJy37bNAarSJDFQsJ2ZvJjvMDmfWwDVFEVe_5tOomfVNt6bOg9mexbGjMrnHBnKnZR1vQbBtQieDlQepzTZMuQrSuKn-t5XZM7V6fCW7oP-uXGX-sMOajeX65JOf6XVpk29DP6ro8WTAflCDANC193yof8-f5_EYY-3hXhJj7RBXmizDpneEQDSaSz5sFk0sV5qPcARJ9zGG73vuGFyenjPPmtDtXtpx35A-BVcOSBYVIWe9kndG3nclfefjKEuZ3m4jL9Gg1h2JBvmXSMYiZtp9MR5I6pvbvylU_PP5xJFSjVTIz7IQSjcVGO41npnwIxRXNRxFOdIUHn0tjQ-7LwvEcTXyPsHXcMD8WtgBh-wxR8aKX7WPSsT1O8d8reb2aR7K3rkV3K82K_0OgawImEpwSvp9MNKynEAJQS6ZHe_J_l77652xwPNxMRTMASk1ZsJL',
//                 ),
//               );
//               log(response.paymentId.toString());
//             },
//             splashColor: Colors.blueGrey,
//             child: const Text(
//               'Show Payment',
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: 16,
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

class KNET extends StatefulWidget {
  static const String route = "_KNET_payment";

  @override
  _KNETState createState() => _KNETState();
}

class _KNETState extends State<KNET> {
  @override
  void initState() {
    super.initState();
    _initializeMyFatoorah();
  }

  void _initializeMyFatoorah() {
    // Initialize the MyFatoorah SDK with the test API key
    MFSDK.init(
      "rLtt6JWvbUHDDhsZnfpAhpYk4dxYDQkbcPTyGaKp2TYqQgG7FGZ5Th_WD53Oq8Ebz6A53njUoo1w3pjU1D4vs_ZMqFiz_j0urb_BH9Oq9VZoKFoJEDAbRZepGcQanImyYrry7Kt6MnMdgfG5jn4HngWoRdKduNNyP4kzcp3mRv7x00ahkm9LAK7ZRieg7k1PDAnBIOG3EyVSJ5kK4WLMvYr7sCwHbHcu4A5WwelxYK0GMJy37bNAarSJDFQsJ2ZvJjvMDmfWwDVFEVe_5tOomfVNt6bOg9mexbGjMrnHBnKnZR1vQbBtQieDlQepzTZMuQrSuKn-t5XZM7V6fCW7oP-uXGX-sMOajeX65JOf6XVpk29DP6ro8WTAflCDANC193yof8-f5_EYY-3hXhJj7RBXmizDpneEQDSaSz5sFk0sV5qPcARJ9zGG73vuGFyenjPPmtDtXtpx35A-BVcOSBYVIWe9kndG3nclfefjKEuZ3m4jL9Gg1h2JBvmXSMYiZtp9MR5I6pvbvylU_PP5xJFSjVTIz7IQSjcVGO41npnwIxRXNRxFOdIUHn0tjQ-7LwvEcTXyPsHXcMD8WtgBh-wxR8aKX7WPSsT1O8d8reb2aR7K3rkV3K82K_0OgawImEpwSvp9MNKynEAJQS6ZHe_J_l77652xwPNxMRTMASk1ZsJL",
      MFCountry.KUWAIT,
      MFEnvironment.TEST,
    );

    // Optional: Set up the AppBar properties
    MFSDK.setUpActionBar(
      toolBarTitle: 'Company Payment',
      toolBarTitleColor: '#FFEB3B',
      toolBarBackgroundColor: '#CA0404',
      isShowToolBar: true,
    );
  }

  Future<void> _executeDirectPayment() async {
    // Create the payment request
    var executePaymentRequest = MFExecutePaymentRequest(invoiceValue: 10.0);
    executePaymentRequest.paymentMethodId =
        1; // Example Payment Method ID for KNET

    // Card details
    var mfCardRequest = MFCard(
      cardHolderName: 'MyFatoorah',
      number: '5454545454545454',
      expiryMonth: '10',
      expiryYear: '28',
      securityCode: '564',
    );

    // Direct payment request
    var directPaymentRequest = MFDirectPaymentRequest(
      executePaymentRequest: executePaymentRequest,
      token: null,
      card: mfCardRequest,
    );

    // Execute the direct payment
    await MFSDK.executeDirectPayment(directPaymentRequest, MFLanguage.ENGLISH,
        (invoiceId) {
      debugPrint('Invoice ID: $invoiceId');
    }).then((response) {
      debugPrint('Payment Response: $response');
    }).catchError((error) {
      debugPrint('Payment Error: ${error.message}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MyFatoorah Payment'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: _executeDirectPayment,
          child: const Text('Pay with KNET'),
        ),
      ),
    );
  }
}
