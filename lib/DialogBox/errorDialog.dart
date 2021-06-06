import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ErrorAlertDialog extends StatelessWidget
{
  final String message;
  const ErrorAlertDialog({Key key, this.message}) : super(key: key);


  @override
  Widget build(BuildContext context)
  {
    return AlertDialog(

      key: key,
      content: Text(message,style: TextStyle(fontFamily: "Poppins"),),
      actions: <Widget>[
        RaisedButton(onPressed: ()
        {
          Navigator.pop(context);
        },
          color: Colors.green,
          child: Text("OK",style: TextStyle(fontFamily: "Poppins"),),
        )
      ],
    );
  }
}
