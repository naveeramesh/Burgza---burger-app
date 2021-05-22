import 'package:burgza/Pages/Email.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';



class LoadingAlertDialog extends StatelessWidget {


  final String message;

  const LoadingAlertDialog({Key key, this.message}) : super(key: key);

  

  @override
  Widget build(BuildContext context) {
    return AlertDialog(

      key: key,
      content: Text(message),
      actions:<Widget> [
        RaisedButton(
          onPressed: (){
            Route route = MaterialPageRoute(builder: (c) => EmailPage());
          Navigator.pushReplacement(context, route);
          },
         
          child: Center(child: Text('OK'),),
        )
        
      ],
      
    );
  }
}