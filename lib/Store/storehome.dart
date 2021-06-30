import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop/BottomNavHomePage.dart';
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


  String dropdownValue = 'ALL';
  List slots = [];


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
            desc: "Before starting have a look at user manual to make your experience seam less!",
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
                "v",
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
                    icon: Icon(Icons.send_outlined,)),
                Positioned(
                    child: Stack(
                  children: [
                    Icon(
                      Icons.brightness_1,
                      size: 22.0,
                      color: Colors.green,
                    ),
                    Positioned(
                        top: 3.5,
                        bottom: 4.0,
                        left: 7.3,
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
          SliverList(
            delegate: SliverChildListDelegate([
              Container(
                margin: EdgeInsets.fromLTRB(20.0, 0.0, 10.0, 0.0),
                child: Column(
                  children: [
                    Divider(),
                    Row(
                      children: [
                        Expanded(
                          flex:1,
                            child: Text("Sort By : ",style: TextStyle(fontFamily: "Poppins",fontSize: 17.0),)),
                        SizedBox(
                          width: 10.0,
                        ),
                        Expanded(
                          flex:2,
                          child: Container(
                            height: 52.0,
                            child: DropdownButton<String>(
                              isExpanded: true,
                              value: dropdownValue,
                              icon: const Icon(Icons.arrow_drop_down_sharp),
                              iconSize: 24,
                              elevation: 16,
                              style: const TextStyle(color: Colors.white),
                              underline: Container(
                                height: 2,
                                color: Colors.grey.shade400,
                              ),
                              onChanged: (String newValue) {
                                setState(() {
                                  dropdownValue = newValue;
                                });
                              },
                              items: <String>[
                                'ALL',
                                'LISTENERS',
                                'MENTORS',
                                'PSYCHIATRISTS'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ),
                        )
                      ],
                    ),
                    Divider()
                  ],
                ),
              )
            ]),
          ),
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
                        if(dropdownValue == "LISTENERS" && model.tag == "Listener"){
                          return sourceInfo(model, context);
                        }
                        else if(dropdownValue == "MENTORS" && model.tag == "Mentor"){
                          return sourceInfo(model, context);
                        }
                        else if(dropdownValue == "PSYCHIATRISTS" && model.tag == "Psychiatrist"){
                          return sourceInfo(model, context);
                        }
                        else if(dropdownValue == "ALL"){
                          return sourceInfo(model, context);
                        }
                        else{
                          return Text("",style: TextStyle(fontSize: 0.0),);
                        }
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
      padding: EdgeInsets.fromLTRB(10.0,5.0,10.0,5.0),
      child: Container(
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
                Container(
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        flex:5,
                          child: Text(
                        model.title,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 18.0,
                            fontFamily: "Poppins"),
                      )),
                      Expanded(
                        flex: 1,
                          child: Icon(
                            Icons.info_rounded,size: 18.0,color: Colors.grey[400],
                          )
                      ),
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

                Padding(
                  padding: const EdgeInsets.only(top:6.0),
                  child: Row(
                    children: [
                      Flexible(
                        flex: 2,
                        child: Align(
                            alignment: Alignment.bottomLeft,
                            child: ElevatedButton(

                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10.0),
                                          side: BorderSide(color: Colors.green, width: 1.0)))),
                              child: Text(model.tag,style: TextStyle(fontFamily: "Poppins"),),
                              onPressed: () {
                                if(model.tag=="Mentor"){
                                  showDialog(
                                    barrierDismissible: false,
                                    context: context,
                                    builder: (context) => AlertDialogForTagDetails(
                                      title: "who is mentor?",
                                      message:  "Mentor are the expert who will guide you to achieve your goal",
                                    ),
                                  );
                                }
                                else if(model.tag=="Listener"){
                                  showDialog(
                                    barrierDismissible: false,
                                    context: context,
                                    builder: (context) => AlertDialogForTagDetails(
                                      title: "who is Listener?",
                                      message:  "Listener are people from student community who listens to you, but do not judge or guide you",
                                    ),
                                  );
                                }else{
                                  showDialog(
                                    barrierDismissible: false,
                                    context: context,
                                    builder: (context) => AlertDialogForTagDetails(
                                      title: "who is Psychiatrist?",
                                      message:  "Psychiatrist are expert who help you to overcome your depression or stress",
                                    ),
                                  );
                                }
                              },
                            ),
                        ),
                      ),
                      Flexible(
                        flex: 1,
                          child: Align(
                              alignment: Alignment.centerRight,
                              child: removeCartFunction == null
                                  ?
                              OutlineButton(
                                onPressed: () {
                                  checkItemInCart(model.shortInfo, context,model.title.toString());
                                },

                                borderSide: BorderSide(color: Colors.blue),
                                shape: StadiumBorder(),

                                child: const Text("Book",style: TextStyle(fontFamily: "Poppins",color: Colors.white),),
                              )
                                  : IconButton(
                                  onPressed: () {
                                    removeCartFunction();
                                    Route route = MaterialPageRoute(
                                        builder: (context) => BottomNavBar());
                                    Navigator.of(context).pushAndRemoveUntil(route, (Route<dynamic> route) => false);
                                    showDialog(
                                      barrierDismissible: false,
                                      context: context,
                                      builder: (context) => CustomAlertDialogRemoveQueue(
                                        title: "Alert!",
                                        desc:  "${model.title.toString()} removed from draft Successfully",
                                      ),
                                    );
                                  },
                                  icon: Icon(Icons.delete))),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 10.0,),
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

void checkItemInCart(String shortInfoAsId, BuildContext context,String name) {
  EcommerceApp.sharedPreferences
          .getStringList(EcommerceApp.userCartList)
          .contains(shortInfoAsId)
      ? showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) => CustomAlertDialogQueue(
      title: "Alert!",
      desc: "To book an appointment with $name click proceed!",
    ),
  )
      : addItemToCart(shortInfoAsId, context,name);
}

addItemToCart(String shortInfoAsId, BuildContext context,String name) {
  List tempCartList =
      EcommerceApp.sharedPreferences.getStringList(EcommerceApp.userCartList);
  tempCartList.add(shortInfoAsId);

  EcommerceApp.firestore
      .collection(EcommerceApp.collectionUser)
      .document(EcommerceApp.sharedPreferences.getString(EcommerceApp.userUID))
      .updateData({
    EcommerceApp.userCartList: tempCartList,
  }).then((v) {
    Fluttertoast.showToast(msg: "Saved in Draft!");
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => CustomAlertDialogQueue(
        title: "Alert!",
        desc: "To book an appointment with $name click proceed!",
      ),
    );
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


class CustomAlertDialogQueue extends StatelessWidget {

  final String title,desc;

  CustomAlertDialogQueue({ this.title, this.desc,});


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
                    fontSize: 20.0,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,fontFamily: "Poppins"
                ),
              ),
              SizedBox(height: 22.0,),
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
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>CartPage()));
                      },
                      child: Text("Proceed",style: TextStyle(color: Colors.white,fontFamily: "Poppins"),),
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
              backgroundImage: AssetImage("assets/gifs/alert.gif"),
            )
        )
      ],
    );
  }
}


class CustomAlertDialogRemoveQueue extends StatelessWidget {

  final String title,desc;

  CustomAlertDialogRemoveQueue({ this.title, this.desc,});


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
                    Route route = MaterialPageRoute(
                        builder: (context) => BottomNavBar());
                    Navigator.of(context).pushAndRemoveUntil(route, (Route<dynamic> route) => false);
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
              backgroundImage: AssetImage("assets/gifs/alert.gif"),
            )
        )
      ],
    );
  }
}


class AlertDialogForTagDetails extends StatelessWidget {

  final String message,title;

  AlertDialogForTagDetails({this.message, this.title,});


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
                    fontSize: 20.0,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,fontFamily: "Poppins"
                ),
              ),
              SizedBox(height: 15.0,),
              Text(
                message,
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
                  child: Text("Cool",style: TextStyle(color: Colors.white,fontFamily: "Poppins"),),
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

