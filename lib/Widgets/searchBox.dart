import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Store/Search.dart';


class SearchBoxDelegate extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context,
      double shrinkOffset,
      bool overlapsContent
      ) =>
      InkWell(
        onTap: (){
          Route route  = MaterialPageRoute(builder: (context)=> SearchProduct());
          Navigator.push(context, route);
        },
        child: Container(
          margin: EdgeInsets.only(left: 10.0,right: 10.0),
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width,
          height: 80.0,
          child: InkWell(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 50.0,
              decoration: BoxDecoration(
                color: Colors.black45,
                borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(color: Colors.grey)
              ),
              child: Row(
                children: [
                  Padding(
                      padding: EdgeInsets.only(left: 8.0),
                    child: Icon(Icons.search,color: Colors.grey,),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Text("Search Here",style: TextStyle(fontFamily: "Poppins",color: Colors.grey),),
                  ),

                ],
              ),
            ),
          ),
        ),
      );



  @override
  double get maxExtent => 80;

  @override
  double get minExtent => 80;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}


