import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// class ErrorAlertDialog extends StatelessWidget
// {
//   final String message;
//   const ErrorAlertDialog({Key key, this.message}) : super(key: key);
//
//
//   @override
//   Widget build(BuildContext context)
//   {
//     return AlertDialog(
//
//       key: key,
//       content: Text(message,style: TextStyle(fontFamily: "Poppins"),),
//       actions: <Widget>[
//         RaisedButton(onPressed: ()
//         {
//           Navigator.pop(context);
//         },
//           color: Colors.green,
//           child: Text("OK",style: TextStyle(fontFamily: "Poppins"),),
//         )
//       ],
//     );
//   }
// }


class ErrorAlertDialog extends StatelessWidget {

  final String message;

  ErrorAlertDialog({this.message,});


  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16)
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }

  dialogContent(BuildContext context){
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.only(
              top: 100.0,
              bottom: 16.0,
              left: 16.0,
              right: 16.0
          ),
          margin: EdgeInsets.only(
              top: 16.0
          ),
          decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(17),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10.0,
                  offset: Offset(0.0,10.0),
                )
              ]
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Alert!",
                style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,fontFamily: "Poppins"
                ),
              ),
              SizedBox(height: 15.0,),
              Text(
                message,
                style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.black,fontFamily: "Poppins"
                ),
              ),
              SizedBox(height: 24.0,),
              Align(
                alignment: Alignment.bottomRight,
                child: FlatButton(
                  color: Colors.green,
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  child: Text("Okay",style: TextStyle(color: Colors.white,fontFamily: "Poppins"),),
                ),
              ),


            ],
          ),
        ),
        Positioned(
            top: 0.0,
            left: 16.0,
            right: 16.0,
            child: CircleAvatar(
              backgroundColor: Colors.white,
              radius: 50.0,
              backgroundImage: AssetImage("assets/gifs/alert.gif"),
            )
        )
      ],
    );
  }
}


