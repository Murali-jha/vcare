import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop/Store/cart.dart';
import 'package:e_shop/Store/product_page.dart';
import 'package:e_shop/Counters/cartitemcounter.dart';
import 'package:e_shop/howtouse/help.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:e_shop/Config/config.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Widgets/loadingWidget.dart';
import '../Widgets/myDrawer.dart';
import '../Widgets/searchBox.dart';
import '../Models/item.dart';

double width;

class StoreHome extends StatefulWidget {
  @override
  _StoreHomeState createState() => _StoreHomeState();
}

class _StoreHomeState extends State<StoreHome> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
      checkDialogIntroShown();

  }


  Future checkDialogIntroShown() async {
    SharedPreferences storeHomePrefs = await SharedPreferences.getInstance();
    bool _seen = (storeHomePrefs.getBool('seenHomePageDialog') ?? false);

    if (_seen) {


    }
    else{
      await storeHomePrefs.setBool('seenHomePageDialog', true);
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) => CustomAlertDialog(
            title: "Hey ${EcommerceApp.sharedPreferences.getString(EcommerceApp.userName)} !",
            desc: "Before starting have a look at user manual to make your experience seem less!",
          ),
      );
        //showAlertDialog(context);
    }
  }

  // showAlertDialog(BuildContext context) {
  //
  //   // set up the button
  //   Widget okButton = FlatButton(
  //     child: Text("OK",style: TextStyle(fontFamily: "Poppins"),),
  //     color: Colors.green,
  //     onPressed: () {
  //       Navigator.pop(context);
  //       Navigator.push(context, MaterialPageRoute(builder: (context)=>HelpHomePage()));
  //     },
  //   );
  //
  //   Widget cancelButton = FlatButton(
  //     child: Text("Cancel",style: TextStyle(fontFamily: "Poppins"),),
  //     color: Colors.red,
  //     onPressed: () {
  //       Navigator.pop(context);
  //     },
  //   );
  //
  //   // set up the AlertDialog
  //   AlertDialog alert = AlertDialog(
  //     shape: RoundedRectangleBorder(
  //       borderRadius: BorderRadius.circular(10),
  //     ),
  //     title: Text("Hey ${EcommerceApp.sharedPreferences.getString(EcommerceApp.userName)} !",style: TextStyle(fontFamily: "Poppins"),),
  //     content: Text("Before starting have a look at user manual to make your experience seem less!",style: TextStyle(fontFamily: "Poppins"),),
  //     actions: [
  //       cancelButton,
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

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    return SafeArea(
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
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(16.0)),
          ),
          centerTitle: true,
          actions: [
            Stack(
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => CartPage()));
                    },
                    icon: Icon(Icons.queue_play_next)),
                Positioned(
                    child: Stack(
                  children: [
                    Icon(
                      Icons.brightness_1,
                      size: 20.0,
                      color: Colors.green,
                    ),
                    Positioned(
                        top: 3.0,
                        bottom: 4.0,
                        left: 6.0,
                        child: Consumer<CartItemCounter>(
                          builder: (context, counter, _) {
                            return Text(
                              (EcommerceApp.sharedPreferences
                                          .getStringList(
                                              EcommerceApp.userCartList)
                                          .length -
                                      1)
                                  .toString(),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: "Poppins"),
                            );
                          },
                        ))
                  ],
                ))
              ],
            ),
            SizedBox(
              width: 10.0,
            ),
          ],
        ),
        drawer: MyDrawer(),
        body: CustomScrollView(slivers: [
          SliverPersistentHeader(pinned: true, delegate: SearchBoxDelegate()),
          StreamBuilder<QuerySnapshot>(
            stream: Firestore.instance
                .collection("items")
                .limit(50)
                .orderBy("publishedDate", descending: true)
                .snapshots(),
            builder: (context, dataSnapshot) {
              return !dataSnapshot.hasData
                  ? SliverToBoxAdapter(
                      child: Center(
                        child: circularProgress(),
                      ),
                    )
                  : SliverStaggeredGrid.countBuilder(
                      crossAxisCount: 1,
                      staggeredTileBuilder: (c) => StaggeredTile.fit(1),
                      itemBuilder: (context, index) {
                        ItemModel model = ItemModel.fromJson(
                            dataSnapshot.data.documents[index].data);
                        return sourceInfo(model, context);
                      },
                      itemCount: dataSnapshot.data.documents.length);
            },
          ),
        ]),
      ),
    );
  }
}

