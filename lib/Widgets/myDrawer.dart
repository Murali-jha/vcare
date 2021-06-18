import 'package:e_shop/About%20App/abouthomepage.dart';
import 'package:e_shop/Authentication/authenication.dart';
import 'package:e_shop/Authentication/login.dart';
import 'package:e_shop/Config/config.dart';
import 'package:e_shop/Address/addAddress.dart';
import 'package:e_shop/Store/Search.dart';
import 'package:e_shop/Store/cart.dart';
import 'package:e_shop/Orders/myOrders.dart';
import 'package:e_shop/Store/storehome.dart';
import 'package:e_shop/Widgets/loadingWidget.dart';
import 'package:e_shop/adminFeed/userFeedPage.dart';
import 'package:e_shop/adminFeed/userTaskAndFun.dart';
import 'package:e_shop/credits/creditsHomePage.dart';
import 'package:e_shop/howtouse/help.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:launch_review/launch_review.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';


class MyDrawer extends StatefulWidget {
  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {

  String url,name;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  Future fetchData() async{
    EcommerceApp.sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      url  = EcommerceApp.sharedPreferences.getString(EcommerceApp.userAvatarUrl);
      print(url);
      name = EcommerceApp.sharedPreferences.getString(EcommerceApp.userName);
      print(name);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 260.0,
      child: Drawer(
        child: ListView(
          children: [
            Container(
              padding: EdgeInsets.only(top: 25.0, bottom: 10.0),
              child: Column(
                children: [
                  url==null?
                      Center(child: CircularProgressIndicator(color: Colors.green,)):
                  Material(
                    borderRadius: BorderRadius.all(Radius.circular(80.0)),
                    elevation: 8.0,
                    child: Container(
                      decoration: new BoxDecoration(
                        shape: BoxShape.circle,
                        border: new Border.all(
                          color: Colors.blueGrey,
                          width: 2.0,
                        ),
                      ),
                      height: 160.0,
                      width: 160.0,
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(
                            url
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  name==null?Center(child: CircularProgressIndicator(color: Colors.green,)):
                  Text(
                      name,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 35.0,
                        fontFamily: "Signatra",
                      )),
                ],
              ),
            ),
            Divider(
              height: 10.0,
              color: Colors.blueGrey,
            ),
            Container(
              padding: EdgeInsets.only(top: 1.0),
              child: Column(
                children: [

                  ListTile(
                    leading: Icon(Icons.home),
                    title: Text("Home",style: TextStyle(fontFamily: "Poppins",fontSize: 15.0),),
                    onTap: () {
                      Route route = MaterialPageRoute(builder: (c) {
                        return StoreHome();
                      });
                      Navigator.pushReplacement(context, route);
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.feed),
                    title: Text("Feed & Updates",style: TextStyle(fontFamily: "Poppins",fontSize: 15.0),),
                    onTap: () {
                      Route route = MaterialPageRoute(builder: (c) {
                        return UserFeedPageHomeScreen();
                      });
                      Navigator.push(context, route);
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.chat_bubble_outline),
                    title: Text("Chats",style: TextStyle(fontFamily: "Poppins",fontSize: 15.0),),
                    onTap: () {
                      // Route route = MaterialPageRoute(builder: (c) {
                      //   return StoreHome();
                      // });
                      // Navigator.push(context, route);
                      Fluttertoast.showToast(msg: "Chat feature currently not available");
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.beenhere_rounded),
                    title: Text("Tasks & Fun",style: TextStyle(fontFamily: "Poppins",fontSize: 15.0),),
                    onTap: () {
                      Route route = MaterialPageRoute(builder: (c) {
                        return UserTaskAndFunPageHomeScreen();
                      });
                      Navigator.push(context, route);
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.auto_awesome),
                    title: Text("CryptoV",style: TextStyle(fontFamily: "Poppins",fontSize: 15.0),),
                    onTap: () {
                      Route route = MaterialPageRoute(builder: (c) {
                        return CreditsHomePage();
                      });
                      Navigator.push(context, route);
                    },
                  ),
                  Divider(
                    height: 10.0,
                    color: Colors.blueGrey,
                  ),
                  ListTile(
                    leading: Icon(Icons.reorder),
                    title: Text("My Appointments",style: TextStyle(fontFamily: "Poppins",fontSize: 15.0)),
                    onTap: () {
                      Route route = MaterialPageRoute(builder: (c) {
                        return MyOrders();
                      });
                      Navigator.push(context, route);
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.supervisor_account_rounded),
                    title: Text("Queue",style: TextStyle(fontFamily: "Poppins",fontSize: 15.0)),
                    onTap: () {
                      Route route = MaterialPageRoute(builder: (c) {
                        return CartPage();
                      });
                      Navigator.push(context, route);
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.search),
                    title: Text("Search",style: TextStyle(fontFamily: "Poppins",fontSize: 15.0)),
                    onTap: () {
                      Route route = MaterialPageRoute(builder: (c) {
                        return SearchProduct();
                      });
                      Navigator.push(context, route);
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.support_agent),
                    title: Text("Support",style: TextStyle(fontFamily: "Poppins",fontSize: 15.0)),
                    onTap: () {
                      // Route route = MaterialPageRoute(builder: (c) {
                      //   return AddAddress();
                      // });
                      // Navigator.push(context, route);
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.details_rounded),
                    title: Text("Add My Details",style: TextStyle(fontFamily: "Poppins",fontSize: 15.0)),
                    onTap: () {
                      Route route = MaterialPageRoute(builder: (c) {
                        return AddAddress();
                      });
                      Navigator.push(context, route);
                    },
                  ),
                  Divider(
                    height: 10.0,
                    color: Colors.blueGrey,
                  ),
                  ListTile(
                    leading: Icon(Icons.help_outline_outlined),
                    title: Text("How to use?",style: TextStyle(fontFamily: "Poppins",fontSize: 15.0)),
                    onTap: () {
                      Route route = MaterialPageRoute(builder: (c) {
                        return HelpHomePage();
                      });
                      Navigator.push(context, route);
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.info_rounded),
                    title: Text("About App",style: TextStyle(fontFamily: "Poppins",fontSize: 15.0)),
                    onTap: () {
                      Route route = MaterialPageRoute(builder: (c) {
                        return AboutAppHomePage();
                      });
                      Navigator.push(context, route);
                    },
                  ),
                  ListTile(
                    onTap: () {
                      final RenderBox box = context.findRenderObject();
                      Share.share('Hey to download V-Care app click below link\n https://play.google.com/store/apps/details?id=com.muralijha.vcare');
                    },
                    leading: Icon(
                      Icons.share,
                      color: Colors.white,
                    ),
                    title: Text(
                      "Share",
                      style: TextStyle(color: Colors.white,fontSize: 16.0),
                    ),
                  ),
                  ListTile(
                      onTap: () {
                        return LaunchReview.launch(
                          androidAppId: "com.muralijha.vcare",
                        );
                      },
                      leading: Icon(
                        Icons.star_rate_outlined,
                        color: Colors.white,
                      ),
                      title: Text(
                        "Rate the app",
                        style: TextStyle(color: Colors.white,fontSize: 16.0),
                      )
                  ),
                  Divider(
                    height: 10.0,
                    color: Colors.red,
                  ),
                  ListTile(
                    leading: Icon(Icons.logout,color: Colors.red),
                    title: Text("Logout",style: TextStyle(color: Colors.red,fontFamily: "Poppins",fontSize: 15.0),),
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (c) {
                            return AlertDialog(
                              content: Text("Do you want to logout?",style: TextStyle(fontFamily: "Poppins"),),
                              actions: <Widget>[

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
                                  child: Text("Yes",style: TextStyle(fontFamily: "Poppins"),),
                                ),
                                RaisedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  color: Colors.green,
                                  child: Text("No",style: TextStyle(fontFamily: "Poppins"),),
                                ),
                              ],
                            );
                          });
                    },
                  ),
                  Divider(
                    height: 10.0,
                    color: Colors.red,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

