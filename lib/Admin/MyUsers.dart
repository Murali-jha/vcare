import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop/Widgets/loadingWidget.dart';
import 'package:flutter/material.dart';

class MyVCareUsers extends StatefulWidget {
  @override
  _MyVCareUsersState createState() => _MyVCareUsersState();
}

class _MyVCareUsersState extends State<MyVCareUsers> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("My Users", style: TextStyle(fontFamily: "Poppins",
              fontWeight: FontWeight.bold
          ),),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(16.0)),
          ),
        ),
        body: StreamBuilder(
          stream: Firestore.instance.collection("users").snapshots(),
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
                    decoration: BoxDecoration(
                        color: Colors.black38,
                        border: Border.all(
                          color: Colors.blueGrey,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(20))
                    ),
                    padding: EdgeInsets.all(10.0),
                    margin: EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        Center(
                          child: CircleAvatar(
                            radius: 50.0,
                            backgroundImage: document['url']==null?
                                NetworkImage("https://thumbs.dreamstime.com/b/no-user-profile-picture-24185395.jpg")
                                :NetworkImage(
                              document['url'],
                            ),
                          ),
                        ),
                        SizedBox(height: 20.0,),
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                                child: Text(
                                  "Name: ",
                                  style: TextStyle(
                                    fontFamily: "Poppins",
                                    color: Colors.green,
                                    fontSize: 18.0
                                  ),
                                )
                            ),
                            Expanded(
                              flex: 3,
                              child: SelectableText(document['name'],
                                style: TextStyle(fontFamily: "Poppins",fontSize: 18.0),),

                            )
                          ],
                        ),

                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                                child: Text(
                                  "Email:",
                                  style: TextStyle(
                                    fontFamily: "Poppins",
                                    color: Colors.green,
                                      fontSize: 18.0
                                  ),
                                )
                            ),
                            Expanded(
                              flex: 3,
                              child: SelectableText(document['email'],
                                style: TextStyle(fontFamily: "Poppins",fontSize: 18.0),),

                            )
                          ],
                        ),

                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                                child: Text(
                                  "UID:",
                                  style: TextStyle(
                                    fontFamily: "Poppins",
                                    color: Colors.green,
                                      fontSize: 18.0
                                  ),
                                )
                            ),
                            Expanded(
                              flex: 3,
                              child: SelectableText(document['uid'],
                                style: TextStyle(fontFamily: "Poppins",fontSize: 18.0),),

                            )
                          ],
                        ),


                      ],
                    ),
                  );
                }).toList(),
              ),
            );
          },
        )
    );
  }
}
