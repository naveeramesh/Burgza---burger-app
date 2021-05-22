import 'package:burgza/Payment/Bill.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:burgza/Pages/Favourites.dart';

class NewScreen extends StatefulWidget {
  final QueryDocumentSnapshot snapshots;

  const NewScreen({Key key, this.snapshots}) : super(key: key);

  @override
  _NewScreenState createState() => _NewScreenState();
}

List _toppingslist = [];

class _NewScreenState extends State<NewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: BackButton(
          color: Colors.white,
        ),
        actions: [
          IconButton(
              icon:
                  Icon(Icons.favorite_outlined, size: 20, color: Colors.white),
              onPressed: () {
                Navigator.push(
                    context,
                    PageTransition(
                      child: Favourites(),
                      type: PageTransitionType.rightToLeftWithFade,
                    ));
              }),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text(
                      widget.snapshots['title'].toUpperCase(),
                      style: TextStyle(
                        color: Colors.white,
                        letterSpacing: 2,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Row(
                      children: [
                        Icon(Icons.star_outlined, color: Colors.yellowAccent),
                        Icon(Icons.star_outlined, color: Colors.yellowAccent),
                        Icon(Icons.star_outlined, color: Colors.yellowAccent),
                        Icon(Icons.star_outlined, color: Colors.yellowAccent),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Container(
                      constraints: BoxConstraints(
                        maxWidth: 400,
                      ),
                      child: Text(
                        widget.snapshots['description'],
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                height: 280,
                width: 400,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: NetworkImage(
                      widget.snapshots['image'],
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Text(
                      'TOPPINGS',
                      style: GoogleFonts.lato(
                        textStyle:
                            TextStyle(color: Colors.white, letterSpacing: 2),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 220.0),
                    child: Container(
                      height: 40,
                      width: 80,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                          child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            FontAwesomeIcons.rupeeSign,
                            size: 15,
                            color: Colors.white,
                          ),
                          Text(
                            widget.snapshots['price'],
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ],
                      )),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 50,
                width: 600,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: GestureDetector(
                        onTap: () {
                          _toppingslist.add('pasta');
                          FirebaseFirestore.instance
                              .collection('Hot')
                              .doc(widget.snapshots['productid'])
                              .collection('toppings')
                              .add({
                            'topping': 'bacon',
                          }).whenComplete(() => {
                                    print(_toppingslist),
                                    Fluttertoast.showToast(
                                      msg: 'Added',
                                      gravity: ToastGravity.BOTTOM,
                                      backgroundColor: Colors.yellow[900],
                                      textColor: Colors.white,
                                    ),
                                  });
                        },
                        child: Container(
                          height: 30,
                          width: 60,
                          decoration: BoxDecoration(
                            color: Colors.grey[700],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                              child: Text('BACON',
                                  style: TextStyle(color: Colors.white))),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: GestureDetector(
                        onTap: () {
                          _toppingslist.add('pasta');
                          FirebaseFirestore.instance
                              .collection('Hot')
                              .doc(widget.snapshots['productid'])
                              .collection('toppings')
                              .add({
                            'topping': 'onions',
                          }).whenComplete(() => {
                                    print(_toppingslist),
                                    Fluttertoast.showToast(
                                      msg: 'Added',
                                      gravity: ToastGravity.BOTTOM,
                                      backgroundColor: Colors.yellow[900],
                                      textColor: Colors.white,
                                    ),
                                  });
                        },
                        child: Container(
                            height: 30,
                            width: 60,
                            decoration: BoxDecoration(
                              color: Colors.grey[700],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                                child: Text('ONIONS',
                                    style: TextStyle(color: Colors.white)))),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: GestureDetector(
                        onTap: () {
                          _toppingslist.add('pasta');
                          FirebaseFirestore.instance
                              .collection('Hot')
                              .doc(widget.snapshots['productid'])
                              .collection('toppings')
                              .add({
                            'topping': 'pasta',
                          }).whenComplete(() => {
                                    print(_toppingslist),
                                    Fluttertoast.showToast(
                                      msg: 'Added',
                                      gravity: ToastGravity.BOTTOM,
                                      backgroundColor: Colors.yellow[900],
                                      textColor: Colors.white,
                                    ),
                                  });
                        },
                        child: Container(
                            height: 30,
                            width: 60,
                            decoration: BoxDecoration(
                              color: Colors.grey[700],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                                child: Text('PASTA',
                                    style: TextStyle(color: Colors.white)))),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: GestureDetector(
                        onTap: () {
                          _toppingslist.add('spices');
                          FirebaseFirestore.instance
                              .collection('Hot')
                              .doc(widget.snapshots['productid'])
                              .collection('toppings')
                              .add({
                            'topping': 'spices',
                          }).whenComplete(() => {
                                    Fluttertoast.showToast(
                                      msg: 'Added',
                                      gravity: ToastGravity.BOTTOM,
                                      backgroundColor: Colors.yellow[900],
                                      textColor: Colors.white,
                                    ),
                                  });
                        },
                        child: Container(
                            height: 30,
                            width: 60,
                            decoration: BoxDecoration(
                              color: Colors.grey[700],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                                child: Text('SPICES',
                                    style: TextStyle(color: Colors.white)))),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: GestureDetector(
                        onTap: () {
                          _toppingslist.add('cheese');
                          FirebaseFirestore.instance
                              .collection('Hot')
                              .doc(widget.snapshots['productid'])
                              .collection('toppings')
                              .add({
                            'topping': 'cheese',
                          }).whenComplete(() => {
                                    Fluttertoast.showToast(
                                      msg: 'Added',
                                      gravity: ToastGravity.BOTTOM,
                                      backgroundColor: Colors.yellow[900],
                                      textColor: Colors.white,
                                    ),
                                  });
                        },
                        child: Container(
                            height: 30,
                            width: 60,
                            decoration: BoxDecoration(
                              color: Colors.grey[700],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                                child: Text('CHEESE',
                                    style: TextStyle(color: Colors.white)))),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: GestureDetector(
                        onTap: () {
                          _toppingslist.add('nuts');
                          FirebaseFirestore.instance
                              .collection('Hot')
                              .doc(widget.snapshots['productid'])
                              .collection('toppings')
                              .add({
                            'topping': 'nuts',
                          }).whenComplete(() => {
                                    Fluttertoast.showToast(
                                      msg: 'Added',
                                      gravity: ToastGravity.BOTTOM,
                                      backgroundColor: Colors.yellow[900],
                                      textColor: Colors.white,
                                    ),
                                  });
                        },
                        child: Container(
                            height: 30,
                            width: 60,
                            decoration: BoxDecoration(
                              color: Colors.grey[700],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                                child: Text('NUTS',
                                    style: TextStyle(color: Colors.white)))),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 400,
                width: 420,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.grey[800],
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 80,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            PageTransition(
                                child: Billing(),
                                type: PageTransitionType.fade));
                      },
                      child: Container(
                        height: 50,
                        width: 300,
                        decoration: BoxDecoration(
                          color: Colors.yellow[700],
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Center(
                            child: Text(
                          'BUY NOW',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        )),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () async {
                        await FirebaseFirestore.instance
                            .collection('Cart')
                            .doc(widget.snapshots['productid'])
                            .set({
                          'title': widget.snapshots['title'],
                          'image': widget.snapshots['image'],
                          'price': widget.snapshots['price'],
                          'description': widget.snapshots['description'],
                          'productid': widget.snapshots['productid'],
                        }).whenComplete(() {
                          Fluttertoast.showToast(
                              msg: 'Added to Cart',
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              backgroundColor: Colors.yellow[900],
                              textColor: Colors.white,
                              fontSize: 16.0);
                        });
                      },
                      child: Container(
                        height: 50,
                        width: 300,
                        decoration: BoxDecoration(
                          color: Colors.yellow[700],
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Center(
                            child: Text(
                          'ADD TO CART',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        )),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
