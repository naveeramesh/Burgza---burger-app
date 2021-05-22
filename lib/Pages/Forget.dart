import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Forget extends StatefulWidget {
  @override
  _ForgetState createState() => _ForgetState();
}

class _ForgetState extends State<Forget> {
  String email5 = "";
  TextEditingController emailcontroller = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('FORGET PASSWORD',
            style: TextStyle(color: Colors.white, fontSize: 20)),
        actions: [
          IconButton(
              icon: Icon(
                Icons.lock,
                color: Colors.white,
              ),
              onPressed: null)
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 250.0, left: 30, right: 30),
            child: Text(
              'Enter your mail id',
              style: TextStyle(color: Colors.white, fontSize: 15),
            ),
          ),
          SizedBox(
            height: 50,
          ),
          Container(
              height: 60,
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                child: TextField(
                  keyboardType: TextInputType.text,
                  cursorColor: Colors.yellow[900],
                  controller: emailcontroller,
                  style: TextStyle(color: Colors.black),
                  onChanged: (value) {
                    email5 = value;
                  },
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Color(0xFFF2F2F2),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                      borderSide: BorderSide(width: 1, color: Colors.red),
                    ),
                    hintText: "Email :",
                    hintStyle: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                ),
              )),
          SizedBox(
            height: 40,
          ),
          GestureDetector(
            onTap: () {
              mail();
            },
            child: Container(
              height: 50,
              width: 200,
              decoration: BoxDecoration(
                color: Colors.yellow[700],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Text(
                  'SEND LINK ',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    letterSpacing: 1,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  mail() {
    FirebaseAuth.instance.sendPasswordResetEmail(email: email5).whenComplete(() {
      Fluttertoast.showToast(
        msg: 'Sent Successfully',
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.yellow[900],
        textColor: Colors.white,
      );
    });
  }
}
