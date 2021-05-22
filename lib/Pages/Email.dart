import 'package:burgza/Pages/HomeScreen.dart';
import 'package:burgza/Services/LoadingAlertDialog.dart';
import 'package:burgza/Services/SharedPreferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EmailPage extends StatefulWidget {
  @override
  _EmailPageState createState() => _EmailPageState();
}

class _EmailPageState extends State<EmailPage> {
  String email1, password1, username;

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController usernamecontroller = TextEditingController();

  Future<void> _sign() async {
    User firebaseUser;

    await _firebaseAuth
        .createUserWithEmailAndPassword(
            email: emailcontroller.text.trim(),
            password: passwordcontroller.text.trim())
        .then((auth) {
      firebaseUser = auth.user;
    }).catchError((error) {
      Navigator.pop(context);
      showDialog(
          context: context,
          builder: (c) {
            return LoadingAlertDialog(message: error.message.toString());
          });
    });
    if (firebaseUser != null) {
      uploaddata(firebaseUser).then((value) {
        Route route = MaterialPageRoute(builder: (c) => HomeScreen());
        Navigator.pushReplacement(context, route);
      });
    }
  }

  uploaddata(User user) async {
    FirebaseFirestore.instance.collection('Users').doc(user.uid).set({
      "uid": user.uid,
      "email": user.email,
      "username": usernamecontroller.text.trim(),
    });
    await SharedPrefernces.sharedPreferences.setString("uid", user.uid);
    await SharedPrefernces.sharedPreferences.setString("email", user.email);
    await SharedPrefernces.sharedPreferences
        .setString("username", usernamecontroller.text.trim());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Container(
              height: 300,
              width: 200,
              child: Lottie.network(
                  'https://assets5.lottiefiles.com/private_files/lf30_o7BLXG.json'),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30.0, right: 30.0),
              child: TextField(
                cursorColor: Colors.yellow[900],
                controller: usernamecontroller,
                style: TextStyle(color: Colors.white),
                onChanged: (value) {
                  username = value;
                },
                decoration: InputDecoration(
                  hintText: ('Usename'),
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
                controller: emailcontroller,
                style: TextStyle(color: Colors.white),
                onChanged: (value) {
                  email1 = value;
                },
                decoration: InputDecoration(
                  hintText: ('Email'),
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
                style: TextStyle(color: Colors.white),
                obscureText: true,
                onChanged: (value) {
                  password1 = value;
                },
                decoration: InputDecoration(
                  hintText: ('Password'),
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
              height: 50,
            ),
            GestureDetector(
              onTap: () async {
                emailcontroller.text.isEmpty && passwordcontroller.text.isEmpty
                    ? showAlertDialog(context)
                    : _sign();
              },
              child: Container(
                height: 40,
                width: 150,
                decoration: BoxDecoration(
                  color: Colors.yellow[900],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                    child: Text(
                  'SIGN UP',
                  style: TextStyle(
                      color: Colors.white,
                      letterSpacing: 2,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                )),
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
      Navigator.pushReplacement(context,
          PageTransition(child: EmailPage(), type: PageTransitionType.fade));
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
