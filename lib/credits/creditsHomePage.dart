import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop/Config/config.dart';
import 'package:e_shop/Widgets/loadingWidget.dart';
import 'package:e_shop/Widgets/myDrawer.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreditsHomePage extends StatefulWidget {
  @override
  _CreditsHomePageState createState() => _CreditsHomePageState();
}

class _CreditsHomePageState extends State<CreditsHomePage> {


  int creditPoints;
  int remaining;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readData(EcommerceApp.sharedPreferences.getString(EcommerceApp.userUID));
    checkDialogIntroShown();
  }

  Future checkDialogIntroShown() async {
    SharedPreferences userCryptoVIntroDialog = await SharedPreferences.getInstance();
    bool _seen = (userCryptoVIntroDialog.getBool('seenUserCryptoVIntroDialog') ?? false);

    if (_seen) {


    }
    else{
      await userCryptoVIntroDialog.setBool('seenUserCryptoVIntroDialog', true);
      //showAlertDialog(context);
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => CustomAlertDialog(
          title: "Hey ${EcommerceApp.sharedPreferences.getString(EcommerceApp.userName)} !",
          desc: "Here you can see number of CryptoV coins in your wallet and number of coins you need to unlock the rewards. Initially as joining bonus you received 100 CryptoV coins!",
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
  //     content: Text("Here you can see number of CryptoV coins in your wallet and number of coins you need to unlock the rewards",style: TextStyle(fontFamily: "Poppins"),),
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
        remaining = 1000 - creditPoints;
      });
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(16.0)),
        ),
        centerTitle: true,
        title: Text(
          "CryptoV Coins",
          style: TextStyle(
            fontFamily: "Poppins",
              fontWeight: FontWeight.bold

          ),
        ),
        actions: [
          IconButton(
              onPressed: (){

              },
              icon: Icon(Icons.help)
          )
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(30.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Colors.black38,
                      border: Border.all(
                        color: Colors.blue,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(20))
                  ),
                  padding: EdgeInsets.all(10.0),
                  margin: EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Center(child: Image.asset("images/CryptoVLogo.png",width: 150.0,)),
                      Text("CryptoV coins in your Wallet",style: TextStyle(fontFamily: "Poppins",fontSize: 18.0),),
                      creditPoints==null?
                      circularProgress():
                      Text(creditPoints.toString(),style: TextStyle(fontFamily: "Poppins",fontSize: 70.0,color: Colors.green),),
                    ],
                  ),
                ),

                SizedBox(height: 30.0,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(child: Text("Number of CryptoV coins you need to unlock reward :",style: TextStyle(fontFamily: "Poppins",fontSize: 20.0),)),
                    creditPoints==null?
                    circularProgress():
                    Center(child: Text(remaining.toString(),style: TextStyle(fontFamily: "Poppins",fontSize: 50.0,color: Colors.red),)),
                  ],
                ),

              ],
            ),
          ),
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
