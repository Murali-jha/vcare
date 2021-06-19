import 'package:e_shop/Orders/myOrders.dart';
import 'package:e_shop/Store/cart.dart';
import 'package:e_shop/Store/storehome.dart';
import 'package:e_shop/adminFeed/userFeedPage.dart';
import 'package:e_shop/adminFeed/userTaskAndFun.dart';
import 'package:e_shop/credits/creditsHomePage.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';


class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _page = 2;
  GlobalKey _bottomNavigationKey = GlobalKey();

  final List<Widget> _children = [
    MyOrders(),UserFeedPageHomeScreen(),StoreHome(),UserTaskAndFunPageHomeScreen(),CreditsHomePage(),// create the pages you want to navigate between
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: CurvedNavigationBar(
          color: Colors.black12,
          backgroundColor: Colors.black12,
          buttonBackgroundColor: Colors.green,
          key: _bottomNavigationKey,
          height: 47.0,
          items: <Widget>[
            Icon(Icons.supervisor_account_rounded, size: 30,color: Colors.white,),
            Icon(Icons.feed, size: 23,color: Colors.white,),
            Icon(Icons.home, size: 23,color: Colors.white,),
            Icon(Icons.beenhere_rounded, size: 23,color: Colors.white,),
            Icon(Icons.auto_awesome, size: 23,color: Colors.white,),
          ],
          animationCurve: Curves.easeIn,
          animationDuration: Duration(
              milliseconds: 500
          ),
          index: 2,
          onTap: (index) {
            setState(() {
              this._page = index;
            });
          },

        ),
        body: _children[_page]
    );
  }
}