import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'login.dart';
import 'register.dart';
import 'package:e_shop/Config/config.dart';

class AuthenticScreen extends StatefulWidget {
  @override
  _AuthenticScreenState createState() => _AuthenticScreenState();
}

class _AuthenticScreenState extends State<AuthenticScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
            appBar: AppBar(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "V - ",
                    style: TextStyle(
                      fontFamily: "Signatra",
                      fontSize: 45.0,
                    ),
                  ),
                  Text(
                    "Care",
                    style: TextStyle(
                        fontFamily: "Signatra",
                        fontSize: 45.0,
                        color: Colors.green),
                  ),
                ],
              ),
              // shape: RoundedRectangleBorder(
              //   borderRadius: BorderRadius.vertical(bottom: Radius.circular(50.0)),
              // ),
              centerTitle: true,
              bottom: TabBar(
                tabs: [
                  Tab(
                    icon: Icon(Icons.lock, color: Colors.white),
                    text: "Login",
                  ),
                  Tab(
                    icon: Icon(Icons.fiber_new_rounded, color: Colors.white),
                    text: "Register",
                  ),
                ],
                indicatorColor: Colors.green,
                indicatorWeight: 2.5,
              ),
            ),
            body: Container(
              child: TabBarView(
                children: [
                  Login(),
                  Register(),
                ],
              ),
            )));
  }
}