Widget sourceInfo(ItemModel model, BuildContext context,
    {Color background, removeCartFunction}) {
  return InkWell(
    onTap: () {
      Route route = MaterialPageRoute(
          builder: (context) => ProductPage(itemModel: model));
      Navigator.push(context, route);
    },
    splashColor: Colors.green,
    child: Padding(
      padding: EdgeInsets.all(10.0),
      child: Container(
        height: 220.0,
        width: width,
        child: Row(
          children: [
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
                height: 100.0,
                width: 100.0,
                child: CircleAvatar(
                  backgroundImage: NetworkImage(
                    model.thumbnailUrl,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 18.0,
            ),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20.0,
                ),
                Container(
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                          child: Text(
                        model.title,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 18.0,
                            fontFamily: "Poppins"),
                      ))
                    ],
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Container(
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                          child: Text(
                        model.shortInfo,
                        style: TextStyle(
                            color: Colors.grey[400],
                            fontSize: 14.0,
                            fontFamily: "Poppins"),
                      ))
                    ],
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 0.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              "Status: ",
                              style: TextStyle(
                                  color: Colors.green,
                                  fontSize: 16.0,
                                  fontFamily: "Poppins"),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              model.status,
                              style: TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.white, fontFamily: "Poppins"),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 0.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              "Availability: ",
                              style: TextStyle(
                                  color: Colors.green,
                                  fontSize: 16.0,
                                  fontFamily: "Poppins"),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              model.price.toString(),
                              style: TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.white, fontFamily: "Poppins"),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),

                Row(
                  children: [
                    Expanded(
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10.0),
                                        side: BorderSide(color: Colors.green, width: 1.0)))),
                            child: Text(model.tag,style: TextStyle(fontFamily: "Poppins"),),
                            onPressed: () {},
                          ),
                      ),
                    ),
                    Expanded(
                        child: Align(
                            alignment: Alignment.centerRight,
                            child: removeCartFunction == null
                                ? IconButton(
                                onPressed: () {
                                  checkItemInCart(model.shortInfo, context);
                                },
                                icon: Icon(
                                  Icons.queue,
                                  color: Colors.white,
                                ))
                                : IconButton(
                                onPressed: () {
                                  removeCartFunction();
                                  Route route = MaterialPageRoute(
                                      builder: (context) => StoreHome());
                                  Navigator.pushReplacement(context, route);
                                },
                                icon: Icon(Icons.delete))),
                    )
                  ],
                ),
                Divider(
                  color: Colors.green,
                )
                //Implement cart item remove feature
              ],
            )),
          ],
        ),
      ),
    ),
  );
  // return InkWell(
  //   onTap: () {
  //     Route route = MaterialPageRoute(
  //         builder: (context) => ProductPage(itemModel: model));
  //     Navigator.push(context, route);
  //   },
  //   splashColor: Colors.green,
  //   child: Container(
  //     decoration: BoxDecoration(
  //         border: Border.all(
  //           color: Colors.grey.shade700,
  //         ),
  //         color: Colors.grey.shade900,
  //         borderRadius: BorderRadius.all(Radius.circular(20))),
  //     padding: EdgeInsets.all(10),
  //     margin: EdgeInsets.all(10),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.center,
  //       children: [
  //         Material(
  //           borderRadius: BorderRadius.all(Radius.circular(80.0)),
  //           elevation: 8.0,
  //           child: Container(
  //             decoration: new BoxDecoration(
  //               shape: BoxShape.circle,
  //               border: new Border.all(
  //                 color: Colors.blueGrey,
  //                 width: 2.0,
  //               ),
  //             ),
  //             height: 110.0,
  //             width: 110.0,
  //             child: CircleAvatar(
  //               backgroundImage: NetworkImage(
  //                 model.thumbnailUrl,
  //               ),
  //             ),
  //           ),
  //         ),
  //         SizedBox(
  //           height: 12.0,
  //         ),
  //         Text(
  //           model.title,
  //           style: TextStyle(fontSize: 18.0, fontFamily: "Poppins"),
  //         ),
  //         SizedBox(
  //           height: 6.0,
  //         ),
  //         Text(
  //           model.shortInfo,
  //           style: TextStyle(
  //               fontSize: 16.0, fontFamily: "Poppins", color: Colors.grey),
  //         ),
  //         Divider(),
  //         Row(
  //           children: [
  //             Expanded(
  //                 child: Center(
  //               child: Text(
  //                 "Status : ",
  //                 style: TextStyle(
  //                     fontSize: 16.0,
  //                     fontFamily: "Poppins",
  //                     color: Colors.white),
  //               ),
  //             )),
  //             Expanded(
  //                 child: Center(
  //               child: Text(
  //                 model.status,
  //                 style: TextStyle(
  //                     fontSize: 16.0,
  //                     fontFamily: "Poppins",
  //                     color: Colors.white),
  //               ),
  //             ))
  //           ],
  //         ),
  //         Divider(),
  //         Row(
  //           children: [
  //             Expanded(
  //                 child: Center(
  //               child: Text(
  //                 "Available Between : ",
  //                 style: TextStyle(
  //                     fontSize: 16.0,
  //                     fontFamily: "Poppins",
  //                     color: Colors.white),
  //               ),
  //             )),
  //             Expanded(
  //                 child: Center(
  //               child: Text(
  //                 model.price,
  //                 style: TextStyle(
  //                     fontSize: 16.0,
  //                     fontFamily: "Poppins",
  //                     color: Colors.white),
  //               ),
  //             ))
  //           ],
  //         ),
  //         Align(
  //             alignment: Alignment.centerRight,
  //             child: removeCartFunction == null
  //                 ? IconButton(
  //                     onPressed: () {
  //                       checkItemInCart(model.shortInfo, context);
  //                     },
  //                     icon: Icon(
  //                       Icons.star_border,
  //                       color: Colors.white,
  //                     ))
  //                 : IconButton(
  //                     onPressed: () {
  //                       removeCartFunction();
  //                       Route route = MaterialPageRoute(
  //                           builder: (context) => StoreHome());
  //                       Navigator.pushReplacement(context, route);
  //                     },
  //                     icon: Icon(Icons.delete)))
  //       ],
  //     ),
  //   ),
  // );
}

