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
import 'package:shared_preferences/shared_preferences.dart';

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
  void initState() {
    // TODO: implement initState
    super.initState();
    checkDialogIntroShown();
  }

  Future checkDialogIntroShown() async {
    SharedPreferences userDetailsHomePageSeen = await SharedPreferences.getInstance();
    bool _seen = (userDetailsHomePageSeen.getBool('seenUserDetailsHomePageSeen') ?? false);

    if (_seen) {


    }
    else{
      await userDetailsHomePageSeen.setBool('seenUserDetailsHomePageSeen', true);
      //showAlertDialog(context);
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => CustomAlertDialog(
          title: "Hey ${EcommerceApp.sharedPreferences.getString(EcommerceApp.userName)} !",
          desc: "Please add you your details if you haven't added yet. To add your details please click 'Add new details' at bottom right corner. Please Note we collect your details only to contact you..not for any third party purposes.",
        ),
      );
    }
  }


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
            Icon(Icons.details_rounded, color: Colors.white,),
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
              Align(
                alignment: Alignment.bottomRight,
                child: FlatButton(
                  color: Colors.green,
                  onPressed: (){
                    Navigator.pop(context);
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
              backgroundImage: AssetImage("assets/gifs/7t4e.gif"),
            )
        )
      ],
    );
  }
}
