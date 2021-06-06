import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop/Counters/ItemQuantity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Authentication/authenication.dart';
import 'package:e_shop/Config/config.dart';
import 'Counters/cartitemcounter.dart';
import 'Counters/changeAddresss.dart';
import 'Counters/totalMoney.dart';
import 'Store/storehome.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

Future<void> main() async
{
  WidgetsFlutterBinding.ensureInitialized();

  EcommerceApp.auth = FirebaseAuth.instance;
  EcommerceApp.sharedPreferences = await SharedPreferences.getInstance();
  EcommerceApp.firestore = Firestore.instance;


  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (c)=>CartItemCounter()),
          ChangeNotifierProvider(create: (c)=>ItemQuantity()),
          ChangeNotifierProvider(create: (c)=>AddressChanger()),
          ChangeNotifierProvider(create: (c)=>TotalAmount()),
        ],
        child:MaterialApp(
          title: 'V-Care',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              brightness: Brightness.dark
          ),
          home: SplashScreen(),

        ),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}


class _SplashScreenState extends State<SplashScreen>
{

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    displaySplash();
  }


  displaySplash(){
    Timer(Duration(seconds: 3),()async{
      if(await EcommerceApp.auth.currentUser() != null){
        Route route = MaterialPageRoute(builder: (_)=>StoreHome());
        Navigator.pushReplacement(context, route);
      }
      else{
        Route route = MaterialPageRoute(builder: (_)=>AuthenticScreen());
        Navigator.pushReplacement(context, route);
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: Colors.green,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('images/welcome.png',width: 290.0,height: 290.0,),
                SpinKitSquareCircle(
                  color: Colors.white,
                  size: 45.0,
                )
              ],
            ),
          )
      ),
    );
  }
}
