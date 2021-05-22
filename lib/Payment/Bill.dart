import 'package:burgza/Pages/Account.dart';
import 'package:burgza/Pages/Cart.dart';
import 'package:burgza/Pages/map.dart';
import 'package:burgza/Payment/Pay.dart';
import 'package:burgza/Services/location.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';

class Billing extends StatefulWidget {
  @override
  _BillingState createState() => _BillingState();
}

class _BillingState extends State<Billing> {
  TextEditingController namecontroller = TextEditingController();
  TextEditingController addresscontroller = TextEditingController();
  TextEditingController numbercontroller = TextEditingController();
  TextEditingController emcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
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
                                  type:
                                      PageTransitionType.rightToLeftWithFade));
                        }),
                    IconButton(
                        icon: Icon(EvaIcons.shoppingCartOutline,
                            color: Colors.white),
                        onPressed: () {
                          Navigator.push(
                              context,
                              PageTransition(
                                  child: Cart(),
                                  type:
                                      PageTransitionType.rightToLeftWithFade));
                        })
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.grey[800],
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: finalAddress,
                      hintStyle: TextStyle(color: Colors.white),
                      suffixIcon: IconButton(
                        icon: Icon(Icons.search),
                        color: Colors.white,
                        onPressed: () {
                          Navigator.push(
                              context,
                              PageTransition(
                                  child: Maps(),
                                  type: PageTransitionType.fade));
                        },
                      ),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey[800])),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey[800]),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Container(
                height: 300,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                      child: TextField(
                        cursorColor: Colors.yellow[900],
                        controller: namecontroller,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: 'Name :',
                          hintStyle: TextStyle(color: Colors.white),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.yellow)),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.yellow),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                      child: TextField(
                        cursorColor: Colors.yellow[900],
                        controller: addresscontroller,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: 'Address :',
                          hintStyle: TextStyle(color: Colors.white),
                          suffixIcon: Icon(
                            Icons.edit,
                            color: Colors.white,
                          ),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.yellow)),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.yellow),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                      child: TextField(
                        cursorColor: Colors.yellow[900],
                        controller: numbercontroller,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: 'Phone number :',
                          hintStyle: TextStyle(color: Colors.white),
                          suffixIcon: Icon(
                            Icons.phone,
                            color: Colors.white,
                          ),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.yellow)),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.yellow),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                      child: TextField(
                        cursorColor: Colors.yellow[900],
                        controller: emcontroller,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: 'Email :',
                          hintStyle: TextStyle(color: Colors.white),
                          suffixIcon: Icon(
                            Icons.email,
                            color: Colors.white,
                          ),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.yellow)),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.yellow),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 300,
              ),
              GestureDetector(
                onTap: () {
                    namecontroller.text.isEmpty && emcontroller.text.isEmpty && numbercontroller.text.isEmpty && addresscontroller.text.isEmpty
                  ? showAlertDialog(context)
                  :
                  Navigator.push(
                      context,
                      PageTransition(
                        child: Pay(),
                        type: PageTransitionType.fade,
                      ));
                },
                child: Container(
                  height: 60,
                  width: 250,
                  decoration: BoxDecoration(
                    color: Colors.yellow[700],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Text('PLACE ORDER',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        )),
                  ),
                ),
              ),
            ],
          ),
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
          context,
          PageTransition(
            child: Billing(),
            type: PageTransitionType.fade
          ));
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
