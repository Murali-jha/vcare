import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop/About%20App/abouthomepage.dart';
import 'package:e_shop/BottomNavHomePage.dart';
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
import 'package:firebase_messaging/firebase_messaging.dart';

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
          title: 'vCare',
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

  final FirebaseMessaging _messaging = FirebaseMessaging();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    displaySplash();
    _messaging.getToken().then((token){
      print(token);
    });
  }


  displaySplash(){
    Timer(Duration(seconds: 2),()async{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      bool _seen = (prefs.getBool('seen') ?? false);

      if(await EcommerceApp.auth.currentUser() != null){
        if (_seen) {
          Route route = MaterialPageRoute(builder: (_)=>BottomNavBar());
          Navigator.pushReplacement(context, route);
        } else {
          await prefs.setBool('seen', true);
          Navigator.of(context).pushReplacement(
              new MaterialPageRoute(builder: (context) => new AboutAppHomePage()));
        }
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
                Image.asset('images/login.png',width: 180.0,height: 180.0,),
                SpinKitSquareCircle(
                  color: Colors.green,
                  size: 45.0,
                )
              ],
            ),
          )
      ),
    );
  }
}
