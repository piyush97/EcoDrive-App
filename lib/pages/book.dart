import 'package:ecodrive/pages/rentLater.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Book extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _BookState createState() => _BookState();
}

class _BookState extends State<Book> {
  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Book your Ecodrive",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
          // RaisedButton(
          //   onPressed: () {
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //         builder: (context) => BookNow(),
          //       ),
          //     );
          //   },
          //   child: const Text('Book Now', style: TextStyle(fontSize: 20)),
          // ),
          const SizedBox(height: 15),
          RaisedButton(
            color: Colors.green,
            // onPressed: () {
            //   Navigator.push(
            //       context,
            //       MaterialPageRoute<Null>(
            //         builder: (BuildContext context) {
            //           return Selectdate();
            //         },
            //         fullscreenDialog: true,
            //       ));
            // },
            onPressed: openCheckout2500,
            child: const Text(
              'PreBook your ride!',
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
          ),
        ]),
      ),
    );
  }

  Razorpay _razorpay;

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  void openCheckout2500() async {
    var options = {
      'key': 'rzp_test_1DP5mmOlF5G5ag',
      'amount': 50000.0,
      'name': 'Eco Drive',
      'description': 'Eco Drive Payment',
      'prefill': {'contact': '8888888888', 'email': 'test@razorpay.com'},
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint(e);
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    Fluttertoast.showToast(
        msg: "SUCCESS: " + response.paymentId, timeInSecForIos: 4);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(
        msg: "ERROR: " + response.code.toString() + " - " + response.message,
        timeInSecForIos: 4);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(
        msg: "EXTERNAL_WALLET: " + response.walletName, timeInSecForIos: 4);
  }

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }
}
