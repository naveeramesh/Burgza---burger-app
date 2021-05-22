import 'package:burgza/Payment/Bill.dart';
import 'package:burgza/Services/location.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class Maps extends StatefulWidget {
  @override
  _MapsState createState() => _MapsState();
}

class _MapsState extends State<Maps> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(children: [
          Provider.of<GenerateMaps>(context, listen: false).fetchMaps(),
          Positioned(
              top: 50.0,
              child: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios_outlined,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          child: Billing(), type: PageTransitionType.fade));
                },
              )),
        ]),
      ),
    );
  }
}
