import 'package:e_shop/Config/config.dart';
import 'package:e_shop/Store/cart.dart';
import 'package:e_shop/Counters/cartitemcounter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class MyAppBar extends StatelessWidget
    with PreferredSizeWidget {
  final PreferredSizeWidget bottom;

  MyAppBar({this.bottom});


  @override
  Widget build(BuildContext context) {
    return AppBar(
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
      bottom: bottom,
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
    );

  }


  Size get preferredSize =>
      bottom == null ? Size(56, AppBar().preferredSize.height) : Size(
          56, 80 + AppBar().preferredSize.height);
}
