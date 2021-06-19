// import 'package:e_shop/Widgets/loadingWidget.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// class LoadingAlertDialog extends StatelessWidget
// {
//   final String message;
//   const LoadingAlertDialog({Key key, this.message}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context)
//   {
//     return AlertDialog(
//       key: key,
//       content: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: <Widget>[
//           CircularProgressIndicator(
//             valueColor: new AlwaysStoppedAnimation<Color>(Colors.green),
//           ),
//           SizedBox(
//             height: 10,
//           ),
//           Text('Authenticating..Please wait...'),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



class LoadingAlertDialog extends StatelessWidget {

  final String message;

  LoadingAlertDialog({this.message,});


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
              Center(
                child: Text(
                  message,
                  style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.black,fontFamily: "Poppins"
                  ),
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
              backgroundImage: AssetImage("assets/gifs/loading.gif"),
            )
        )
      ],
    );
  }
}



