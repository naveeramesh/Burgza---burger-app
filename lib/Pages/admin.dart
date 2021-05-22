import 'package:burgza/Pages/Login.dart';
import 'package:burgza/Pages/upload.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';

class Admin extends StatefulWidget {
  @override
  _AdminState createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  TextEditingController adminIdcontroller = new TextEditingController();
  TextEditingController passwordcontroller = new TextEditingController();
  _admin() async {
    QuerySnapshot snap =
        await FirebaseFirestore.instance.collection('admin').get();
    snap.docs.forEach((element) {
      if (element.data()['id'] != adminIdcontroller.text.trim()) {
        Fluttertoast.showToast(
          msg: 'Incorrect id',
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.yellow[900],
          textColor: Colors.white,
        );
      } else if (element.data()['password'] != passwordcontroller.text.trim()) {
        Fluttertoast.showToast(
          msg: 'Incorrect password',
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.yellow[900],
          textColor: Colors.white,
        );
      } else {
        Fluttertoast.showToast(
          msg: 'Welocome admin ' + element.data()['name'],
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.yellow[900],
          textColor: Colors.white,
        );
        setState(() {
          adminIdcontroller.text = '';
          passwordcontroller.text = '';
        });
        Navigator.pushReplacement(
            context,
            PageTransition(
              child: Upload(),
              type: PageTransitionType.fade,
            ));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: Column(
                children: [
                  SizedBox(
                    height: 60,
                  ),
                  Container(
                    height: 100,
                    width: 300,
                    child: Lottie.network(
                        'https://assets5.lottiefiles.com/private_files/lf30_o7BLXG.json'),
                  ),
                  Text(
                    'BURGZA',
                    style: GoogleFonts.lato(
                        textStyle: TextStyle(
                            color: Colors.white,
                            letterSpacing: 2,
                            fontSize: 20,
                            fontWeight: FontWeight.bold)),
                  ),
                  SizedBox(height: 100),
                  Text(
                    'ADMIN',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        letterSpacing: 2),
                  ),
                  SizedBox(
                    height: 150,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 30.0, right: 30.0),
                    child: TextField(
                      cursorColor: Colors.yellow[900],
                      controller: adminIdcontroller,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: ('ID :'),
                        hintStyle: TextStyle(
                          color: Colors.white,
                          fontStyle: FontStyle.normal,
                        ),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.yellow)),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.yellow),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 30.0, right: 30.0),
                    child: TextField(
                      cursorColor: Colors.yellow[900],
                      controller: passwordcontroller,
                      obscureText: true,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: ('Password :'),
                        hintStyle: TextStyle(
                          color: Colors.white,
                          fontStyle: FontStyle.normal,
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
                    height: 250,
                  ),
                  GestureDetector(
                    onTap: () {
                      adminIdcontroller.text.isEmpty &&
                              passwordcontroller.text.isEmpty
                          ? showAlertDialog(context)
                          : _admin();
                    },
                    child: Container(
                      height: 60,
                      width: 200,
                      decoration: BoxDecoration(
                        color: Colors.yellow[700],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: Text(
                          'LOGIN',
                          style: GoogleFonts.lato(
                            textStyle: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              letterSpacing: 1,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}

showAlertDialog(BuildContext context) {
  Widget button = FlatButton(
    child: Text('OK'),
    onPressed: () {
      Navigator.pushReplacement(context,
          PageTransition(child: Admin(), type: PageTransitionType.fade));
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
