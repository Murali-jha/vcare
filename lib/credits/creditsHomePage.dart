import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop/Config/config.dart';
import 'package:e_shop/Widgets/loadingWidget.dart';
import 'package:flutter/material.dart';

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
  }


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
      appBar: AppBar(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(16.0)),
        ),
        centerTitle: true,
        title: Text(
          "CryptoV Coins",
          style: TextStyle(
            fontFamily: "Poppins"
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(child: Center(child: Text("Number of CryptoV coins you need to unlock reward",style: TextStyle(fontFamily: "Poppins",fontSize: 20.0),))),
                    Icon(Icons.arrow_forward_ios_outlined,color: Colors.blue,),
                    creditPoints==null?
                    circularProgress():
                    Expanded(child: Center(child: Text(remaining.toString(),style: TextStyle(fontFamily: "Poppins",fontSize: 50.0,color: Colors.red),))),
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
