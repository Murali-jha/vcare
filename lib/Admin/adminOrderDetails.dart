import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop/Address/address.dart';
import 'package:e_shop/Admin/uploadItems.dart';
import 'package:e_shop/Config/config.dart';
import 'package:e_shop/Widgets/loadingWidget.dart';
import 'package:e_shop/Widgets/orderCard.dart';
import 'package:e_shop/Models/address.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';


String getOrderId="";
class AdminOrderDetails extends StatelessWidget
{
  final String orderID;
  final String orderBy;
  final String addressID;

  AdminOrderDetails({Key key, this.orderID, this.orderBy, this.addressID,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    getOrderId = orderID;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: FutureBuilder<DocumentSnapshot>(
            future: EcommerceApp.firestore
                .collection(EcommerceApp.collectionOrders)
                .document(getOrderId)
                .get(),
            builder: (c, snapshot)
            {
              Map dataMap;
              if(snapshot.hasData)
              {
                dataMap = snapshot.data.data;
              }
              return snapshot.hasData
                  ? Container(
                child: Column(
                  children: [
                    AdminStatusBanner(status: dataMap[EcommerceApp.isSuccess],),
                    SizedBox(height: 10.0,),
                    Padding(
                      padding: EdgeInsets.all(4.0),
                      child: Text("Booking ID: " + getOrderId,

                     style: TextStyle(fontFamily: "Poppins"), ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(4.0),
                      child: Text(
                        "Booked at: " + DateFormat("dd MMMM, yyyy - hh:mm aa")
                            .format(DateTime.fromMillisecondsSinceEpoch(int.parse(dataMap["orderTime"]))),
                        style: TextStyle(color: Colors.grey, fontSize: 16.0,fontFamily: "Poppins"),
                      ),
                    ),
                    Divider(height: 2.0,color: Colors.green,),
                    FutureBuilder<QuerySnapshot>(
                      future: EcommerceApp.firestore
                          .collection("items")
                          .where("shortInfo", whereIn: dataMap[EcommerceApp.productID])
                          .getDocuments(),
                      builder: (c, dataSnapshot)
                      {
                        return dataSnapshot.hasData
                            ? OrderCard(
                          itemCount: dataSnapshot.data.documents.length,
                          data: dataSnapshot.data.documents,
                        )
                            : Center(child: circularProgress(),);
                      },
                    ),
                    Divider(height: 2.0,color: Colors.green,),
                    FutureBuilder<DocumentSnapshot>(
                      future: EcommerceApp.firestore
                          .collection(EcommerceApp.collectionUser)
                          .document(orderBy)
                          .collection(EcommerceApp.subCollectionAddress)
                          .document(addressID)
                          .get(),
                      builder: (c, snap)
                      {
                        return snap.hasData
                            ? AdminShippingDetails(model: AddressModel.fromJson(snap.data.data),)
                            : Center(child: circularProgress(),);
                      },
                    ),
                  ],
                ),
              )
                  : Center(child: circularProgress(),);
            },
          ),
        ),
      ),
    );
  }
}

class AdminStatusBanner extends StatelessWidget {
  final bool status;

  AdminStatusBanner({Key key, this.status}) : super(key: key);

  @override
  Widget build(BuildContext context)
  {
    String msg;
    IconData iconData;

    status ? iconData = Icons.done : iconData = Icons.cancel;
    status ? msg = "Successful" : msg = "UnSuccessful";

    return Container(
      color: Colors.green,
      height: 40.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Meeting Status : " + msg + " ?",
            style: TextStyle(color: Colors.white),
          ),
          SizedBox(width: 5.0,),
          CircleAvatar(
            radius: 8.0,
            backgroundColor: Colors.blue,
            child: Center(
              child: Icon(
                iconData,
                color: Colors.white,
                size: 14.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}



class AdminShippingDetails extends StatelessWidget {
  final AddressModel model;

  AdminShippingDetails({Key key, this.model}) : super(key: key);

  @override
  Widget build(BuildContext context)
  {
    double screenWidth = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20.0,),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0,),
          child: Center(
            child: Text(
              "Booking Details:",
              style: TextStyle(color: Colors.white, fontSize: 20.0,fontWeight: FontWeight.bold,fontFamily: "Poppins"),
            ),
          ),
        ),

        Container(
          padding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 15.0),
          width: screenWidth,
          child: Table(
            children: [

              TableRow(
                  children: [
                    KeyText(msg: "Name :",),
                    Text(model.name,style: TextStyle(fontFamily: "Poppins"),),
                  ]
              ),

              TableRow(
                  children: [
                    KeyText(msg: "Phone Number :",),
                    SelectableText(model.phoneNumber,style: TextStyle(fontFamily: "Poppins"),),
                  ]
              ),

              TableRow(
                  children: [
                    KeyText(msg: "Email Id :",),
                    SelectableText(model.flatNumber,style: TextStyle(fontFamily: "Poppins"),),
                  ]
              ),

              TableRow(
                  children: [
                    KeyText(msg: "Semester:",),
                    Text(model.semester,style: TextStyle(fontFamily: "Poppins"),),
                  ]
              ),

              TableRow(
                  children: [
                    KeyText(msg: "Preferred Date:",),
                    Text(model.date,style: TextStyle(fontFamily: "Poppins"),),
                  ]
              ),

              TableRow(
                  children: [
                    KeyText(msg: "Preferred Time :",),
                    Text(model.city,style: TextStyle(fontFamily: "Poppins"),),
                  ]
              ),

              TableRow(
                  children: [
                    KeyText(msg: "Message :",),
                    Text(model.state,style: TextStyle(fontFamily: "Poppins"),),
                  ]
              ),

              TableRow(
                  children: [
                    KeyText(msg: "Pin Code :",),
                    Text(model.pincode,style: TextStyle(fontFamily: "Poppins"),),
                  ]
              ),

            ],
          ),
        ),

        Padding(
          padding: EdgeInsets.all(10.0),
          child: Center(
            child: InkWell(
              onTap: ()
              {
                confirmParcelShifted(context, getOrderId);
              },
              child: Container(
                color: Colors.green,
                width: MediaQuery.of(context).size.width - 40.0,
                height: 50.0,
                child: Center(
                  child: Text(
                    "Confirm || Meeting Completed",
                    style: TextStyle(color: Colors.white, fontSize: 15.0,fontFamily: "Poppins"),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  confirmParcelShifted(BuildContext context, String mOrderId)
  {
    EcommerceApp.firestore
        .collection(EcommerceApp.collectionOrders)
        .document(mOrderId)
        .delete();


    getOrderId = "";

    Route route = MaterialPageRoute(builder: (c) => UploadPage());
    Navigator.of(context).pushAndRemoveUntil(route, (Route<dynamic> route) => false);

    Fluttertoast.showToast(msg: "Meeting has been completed. Confirmed.");
  }
}


