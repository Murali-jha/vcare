import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop/Admin/adminOrderCard.dart';
import 'package:e_shop/Config/config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../Widgets/loadingWidget.dart';
import '../Widgets/orderCard.dart';

class AdminShiftOrders extends StatefulWidget {
  @override
  _MyOrdersState createState() => _MyOrdersState();
}


class _MyOrdersState extends State<AdminShiftOrders> {

  int lengthOfDocuments = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    countNumberOfAppointments();
  }


  Future countNumberOfAppointments() async{
    final QuerySnapshot qSnap = await Firestore.instance.collection('orders').getDocuments();
    final int documents = qSnap.documents.length;
    setState((){
      lengthOfDocuments = documents;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            Center(child: Text(lengthOfDocuments.toString(),style: TextStyle(fontSize: 18.0,fontFamily: "Poppins",color: Colors.green,fontWeight: FontWeight.bold),))
            ,SizedBox(width: 15.0,)
          ],
          iconTheme: IconThemeData(color: Colors.white),
          centerTitle: true,
          title: Text("Appointment Requests", style: TextStyle(color: Colors.white,fontFamily: "Poppins"),),

        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: Firestore.instance
              .collection("orders")
          .orderBy("publishedDate")
              .snapshots(),
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
                        ? AdminOrderCard(
                      itemCount: snap.data.documents.length,
                      data: snap.data.documents,
                      orderID: snapshot.data.documents[index].documentID,
                      orderBy: snapshot.data.documents[index].data["orderBy"],
                      addressID: snapshot.data.documents[index].data["addressID"],
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
