import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop/Config/config.dart';
import 'package:e_shop/Widgets/loadingWidget.dart';
import 'package:e_shop/Widgets/myDrawer.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserNotificationsHomePage extends StatefulWidget {
  @override
  _UserNotificationsHomePageState createState() => _UserNotificationsHomePageState();
}

class _UserNotificationsHomePageState extends State<UserNotificationsHomePage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkDialogIntroShown();
  }

  Future checkDialogIntroShown() async {
    SharedPreferences userNotificationsHomePageDialog = await SharedPreferences.getInstance();
    bool _seen = (userNotificationsHomePageDialog.getBool('seenUserNotificationsHomePageDialog') ?? false);

    if (_seen) {


    }
    else{
      await userNotificationsHomePageDialog.setBool('seenUserNotificationsHomePageDialog', true);
      //showAlertDialog(context);
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => CustomAlertDialog(
          title: "Hey ${EcommerceApp.sharedPreferences.getString(EcommerceApp.userName)} !",
          desc: "Here you will find all the notifications and reminders. ",
        ),
      );
    }
  }


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
