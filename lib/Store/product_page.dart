import 'package:e_shop/Config/config.dart';
import 'package:e_shop/Counters/cartitemcounter.dart';
import 'package:e_shop/Store/cart.dart';
import 'package:e_shop/Widgets/customAppBar.dart';
import 'package:e_shop/Widgets/myDrawer.dart';
import 'package:e_shop/Models/item.dart';
import 'package:flutter/material.dart';
import 'package:e_shop/Store/storehome.dart';
import 'package:provider/provider.dart';


class ProductPage extends StatefulWidget {
  final ItemModel itemModel;

  const ProductPage({Key key, this.itemModel}) : super(key: key);

  @override
  _ProductPageState createState() => _ProductPageState();
}



class _ProductPageState extends State<ProductPage> {
  int quantityOfItems = 1;

  @override
  Widget build(BuildContext context)
  {
    double _screenWidth = MediaQuery.of(context).size.width;
    Size screenSize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            widget.itemModel.title,
            style: TextStyle(
                color: Colors.white,
              fontFamily: "Poppins"
            ),
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
                    icon: Icon(Icons.send_outlined)),
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
                                  (EcommerceApp.sharedPreferences.getStringList(EcommerceApp.userCartList).length -1).toString(),                                  style: TextStyle(
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
        body: ListView(
          children: [
            Container(
              padding: EdgeInsets.only(top: 8.0,bottom: 8.0,right: 6.0,left: 4.0),
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child:Material(
                            borderRadius: BorderRadius.all(Radius.circular(80.0)),
                            elevation: 8.0,
                            child: Container(
                              decoration: new BoxDecoration(
                                shape: BoxShape.circle,
                                border: new Border.all(
                                  color: Colors.blueGrey,
                                  width: 3.0,
                                ),
                              ),
                              height: 190.0,
                              width: 190.0,
                              child: CircleAvatar(
                                backgroundImage: NetworkImage(
                                  widget.itemModel.thumbnailUrl,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.all(15.0),
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Text(
                              widget.itemModel.title,
                              style: boldTextStyle
                            ),
                          ),
                          SizedBox(height: 10.0,),
                          Center(
                            child: Text(
                                widget.itemModel.shortInfo,
                                style: TextStyle(color: Colors.grey, fontSize: 17,fontFamily: "Poppins"),
                            ),
                          ),
                          SizedBox(height: 10.0,),
                          Center(
                            child: ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10.0),
                                          side: BorderSide(color: Colors.green, width: 1.0)))),
                              child: Text(widget.itemModel.tag,style: TextStyle(fontFamily: "Poppins"),),
                              onPressed: () {
                                if(widget.itemModel.tag=="Mentor"){
                                  showDialog(
                                    barrierDismissible: false,
                                    context: context,
                                    builder: (context) => AlertDialogForTagDetails(
                                      title: "who is mentor?",
                                      message:  "Mentor are the expert who will guide you to achieve your goal",
                                    ),
                                  );
                                }
                                else if(widget.itemModel.tag=="Listener"){
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
                          SizedBox(height: 10.0,),
                          Text(
                            widget.itemModel.longDescription,
                            style: TextStyle(color: Colors.white, fontSize: 17,fontFamily: "Poppins"),
                          ),
                          SizedBox(height: 30.0,),
                          Row(
                            children: [
                              Expanded(
                                  child: Text(
                                    "Status : " ,
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontFamily: "Poppins",
                                        color: Colors.green
                                    ),
                                  )
                              ),
                              Expanded(
                                  child: Text(
                                      widget.itemModel.status,
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontFamily: "Poppins",
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold
                                    ),
                                  )
                              )
                            ],
                          ),
                          Divider(),
                          Row(
                            children: [
                              Expanded(
                                  child: Text(
                                    "Available Between : " ,
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontFamily: "Poppins",
                                        color: Colors.green
                                    ),
                                  )
                              ),
                              Expanded(
                                  child: Text(
                                    widget.itemModel.price,
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontFamily: "Poppins",
                                        color: Colors.white,
                                      fontWeight: FontWeight.bold
                                    ),
                                  )
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 8.0),
                    child: Center(
                      child: Container(
                        width: _screenWidth * 0.9,
                        height: _screenWidth * 0.11,
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                              side: BorderSide(color: Colors.white)),
                          onPressed: () => checkItemInCart(widget.itemModel.shortInfo, context,widget.itemModel.title),
                          child: Text(
                            "Book Now",
                            style: TextStyle(
                              fontSize: 19.0,
                              fontFamily: "Poppins",
                            ),
                          ),
                          color: Colors.green,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 50.0,),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

}

const boldTextStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 20,fontFamily: "Poppins");
const largeTextStyle = TextStyle(fontWeight: FontWeight.normal, fontSize: 20);
