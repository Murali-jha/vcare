import 'dart:io';

import 'package:e_shop/About%20App/dataOnBoarding.dart';
import 'package:e_shop/Store/storehome.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AboutAppHomePage extends StatefulWidget {

  @override
  _AboutAppHomePageState createState() => _AboutAppHomePageState();
}

class _AboutAppHomePageState extends State<AboutAppHomePage> {

  List<SliderModel> slides = new List<SliderModel>();
  int currentIndex = 0;
  PageController pageController = new PageController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    slides = getSlides();
  }


  Widget pageIndexIndicator(bool isCurrentPage){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 2.0),
      height: isCurrentPage?10.0:6.0,
      width: isCurrentPage?10.0:6.0,
      decoration: BoxDecoration(
        color: isCurrentPage ? Colors.white : Colors.grey[300],
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: PageView.builder(
        controller: pageController,
          itemCount: slides.length,
          onPageChanged: (val){
            setState(() {
              currentIndex = val;
            });
          },
          itemBuilder: (context, index) {
            return SlideTile(title: slides[index].title,
              imagePath: slides[index].imageAssetPath,
              desc: slides[index].desc,);
          }
      ),
      bottomSheet: currentIndex!=slides.length-1?
      Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        height: Platform.isIOS?70:60,
        color: Colors.blue,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: (){
                pageController.animateToPage(slides.length-1, duration: Duration(milliseconds: 400), curve: Curves.linear);
              },
                child: Text("SKIP",style: TextStyle(fontFamily: "Poppins",color: Colors.white,fontWeight: FontWeight.bold,fontSize: 16.0),)
            ),
            Row(
              children: [
                for(int i=0;i<slides.length;i++) currentIndex == i ? pageIndexIndicator(true):pageIndexIndicator(false)

              ],
            ),
            GestureDetector(
                onTap: (){
                  pageController.animateToPage(currentIndex+1, duration: Duration(milliseconds: 350), curve: Curves.linear);
                },
                child: Text("NEXT",style: TextStyle(fontFamily: "Poppins",color: Colors.white,fontWeight: FontWeight.bold,fontSize: 16.0),)
            ),
          ],
        ),
      ):
      GestureDetector(
        onTap: (){
          Route route = MaterialPageRoute(builder: (c) {
            return StoreHome();
          });
          Navigator.pushReplacement(context, route);
        },
        child: Container(
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width,
          height: Platform.isIOS?70:60,
          color: Colors.blue,
          child: Text("Get Started Now",style: TextStyle(fontFamily: "Poppins",color: Colors.white,fontWeight: FontWeight.bold,fontSize: 17.0),),
        ),
      ),
    );
  }
}

class SlideTile extends StatelessWidget {
  String imagePath, title, desc;

  SlideTile({this.imagePath, this.title, this.desc});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(imagePath),
          SizedBox(
            height: 30,
          ),
          Text(title, textAlign: TextAlign.center, style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 22,
              color: Colors.black,
              fontFamily: "Poppins",
          ),),
          SizedBox(
            height: 15,
          ),
          Text(desc, textAlign: TextAlign.center, style: TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.black,
              fontSize: 14,
              fontFamily: "Poppins"
          ))
        ],
      ),
    );
  }
}

