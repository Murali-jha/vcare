import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop/Orders/OrderDetailsPage.dart';
import 'package:e_shop/Models/item.dart';
import 'package:flutter/material.dart';
import '../Store/storehome.dart';

int counter = 0;
class OrderCard extends StatelessWidget
{
  final int itemCount;
  final List<DocumentSnapshot> data;
  final String orderID;

  OrderCard({Key key, this.itemCount, this.data, this.orderID,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  InkWell(

      onTap: ()
      {
        Route route;
        if(counter == 0)
        {
          counter = counter + 1;
          route = MaterialPageRoute(builder: (c) => OrderDetails(orderID: orderID));
        }
        Navigator.push(context, route);
      },
      child: Container(
        color: Colors.black38,
        padding: EdgeInsets.all(10.0),
        margin: EdgeInsets.all(10.0),
        height: itemCount * 210.0,
        child: ListView.builder(
          itemCount: itemCount,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (c, index)
          {
            ItemModel model = ItemModel.fromJson(data[index].data);
            return sourceOrderInfo(model, context);
          },
        ),
      ),
    );
  }
}



Widget sourceOrderInfo(ItemModel model, BuildContext context,
    {Color background})
{
  width =  MediaQuery.of(context).size.width;

  return Container(
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
                    ),
                  ],
                ),
                //Implement cart item remove feature
              ],
            )),
      ],
    ),
  );
}
