import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop/Config/config.dart';
import 'package:e_shop/Widgets/loadingWidget.dart';
import 'package:e_shop/Widgets/myDrawer.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class UserNotificationsHomePage extends StatefulWidget {
  @override
  _UserNotificationsHomePageState createState() => _UserNotificationsHomePageState();
}

class _UserNotificationsHomePageState extends State<UserNotificationsHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: MyDrawer(),
        appBar: AppBar(
          centerTitle: true,
          title: Text("Notifications",style: TextStyle(fontFamily: "Poppins",
              fontWeight: FontWeight.bold
          ),),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(16.0)),
          ),
        ),
        body: StreamBuilder(
          stream: Firestore.instance.collection("notifications").document(EcommerceApp.sharedPreferences.getString(EcommerceApp.userUID)).collection("notificationData").orderBy("publishedDate", descending: true).snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: circularProgress(),
              );
            }

            return Scrollbar(
              showTrackOnHover: true,
              child: ListView(
                children: snapshot.data.documents.map((document) {
                  return Container(
                    color: Colors.black38,
                    padding: EdgeInsets.all(10.0),
                    margin: EdgeInsets.fromLTRB(10.0,5.0,10.0,5.0),
                    child: Column(
                      children: [
                        Text(document['message'],style: TextStyle(fontFamily: "Poppins",fontSize: 17.0),),
                        SizedBox(height: 5.0,),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Text(
                            document['publishedDate'].toDate().toString(),
                              style: TextStyle(fontFamily: "Poppins",fontSize: 13.0,color: Colors.grey),
                          ),
                        )
                      ],
                    ),
                  );
                }).toList(),
              ),
            );
          },
        ));
  }
}
