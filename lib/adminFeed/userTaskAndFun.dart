import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop/Config/config.dart';
import 'package:e_shop/Widgets/loadingWidget.dart';
import 'package:e_shop/Widgets/myDrawer.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

double width;

class UserTaskAndFunPageHomeScreen extends StatefulWidget {
  @override
  _UserTaskAndFunPageHomeScreen createState() => _UserTaskAndFunPageHomeScreen();
}

class _UserTaskAndFunPageHomeScreen extends State<UserTaskAndFunPageHomeScreen> {


  int creditPoints;
  int numberToBeAdded;
  var random = new Random();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readData(EcommerceApp.sharedPreferences.getString(EcommerceApp.userUID));
    checkDialogIntroShown();
  }

  Future checkDialogIntroShown() async {
    SharedPreferences userTaskAndFunDialogIntro = await SharedPreferences.getInstance();
    bool _seen = (userTaskAndFunDialogIntro.getBool('seenUserTaskAndFunDialogIntro') ?? false);

    if (_seen) {


    }
    else{
      await userTaskAndFunDialogIntro.setBool('seenUserTaskAndFunDialogIntro', true);
      //showAlertDialog(context);
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => CustomAlertDialog(
          title: "Hey ${EcommerceApp.sharedPreferences.getString(EcommerceApp.userName)} !",
          desc: "Welcome to Task & Fun. Here you will find all the tasks assigned. Just click on any post, complete the fun task and earn CryptoV coins as a reward.",
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
  //     content: Text("Here you will find all the tasks assigned. After clicking on any post you will be redirected to a webpage where you have to fill a questionnaire and after successful submit CryptoV coins will be credited to your wallet",style: TextStyle(fontFamily: "Poppins"),),
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



  Future readData(String fUser) async
  {
    Firestore.instance.collection("rewards").document(fUser).get().then((dataSnapshot)
    async {
      setState(() {
        creditPoints = dataSnapshot.data["credits"];
        if(creditPoints>1000){
          setState(() {
            creditPoints=0;
          });
        }
        numberToBeAdded = random.nextInt(15) + 5;
        print(numberToBeAdded);
        creditPoints  = creditPoints + numberToBeAdded;
      });
    });
  }

  Future updateCreditPoints(String fUser) async
  {
    Firestore.instance.collection("rewards").document(fUser).updateData({
      "credits": creditPoints
    });
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      drawer: MyDrawer(),
        appBar: AppBar(
          centerTitle: true,
          title: Text("Task & Fun",style: TextStyle(fontFamily: "Poppins",            fontWeight: FontWeight.bold
          ),),
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

            return ListView(
              children: snapshot.data.documents.map((document) {
                return InkWell(
                  onTap: () async{
                    updateCreditPoints(EcommerceApp.sharedPreferences.getString(EcommerceApp.userUID));
                    Fluttertoast.showToast(msg: "Redirecting to your task");
                    await launch(document['url']);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.black38,
                        border: Border.all(
                          color: Colors.blueGrey,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(10))
                    ),
                    padding: EdgeInsets.all(10.0),
                    margin: EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        Text(document['title'],style: TextStyle(fontFamily: "Poppins",fontSize: 20.0),),
                        SizedBox(height: 10.0,),
                        Text(document['description'],style: TextStyle(fontFamily: "Poppins",fontSize: 16.0,color: Colors.grey[400]),),
                        SizedBox(height: 10.0,),
                        document['thumbnailUrl']==null?
                        circularProgress():
                        Container(
                          child: CachedNetworkImage(
                            imageUrl: document['thumbnailUrl'],
                            placeholder: (context, url) => circularProgress(),
                            errorWidget: (context, url, error) => Icon(Icons.error),
                          ),
                        ),
                        SizedBox(height: 10.0,),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Text(
                            "Click Here",
                            style: TextStyle(
                              color: Colors.blue,
                              fontFamily: "Poppins",
                              decoration: TextDecoration.underline,
                              fontStyle: FontStyle.italic
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }).toList(),
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
