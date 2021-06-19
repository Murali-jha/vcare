import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop/Widgets/myDrawer.dart';
import 'package:flutter/material.dart';
import 'package:e_shop/Config/config.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Widgets/loadingWidget.dart';
import '../Widgets/orderCard.dart';

class MyOrders extends StatefulWidget {
  @override
  _MyOrdersState createState() => _MyOrdersState();
}



class _MyOrdersState extends State<MyOrders> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkDialogIntroShown();
  }

  Future checkDialogIntroShown() async {
    SharedPreferences userAppointmentsFixedDialog = await SharedPreferences.getInstance();
    bool _seen = (userAppointmentsFixedDialog.getBool('seenUserAppointmentsFixedDialog') ?? false);

    if (_seen) {


    }
    else{
      await userAppointmentsFixedDialog.setBool('seenUserAppointmentsFixedDialog', true);
      //showAlertDialog(context);
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => CustomAlertDialog(
          title: "Hey ${EcommerceApp.sharedPreferences.getString(EcommerceApp.userName)} !",
          desc: "Here you will find all your appointment details. And You will receive meeting details through mail within 15 to 30 minutes of your booking",
        ),
      );
    }
  }

  // showAlertDialog(BuildContext context) {
  //
  //   // set up the button
  //   Widget okButton = FlatButton(
  //     child: Text("OK! that's cool",style: TextStyle(fontFamily: "Poppins"),),
  //     color: Colors.green,
  //     onPressed: () {
  //       Navigator.pop(context);
  //     },
  //   );
  //
  //
  //   // set up the AlertDialog
  //   AlertDialog alert = AlertDialog(
  //     shape: RoundedRectangleBorder(
  //       borderRadius: BorderRadius.circular(10),
  //     ),
  //     title: Text("Hey ${EcommerceApp.sharedPreferences.getString(EcommerceApp.userName)} !",style: TextStyle(fontFamily: "Poppins"),),
  //     content: Text("Here you will find all your appointment details. And You will receive meeting details through mail within 15 to 30 minutes of your booking",style: TextStyle(fontFamily: "Poppins"),),
  //     actions: [
  //       okButton,
  //     ],
  //   );
  //
  //   // show the dialog
  //   showDialog(
  //
  //     barrierDismissible: false,
  //     context: context,
  //     builder: (BuildContext context) {
  //       return alert;
  //     },
  //   );
  // }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Text(
              "My Appointments",
              style: TextStyle(
                  fontFamily: "Poppins",
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                  color: Colors.white),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(16.0)),
            ),
            centerTitle: true,
          ),
        body: StreamBuilder<QuerySnapshot>(
          stream: EcommerceApp.firestore
              .collection(EcommerceApp.collectionUser)
              .document(EcommerceApp.sharedPreferences.getString(EcommerceApp.userUID))
              .collection(EcommerceApp.collectionOrders).snapshots(),

          builder: (c, snapshot)
          {
            return snapshot.hasData
                ? ListView.builder(
              itemCount: snapshot.data.documents.length,
              itemBuilder: (c, index){
                return FutureBuilder<QuerySnapshot>(
                  future: Firestore.instance
                      .collection("items")
                      .where("shortInfo", whereIn: snapshot.data.documents[index].data[EcommerceApp.productID])
                      .getDocuments(),

                  builder: (c, snap)
                  {
                    return snap.hasData
                        ? OrderCard(
                      itemCount: snap.data.documents.length,
                      data: snap.data.documents,
                      orderID: snapshot.data.documents[index].documentID,
                    )
                        : Center(child: circularProgress(),);
                  },
                );
              },
            )
                : Center(child: circularProgress(),);
          },
        ),
      ),
    );
  }
}


class CustomAlertDialog extends StatelessWidget {

  final String title,desc;

  CustomAlertDialog({ this.title, this.desc,});


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
                title,
                style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,fontFamily: "Poppins"
                ),
              ),
              SizedBox(height: 24.0,),
              Text(
                desc,
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
                  child: Text("Confirm",style: TextStyle(color: Colors.white,fontFamily: "Poppins"),),
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
              backgroundImage: AssetImage("assets/gifs/7t4e.gif"),
            )
        )
      ],
    );
  }
}
