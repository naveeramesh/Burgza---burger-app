import 'package:burgza/Pages/Account.dart';
import 'package:burgza/Pages/Cart.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class Pay extends StatefulWidget {
  @override
  _PayState createState() => _PayState();
}

class _PayState extends State<Pay> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  int total = 0;
  Razorpay _razorpay;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _razorpay = Razorpay();

    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWallet);
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  void openCheckUp() async {
    var options = {
      'key': 'rzp_test_9h2E08DD1F93bC',
      'amount': total * 100,
      'name': 'Burgza',
      'description': 'Test Payment',
      'prefill': {'contact': '', 'email': ''},
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

  void handlePaymentSuccess(PaymentSuccessResponse response) {
    Fluttertoast.showToast(msg: 'Success' + response.paymentId);
  }

  void handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(
        msg: 'Error' + response.code.toString() + '-' + response.message);
  }

  void handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(msg: 'ExternalWallet' + response.walletName);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Container(
              height: 60,
              child: Row(
                children: [
                  Lottie.network(
                      'https://assets5.lottiefiles.com/private_files/lf30_o7BLXG.json'),
                  Text('BURGZA',
                      style: GoogleFonts.lato(
                          textStyle: TextStyle(
                              color: Colors.white,
                              letterSpacing: 2,
                              fontSize: 20,
                              fontWeight: FontWeight.bold))),
                  SizedBox(
                    width: 120,
                  ),
                  IconButton(
                      icon: Icon(Icons.account_circle_rounded,
                          color: Colors.white),
                      onPressed: () {
                        Navigator.push(
                            context,
                            PageTransition(
                                child: Account(),
                                type: PageTransitionType.rightToLeftWithFade));
                      }),
                  IconButton(
                      icon: Icon(EvaIcons.shoppingCartOutline,
                          color: Colors.white),
                      onPressed: () {
                        Navigator.push(
                            context,
                            PageTransition(
                                child: Cart(),
                                type: PageTransitionType.rightToLeftWithFade));
                      })
                ],
              ),
            ),
            SizedBox(
              height: 200,
            ),
            Text('PAYMENT DETAILS',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                )),
            SizedBox(
              height: 20,
            ),
            Container(
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                child: TextField(
                  cursorColor: Colors.yellow[900],
                  controller: nameController,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Name:',
                    hintStyle: TextStyle(
                      color: Colors.white,
                    ),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.yellow)),
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.yellow)),
                  ),
                ),
              ),
            ),
            Container(
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                child: TextField(
                  cursorColor: Colors.yellow[900],
                  controller: emailController,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Emali:',
                    hintStyle: TextStyle(
                      color: Colors.white,
                    ),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.yellow)),
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.yellow)),
                  ),
                ),
              ),
            ),
            Container(
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                child: TextField(
                  cursorColor: Colors.yellow[900],
                  controller: amountController,
                  style: TextStyle(color: Colors.white),
                  onChanged: (value) {
                    setState(() {
                      total = num.parse(value);
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'Enter the amount:',
                    hintStyle: TextStyle(
                      color: Colors.white,
                    ),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.yellow)),
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.yellow)),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 80,
            ),
            GestureDetector(
              onTap: () async {
                nameController.text.isEmpty &&
                        emailController.text.isEmpty &&
                        amountController.text.isEmpty
                    ? showAlertDialog(context)
                    : openCheckUp();
              },
              child: Container(
                height: 50,
                width: 150,
                decoration: BoxDecoration(
                  color: Colors.yellow[700],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: Text('CHECK OUT',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      )),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

showAlertDialog(BuildContext context) {
  Widget button = FlatButton(
    child: Text('OK'),
    onPressed: () {
      Navigator.pushReplacement(
          context, PageTransition(child: Pay(), type: PageTransitionType.fade));
    },
  );
  AlertDialog alert = AlertDialog(
    title: Text('Please fill the given items '),
    actions: [
      button,
    ],
  );
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      });
}
