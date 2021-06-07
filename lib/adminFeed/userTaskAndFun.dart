import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop/Models/item.dart';
import 'package:e_shop/Widgets/loadingWidget.dart';
import 'package:e_shop/Widgets/searchBox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';

double width;

class UserTaskAndFunPageHomeScreen extends StatefulWidget {
  @override
  _UserTaskAndFunPageHomeScreen createState() => _UserTaskAndFunPageHomeScreen();
}

class _UserTaskAndFunPageHomeScreen extends State<UserTaskAndFunPageHomeScreen> {
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          title: Text("Task & Fun"),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(16.0)),
          ),
        ),
        body: StreamBuilder(
          stream: Firestore.instance.collection("taskAndFun").orderBy("publishedDate", descending: true).snapshots(),
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
                  return InkWell(
                    onTap: () async{
                      Fluttertoast.showToast(msg: "Redirecting to your task");
                      await launch(document['url']);
                    },
                    child: Container(
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
                          Text(document['title'],style: TextStyle(fontFamily: "Poppins",fontSize: 20.0),),
                          SizedBox(height: 10.0,),
                          Text(document['description'],style: TextStyle(fontFamily: "Poppins",fontSize: 16.0,color: Colors.grey),),
                          SizedBox(height: 10.0,),
                          document['thumbnailUrl']==null?
                          circularProgress():
                          Image.network(
                              document['thumbnailUrl']
                          )
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            );
          },
        ));
  }
}
