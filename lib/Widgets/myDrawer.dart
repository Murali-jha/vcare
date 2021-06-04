import 'package:e_shop/Authentication/authenication.dart';
import 'package:e_shop/Authentication/login.dart';
import 'package:e_shop/Config/config.dart';
import 'package:e_shop/Address/addAddress.dart';
import 'package:e_shop/Store/Search.dart';
import 'package:e_shop/Store/cart.dart';
import 'package:e_shop/Orders/myOrders.dart';
import 'package:e_shop/Store/storehome.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          Container(
            padding: EdgeInsets.only(top: 25.0, bottom: 10.0),
            decoration: BoxDecoration(
                color: Colors.white10
            ),
            child: Column(
              children: [
                Material(
                  borderRadius: BorderRadius.all(Radius.circular(80.0)),
                  elevation: 8.0,
                  child: Container(
                    height: 160.0,
                    width: 160.0,
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(
                        EcommerceApp.sharedPreferences
                            .getString(EcommerceApp.userAvatarUrl),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                EcommerceApp.sharedPreferences.getString(EcommerceApp.userName)==null?
                Text(
                    "",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 35.0,
                      fontFamily: "Signatra",
                    )):Text(
                    EcommerceApp.sharedPreferences
                        .getString(EcommerceApp.userName),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 35.0,
                      fontFamily: "Signatra",
                    )),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 1.0),
            child: Column(
              children: [
                ListTile(
                  leading: Icon(Icons.home),
                  title: Text("Home",style: TextStyle(fontFamily: "Ubuntu",fontSize: 15.0),),
                  onTap: () {
                    Route route = MaterialPageRoute(builder: (c) {
                      return StoreHome();
                    });
                    Navigator.pushReplacement(context, route);
                  },
                ),
                Divider(
                  height: 10.0,
                  color: Colors.deepOrangeAccent[300],
                ),
                ListTile(
                  leading: Icon(Icons.reorder),
                  title: Text("My Orders",style: TextStyle(fontFamily: "Ubuntu",fontSize: 15.0)),
                  onTap: () {
                    Route route = MaterialPageRoute(builder: (c) {
                      return MyOrders();
                    });
                    Navigator.push(context, route);
                  },
                ),
                Divider(
                  height: 10.0,
                  color: Colors.deepOrangeAccent[300],
                ),
                ListTile(
                  leading: Icon(Icons.shopping_cart),
                  title: Text("My Cart",style: TextStyle(fontFamily: "Ubuntu",fontSize: 15.0)),
                  onTap: () {
                    Route route = MaterialPageRoute(builder: (c) {
                      return CartPage();
                    });
                    Navigator.push(context, route);
                  },
                ),
                Divider(
                  height: 10.0,
                  color: Colors.deepOrangeAccent[300],
                ),
                ListTile(
                  leading: Icon(Icons.search),
                  title: Text("Search",style: TextStyle(fontFamily: "Ubuntu",fontSize: 15.0)),
                  onTap: () {
                    Route route = MaterialPageRoute(builder: (c) {
                      return SearchProduct();
                    });
                    Navigator.push(context, route);
                  },
                ),
                Divider(
                  height: 10.0,
                  color: Colors.deepOrangeAccent[300],
                ),
                ListTile(
                  leading: Icon(Icons.add_location),
                  title: Text("Add New Address",style: TextStyle(fontFamily: "Ubuntu",fontSize: 15.0)),
                  onTap: () {
                    Route route = MaterialPageRoute(builder: (c) {
                      return AddAddress();
                    });
                    Navigator.push(context, route);
                  },
                ),
                Divider(
                  height: 10.0,
                  color: Colors.deepOrangeAccent[300],
                ),
                ListTile(
                  leading: Icon(Icons.logout,color: Colors.red),
                  title: Text("Logout",style: TextStyle(color: Colors.red,fontFamily: "Ubuntu",fontSize: 15.0),),
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (c) {
                          return AlertDialog(
                            key: key,
                            content: Text("Do you want to logout?"),
                            actions: <Widget>[
                              RaisedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                color: Colors.green,
                                child: Center(
                                  child: Text("No"),
                                ),
                              ),
                              RaisedButton(
                                onPressed: () {
                                  EcommerceApp.auth.signOut().then((c) {
                                    Navigator.of(context).pushAndRemoveUntil(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                AuthenticScreen()),
                                            (Route<dynamic> route) => false);
                                  });
                                },
                                color: Colors.red,
                                child: Center(
                                  child: Text("Yes"),
                                ),
                              )
                            ],
                          );
                        });
                  },
                ),
                Divider(
                  height: 10.0,
                  color: Colors.deepOrangeAccent[300],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
