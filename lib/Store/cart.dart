import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop/Config/config.dart';
import 'package:e_shop/Address/address.dart';
import 'package:e_shop/Widgets/customAppBar.dart';
import 'package:e_shop/Widgets/loadingWidget.dart';
import 'package:e_shop/Models/item.dart';
import 'package:e_shop/Counters/cartitemcounter.dart';
import 'package:e_shop/Counters/totalMoney.dart';
import 'package:e_shop/Widgets/myDrawer.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:e_shop/Store/storehome.dart';
import 'package:provider/provider.dart';
import '../main.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}



class _CartPageState extends State<CartPage>
{
  double totalAmount;

  @override
  void initState() {
    super.initState();

    totalAmount = 0;
    Provider.of<TotalAmount>(context, listen: false).display(0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: ()
        {
          if(EcommerceApp.sharedPreferences.getStringList(EcommerceApp.userCartList).length == 1)
          {
            Fluttertoast.showToast(msg: "You have not selected any doctor yet");
          }
          else
          {
            Route route = MaterialPageRoute(builder: (c) => Address());
            Navigator.pushReplacement(context, route);
          }
        },
        label: Text("Book a slot",style: TextStyle(color: Colors.white,fontFamily: "Poppins"),),
        backgroundColor: Colors.green,
        icon: Icon(Icons.navigate_next,color: Colors.white,),
      ),
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
                                (EcommerceApp.sharedPreferences.getStringList(EcommerceApp.userCartList).length -1).toString(),
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
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Consumer2<TotalAmount, CartItemCounter>(builder: (context, amountProvider, cartProvider, c)
            {
              return Padding(
                padding: EdgeInsets.all(8.0),
                child: Center(
                  child: cartProvider.count == 0
                      ? Container()
                      : Text(
                    "Your Favourites",
                    style: TextStyle(color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.w500,fontFamily: "Poppins"),
                  ),
                ),
              );
            },),
          ),
          StreamBuilder<QuerySnapshot>(
            stream: EcommerceApp.firestore.collection("items")
                .where("shortInfo", whereIn: EcommerceApp.sharedPreferences.getStringList(EcommerceApp.userCartList)).snapshots(),
            builder: (context, snapshot)
            {
              return !snapshot.hasData
                  ? SliverToBoxAdapter(child: Center(child: circularProgress(),),)
                  : snapshot.data.documents.length == 0
                  ? beginBuildingCart()
                  : SliverList(
                delegate: SliverChildBuilderDelegate(
                      (context, index)
                  {
                    ItemModel model = ItemModel.fromJson(snapshot.data.documents[index].data);

                    if(index == 0)
                    {
                      totalAmount = 0;
                    }
                    else
                    {
                      totalAmount = 0;
                    }

                    if(snapshot.data.documents.length - 1 == index)
                    {
                      WidgetsBinding.instance.addPostFrameCallback((t) {
                        Provider.of<TotalAmount>(context, listen: false).display(totalAmount);
                      });
                    }

                    return sourceInfo(model, context, removeCartFunction: () => removeItemFromUserCart(model.shortInfo));
                  },

                  childCount: snapshot.hasData ? snapshot.data.documents.length : 0,
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  beginBuildingCart()
  {
    return SliverToBoxAdapter(
      child: Card(
        color: Theme.of(context).primaryColor.withOpacity(0.5),
        child: Container(
          height: 100.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.insert_emoticon, color: Colors.white,),
              Text("Favourite List is empty."),
              Text("Start exploring and add to your favourite list."),
            ],
          ),
        ),
      ),
    );
  }

  removeItemFromUserCart(String shortInfoAsId)
  {
    List tempCartList = EcommerceApp.sharedPreferences.getStringList(EcommerceApp.userCartList);
    tempCartList.remove(shortInfoAsId);

    EcommerceApp.firestore.collection(EcommerceApp.collectionUser)
        .document(EcommerceApp.sharedPreferences.getString(EcommerceApp.userUID))
        .updateData({
      EcommerceApp.userCartList: tempCartList,
    }).then((v){
      Fluttertoast.showToast(msg: "Person removed from your favourite list.");

      EcommerceApp.sharedPreferences.setStringList(EcommerceApp.userCartList, tempCartList);

      Provider.of<CartItemCounter>(context, listen: false).displayResult();

      totalAmount = 0;
    });
  }
}
