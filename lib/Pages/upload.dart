import 'dart:io';
import 'package:burgza/Pages/HomeScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:page_transition/page_transition.dart';
import 'package:path/path.dart' as Path;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';

class Upload extends StatefulWidget {
  @override
  _UploadState createState() => _UploadState();
}

class _UploadState extends State<Upload> {
  TextEditingController _titlecontroller = new TextEditingController();
  TextEditingController descriptioncontroller = new TextEditingController();
  TextEditingController pricecontroller = new TextEditingController();
  TextEditingController categoryidcontroller = new TextEditingController();
  TextEditingController productidcontroller = new TextEditingController();
  File _image;
  String _uploadedFileURL;

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
                  ],
                ),
              ),
              Container(
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: Text(
                            'UPLOAD THE ITEMS',
                            style: TextStyle(
                                color: Colors.yellow[700],
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Container(
                            height: 50,
                            width: 200,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: TextField(
                                keyboardType: TextInputType.text,
                                cursorColor: Colors.yellow[900],
                                controller: _titlecontroller,
                                style: TextStyle(color: Colors.black),
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Color(0xFFF2F2F2),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(4)),
                                    borderSide:
                                        BorderSide(width: 1, color: Colors.red),
                                  ),
                                  hintText: "Title :",
                                  hintStyle: TextStyle(
                                      fontSize: 16, color: Colors.black),
                                ),
                              ),
                            )),
                        Container(
                            height: 50,
                            width: 200,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: TextField(
                                keyboardType: TextInputType.number,
                                cursorColor: Colors.yellow[900],
                                controller: categoryidcontroller,
                                style: TextStyle(color: Colors.black),
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Color(0xFFF2F2F2),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(4)),
                                    borderSide:
                                        BorderSide(width: 1, color: Colors.red),
                                  ),
                                  hintText: "Category Id :",
                                  hintStyle: TextStyle(
                                      fontSize: 16, color: Colors.black),
                                ),
                              ),
                            )),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Container(
                            height: 50,
                            width: 200,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: TextField(
                                cursorColor: Colors.yellow[900],
                                controller: productidcontroller,
                                style: TextStyle(color: Colors.black),
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Color(0xFFF2F2F2),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(4)),
                                    borderSide:
                                        BorderSide(width: 1, color: Colors.red),
                                  ),
                                  hintText: "Product Id :",
                                  hintStyle: TextStyle(
                                      fontSize: 16, color: Colors.black),
                                ),
                              ),
                            )),
                        Container(
                            height: 50,
                            width: 200,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: TextField(
                                keyboardType: TextInputType.number,
                                cursorColor: Colors.yellow[900],
                                controller: pricecontroller,
                                style: TextStyle(color: Colors.black),
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Color(0xFFF2F2F2),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(4)),
                                    borderSide:
                                        BorderSide(width: 1, color: Colors.red),
                                  ),
                                  hintText: "Price :",
                                  hintStyle: TextStyle(
                                      fontSize: 16, color: Colors.black),
                                ),
                              ),
                            )),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                        height: 60,
                        child: Padding(
                          padding:
                              const EdgeInsets.only(left: 20.0, right: 20.0),
                          child: TextField(
                            keyboardType: TextInputType.text,
                            cursorColor: Colors.yellow[900],
                            controller: descriptioncontroller,
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Color(0xFFF2F2F2),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4)),
                                borderSide:
                                    BorderSide(width: 1, color: Colors.red),
                              ),
                              hintText: "Description :",
                              hintStyle:
                                  TextStyle(fontSize: 16, color: Colors.black),
                            ),
                          ),
                        )),
                    SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        takeimage(context);
                      },
                      child: Container(
                        height: 40,
                        width: 200,
                        decoration: BoxDecoration(
                          color: Colors.grey[800],
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                          child: Text('ADD IMAGE ',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 2)),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                        height: 200,
                        child: _image != null
                            ? Container(
                                height: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  image: DecorationImage(
                                    image: FileImage(_image),
                                    fit: BoxFit.cover,
                                  ),
                                ))
                            : Text('no image uploaded',
                                style: TextStyle(color: Colors.white))),
                    SizedBox(
                      height: 100,
                    ),
                    GestureDetector(
                      onTap: () {
                        uploadFile().whenComplete(() {
                          Fluttertoast.showToast(
                            msg: 'Image uploaded',
                            gravity: ToastGravity.BOTTOM,
                            backgroundColor: Colors.yellow[900],
                            textColor: Colors.white,
                          );
                        });
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
                            'UPLOAD IMAGE',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              letterSpacing: 1,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  FirebaseFirestore.instance
                      .collection('Hot')
                      .doc(productidcontroller.text.toString())
                      .set({
                    'image': _uploadedFileURL,
                    'title': _titlecontroller.text.toString(),
                    'description': descriptioncontroller.text.toString(),
                    'price': pricecontroller.text.trim(),
                    'categoryid': categoryidcontroller.text.trim(),
                    'productid': productidcontroller.text.toString(),
                  }).whenComplete(() {
                    Fluttertoast.showToast(
                      msg: 'Uploaded Successfully',
                      gravity: ToastGravity.BOTTOM,
                      backgroundColor: Colors.yellow[900],
                      textColor: Colors.white,
                    );
                  }).whenComplete(() {
                    Navigator.push(
                        context,
                        PageTransition(
                          child: HomeScreen(),
                          type: PageTransitionType.fade,
                        ));
                  });
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
                      'UPLOAD ',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        letterSpacing: 2,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  takeimage(context) {
    return showDialog(
        context: context,
        builder: (con) {
          return SimpleDialog(
            title: Text('Select Image'),
            children: [
              SimpleDialogOption(
                child: Text('Take a photo'),
                onPressed: _camera,
              ),
              SimpleDialogOption(
                child: Text('Select from gallery'),
                onPressed: gallery,
              ),
              SimpleDialogOption(
                  child: Text('Cancel'),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
            ],
          );
        });
  }

  _camera() async {
    Navigator.pop(context);
    await ImagePicker.pickImage(
            source: ImageSource.camera, maxHeight: 680.0, maxWidth: 970.0)
        .then((image) {
      setState(() {
        _image = image;
      });
    });
  }

  gallery() async {
    Navigator.pop(context);
    await ImagePicker.pickImage(
      source: ImageSource.gallery,
    ).then((image) {
      setState(() {
        _image = image;
      });
    });
  }

  Future uploadFile() async {
    Reference storageReference = FirebaseStorage.instance
        .ref()
        .child('chats/${Path.basename(_image.path)}}');
    UploadTask uploadTask = storageReference.putFile(_image);
    await uploadTask.whenComplete(() {
      print('File Uploaded');
      storageReference.getDownloadURL().then((fileURL) {
        setState(() {
          _uploadedFileURL = fileURL;
        });
      });
    });
  }
}