Widget card({Color primaryColor = Colors.redAccent, String imgPath}) {
  return Container(
    height: 150.0,
    width: width * .34,
    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
        boxShadow: <BoxShadow>[
          BoxShadow(offset: Offset(0, 5), blurRadius: 10.0, color: Colors.grey[200]),
        ]
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(20.0)),
      child: Image.network(
        imgPath,
        height: 150.0,
        width: width * .34,
        fit: BoxFit.fill,
      ),
    ),
  );
}

void checkItemInCart(String shortInfoAsId, BuildContext context) {
  EcommerceApp.sharedPreferences
          .getStringList(EcommerceApp.userCartList)
          .contains(shortInfoAsId)
      ? Fluttertoast.showToast(msg: "Already added to queue")
      : addItemToCart(shortInfoAsId, context);
}

addItemToCart(String shortInfoAsId, BuildContext context) {
  List tempCartList =
      EcommerceApp.sharedPreferences.getStringList(EcommerceApp.userCartList);
  tempCartList.add(shortInfoAsId);

  EcommerceApp.firestore
      .collection(EcommerceApp.collectionUser)
      .document(EcommerceApp.sharedPreferences.getString(EcommerceApp.userUID))
      .updateData({
    EcommerceApp.userCartList: tempCartList,
  }).then((v) {
    Fluttertoast.showToast(msg: "Added to queue Successfully!");
    EcommerceApp.sharedPreferences
        .setStringList(EcommerceApp.userCartList, tempCartList);
    Provider.of<CartItemCounter>(context, listen: false).displayResult();
  });
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
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: FlatButton(
                      color: Colors.red,
                      onPressed: (){
                        Navigator.pop(context);
                      },
                      child: Text("Cancel",style: TextStyle(color: Colors.white,fontFamily: "Poppins"),),
                    ),
                  ),
                  SizedBox(width: 10.0,),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: FlatButton(
                      color: Colors.green,
                      onPressed: (){
                        Navigator.pop(context);
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>HelpHomePage()));
                      },
                      child: Text("Okay",style: TextStyle(color: Colors.white,fontFamily: "Poppins"),),
                    ),
                  ),
                ],
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
