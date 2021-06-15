import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop/Config/config.dart';
import 'package:e_shop/Models/address.dart';
import 'package:e_shop/Orders/placeOrder.dart';
import 'package:e_shop/Widgets/customAppBar.dart';
import 'package:e_shop/Widgets/loadingWidget.dart';
import 'package:e_shop/Widgets/wideButton.dart';
import 'package:e_shop/Counters/changeAddresss.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'addAddress.dart';

class Address extends StatefulWidget
{
  final double totalAmount;
  const Address({Key key, this.totalAmount}) : super(key: key);

  @override
  _AddressState createState() => _AddressState();
}


class _AddressState extends State<Address>
{
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: MyAppBar(),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                    "Select Credentials",
                    style: TextStyle(color: Colors.white,fontFamily: "Poppins", fontWeight: FontWeight.bold, fontSize: 20.0,),
                  ),
                ),
              ),
            ),
            Consumer<AddressChanger>(builder: (context, address, c){
              return Flexible(
                child: StreamBuilder<QuerySnapshot>(
                  stream: EcommerceApp.firestore
                      .collection(EcommerceApp.collectionUser)
                      .document(EcommerceApp.sharedPreferences.getString(EcommerceApp.userUID))
                      .collection(EcommerceApp.subCollectionAddress).snapshots(),

                  builder: (context, snapshot)
                  {
                    return !snapshot.hasData
                        ? Center(child: circularProgress(),)
                        : snapshot.data.documents.length == 0
                        ? noAddressCard()
                        : ListView.builder(
                      itemCount: snapshot.data.documents.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index)
                      {
                        return AddressCard(
                          currentIndex: address.count,
                          value: index,
                          addressId: snapshot.data.documents[index].documentID,
                          totalAmount: widget.totalAmount,
                          model: AddressModel.fromJson(snapshot.data.documents[index].data),
                        );
                      },
                    );
                  },
                ),
              );
            }),
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          label: Text("Add New Details",style: TextStyle(fontFamily: "Poppins",color: Colors.white),),
          backgroundColor: Colors.green,
          icon: Icon(Icons.add,color: Colors.white,),
          onPressed: ()
          {
            Route route = MaterialPageRoute(builder: (c) => AddAddress());
            Navigator.pushReplacement(context, route);
          },
        ),
      ),
    );
  }

  noAddressCard() {
    return Card(
      color: Theme.of(context).primaryColor.withOpacity(0.5),
      child: Container(
        height: 100.0,
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.add, color: Colors.white,),
            Text("No details has been saved.",style: TextStyle(fontFamily: "Poppins"),),
            Center(child: Text("Click add details to add your details",style: TextStyle(fontFamily: "Poppins"),)),
          ],
        ),
      ),
    );
  }
}



class AddressCard extends StatefulWidget
{
  final AddressModel model;
  final String addressId;
  final double totalAmount;
  final int currentIndex;
  final int value;

  AddressCard({Key key, this.model, this.currentIndex, this.addressId, this.totalAmount, this.value}) : super(key: key);

  @override
  _AddressCardState createState() => _AddressCardState();
}

class _AddressCardState extends State<AddressCard> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: ()
      {
        Provider.of<AddressChanger>(context, listen: false).displayResult(widget.value);
      },
      child: Card(
        color: Colors.blueGrey.withOpacity(0.4),
        child: Column(
          children: [
            Row(
              children: [
                Radio(
                  groupValue: widget.currentIndex,
                  value: widget.value,
                  activeColor: Colors.green,
                  onChanged: (val)
                  {
                    Provider.of<AddressChanger>(context, listen: false).displayResult(val);
                  },
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.all(10.0),
                      width: screenWidth * 0.8,
                      child: Table(
                        children: [

                          TableRow(
                              children: [
                                KeyText(msg: "Name :",),
                                Text(widget.model.name,style: TextStyle(color: Colors.white, fontFamily: "Poppins",fontSize: 16.0)),
                              ]
                          ),

                          TableRow(
                              children: [
                                KeyText(msg: "Phone Number :",),
                                Text(widget.model.phoneNumber,style: TextStyle(color: Colors.white, fontFamily: "Poppins",fontSize: 16.0)),

                              ]
                          ),

                          TableRow(
                              children: [
                                KeyText(msg: "Email Id :",),
                                Text(widget.model.flatNumber,style: TextStyle(color: Colors.white, fontFamily: "Poppins",fontSize: 16.0)),
                              ]
                          ),

                          TableRow(
                              children: [
                                KeyText(msg: "Semester :",),
                                Text(widget.model.semester,style: TextStyle(color: Colors.white, fontFamily: "Poppins",fontSize: 16.0)),
                              ]
                          ),

                          TableRow(
                              children: [
                                KeyText(msg: "Time Slot :",),
                                Text(widget.model.city,style: TextStyle(color: Colors.white, fontFamily: "Poppins",fontSize: 16.0)),
                              ]
                          ),

                          TableRow(
                              children: [
                                KeyText(msg: "Message :",),
                                Text(widget.model.state,style: TextStyle(color: Colors.white, fontFamily: "Poppins",fontSize: 16.0)),
                              ]
                          ),

                          TableRow(
                              children: [
                                KeyText(msg: "Pin Code : ",),
                                Text(widget.model.pincode,style: TextStyle(color: Colors.white, fontFamily: "Poppins",fontSize: 16.0)),
                              ]
                          ),

                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            widget.value == Provider.of<AddressChanger>(context).count
                ? WideButton(
              message: "Proceed",
              onPressed: ()
              {
                Route route = MaterialPageRoute(builder: (c) => PaymentPage(
                  addressId: widget.addressId,
                ));
                Navigator.push(context, route);
              },
            )
                : Container(),
          ],
        ),
      ),
    );
  }
}





class KeyText extends StatelessWidget
{
  final String msg;

  KeyText({Key key, this.msg}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      msg,
      style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold,fontFamily: "Poppins",fontSize: 16.0),
    );
  }
}
