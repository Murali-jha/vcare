import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_shop/Widgets/loadingWidget.dart';
import 'package:e_shop/Widgets/myDrawer.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';

class HelpHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(16.0)),
        ),
        centerTitle: true,
        title: Text(
          "How to use?",
          style: TextStyle(
              fontFamily: "Poppins",
              fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Theme(
          data: Theme.of(context).copyWith(accentColor: Colors.white, unselectedWidgetColor:  Colors.white,),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                    color: Colors.black38,
                    border: Border.all(
                      color: Colors.green,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(12))
                ),
                child: ExpansionTile(
                  title: Text("How to book an appointment?",style: TextStyle(fontFamily: "Poppins",fontSize: 18.0,),),
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.fromLTRB(17.0,10.0,17.0,10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("You can book an appointment in simple three steps:",style: TextStyle(fontFamily: "Poppins",fontSize: 17.0),),
                          Center(
                            child: OutlineButton(
                                onPressed: null,
                                color: Colors.white,
                                child: Text("Step 1",style: TextStyle(color: Colors.white,fontSize: 18.0,fontFamily: "Poppins"),), shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0))
                            ),
                          ),
                          Text("Click book button. You can click book button in two ways :",style: TextStyle(fontFamily: "Poppins",fontSize: 16.0),),
                          ListTile(
                            title: Text("By just clicking a 'Book' button at bottom right corner of a profile as shown in the below figure",
                              style: TextStyle(fontSize: 17.0,fontFamily: "Poppins"),

                            ),
                            leading: Icon(Icons.looks_one_rounded),
                          ),
                          Container(
                            child: CachedNetworkImage(
                              imageUrl: "https://drive.google.com/uc?export=view&id=18ax6i3OkN5ojQMfiLt0MyxjdTXwGyGCN",
                              placeholder: (context, url) => circularProgress(),
                              errorWidget: (context, url, error) => Icon(Icons.error),
                            ),
                          ),
                          ListTile(
                            title: Text("By just clicking on 'Book Now' button in expert detail page as show in below figure",
                              style: TextStyle(fontSize: 17.0,fontFamily: "Poppins"),

                            ),
                            leading: Icon(Icons.looks_two_rounded),
                          ),
                          Container(
                            child: CachedNetworkImage(
                              imageUrl: "https://drive.google.com/uc?export=view&id=1kFAfyc7SAxAA8scKoONONpoiH1IfLNzp",
                              placeholder: (context, url) => circularProgress(),
                              errorWidget: (context, url, error) => Icon(Icons.error),
                            ),
                          ),                          Center(
                            child: OutlineButton(
                                onPressed: null,
                                color: Colors.white,
                                child: Text("Step 2",style: TextStyle(color: Colors.white,fontSize: 18.0,fontFamily: "Poppins"),), shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0))
                            ),
                          ),
                          Text("After clicking on Book button a pop up with proceed message will be shown. So click proceed as shown in figure.",style: TextStyle(fontFamily: "Poppins",fontSize: 16.0),),
                          Container(
                            child: CachedNetworkImage(
                              imageUrl: "https://drive.google.com/uc?export=view&id=1YkQiFNBVUefrKRN-2Yv2epjhaCYoxE8Z",
                              placeholder: (context, url) => circularProgress(),
                              errorWidget: (context, url, error) => Center(child: Icon(Icons.error)),
                            ),
                          ),                          ListTile(
                            title: Text("Now click on book slot button at bottom right corner as shown in figure",
                              style: TextStyle(fontSize: 17.0,fontFamily: "Poppins"),

                            ),
                            leading: Icon(Icons.double_arrow),
                          ),
                          Container(
                            child: CachedNetworkImage(
                              imageUrl: "https://drive.google.com/uc?export=view&id=1Th9TduGXxcsRXkWrJcFRDjCvDOXe9rGm",
                              placeholder: (context, url) => circularProgress(),
                              errorWidget: (context, url, error) => Icon(Icons.error),
                            ),
                          ),                          Center(
                            child: OutlineButton(
                                onPressed: null,
                                color: Colors.white,
                                child: Text("Step 3",style: TextStyle(color: Colors.white,fontSize: 18.0,fontFamily: "Poppins"),), shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0))
                            ),
                          ),
                          Text("Now you will be directed to details page where you have to select yor details",style: TextStyle(fontFamily: "Poppins",fontSize: 16.0),),
                          ListTile(
                            title: Text("If you have added your details already then just click on proceed else click on add new details",
                              style: TextStyle(fontSize: 17.0,fontFamily: "Poppins"),

                            ),
                            leading: Icon(Icons.double_arrow),
                          ),
                          Container(
                            child: CachedNetworkImage(
                              imageUrl: "https://drive.google.com/uc?export=view&id=12WPmUFT3oROOEzU1JCkasKVG3blS2Lvv",
                              placeholder: (context, url) => circularProgress(),
                              errorWidget: (context, url, error) => Icon(Icons.error),
                            ),
                          ),                          ListTile(
                            title: Text("After clicking on proceed you will be directed to confirmation page. Now just click on confirm appointment",
                              style: TextStyle(fontSize: 17.0,fontFamily: "Poppins"),

                            ),
                            leading: Icon(Icons.double_arrow),
                          ),
                          Container(
                            child: CachedNetworkImage(
                              imageUrl: "https://drive.google.com/uc?export=view&id=1B1K2YPOjxizPgnRT22TTpIVaQ8QIK6Hv",
                              placeholder: (context, url) => circularProgress(),
                              errorWidget: (context, url, error) => Icon(Icons.error),
                            ),
                          ),
                          Text("Congratulations you appointment request have been taken you will receive confirmation mail within 15-30minutes",style: TextStyle(fontFamily: "Poppins",fontSize: 16.0),),
                        ],
                      ),
                    )
                  ],
                ),
              ),



              SizedBox(height: 14.0,),
              //How to book an appointment anonymously
              Container(
                decoration: BoxDecoration(
                    color: Colors.black38,
                    border: Border.all(
                      color: Colors.blueGrey,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(12))
                ),
                child: ExpansionTile(
                  title: Text("How to book an appointment anonymously?",style: TextStyle(fontFamily: "Poppins",fontSize: 18.0,),),
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.fromLTRB(17.0,10.0,17.0,10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                            title: Text("It is very simple after entering your details click save button at bottom right corner",
                              style: TextStyle(fontSize: 17.0,fontFamily: "Poppins"),

                            ),
                            leading: Icon(Icons.looks_one),
                          ),
                          Container(
                            child: CachedNetworkImage(
                              imageUrl: "https://drive.google.com/uc?export=view&id=1MgihWRwENYOeKFvCsqLM0_kt1DZs9AhZ",
                              placeholder: (context, url) => circularProgress(),
                              errorWidget: (context, url, error) => Center(child: Icon(Icons.error)),
                            ),
                          ),
                          ListTile(
                            title: Text("Then you will have two option either to save normally or save anonymously. Click on save anonymously. ",
                              style: TextStyle(fontSize: 17.0,fontFamily: "Poppins"),

                            ),
                            leading: Icon(Icons.looks_two),
                          ),
                          Container(
                            child: CachedNetworkImage(
                              imageUrl: "https://drive.google.com/uc?export=view&id=1ZGJ3nW9e64UxISRzyM43NKReuYTzMAuC",
                              placeholder: (context, url) => circularProgress(),
                              errorWidget: (context, url, error) => Center(child: Icon(Icons.error)),
                            ),
                          ),
                          Text("That's it! your details have been saved successfully. No one can see your details except you.",style: TextStyle(fontSize: 17.0,fontFamily: "Poppins"),)

          ],
                      ),
                    )
                  ],
                ),
              ),




              SizedBox(height: 14.0,),
              //Who are listeners
              Container(
                decoration: BoxDecoration(
                    color: Colors.black38,
                    border: Border.all(
                      color: Colors.blueGrey,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(12))
                ),
                child: ExpansionTile(
                  title: Text("Who are Listeners?",style: TextStyle(fontFamily: "Poppins",fontSize: 18.0,),),
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.fromLTRB(17.0,10.0,17.0,10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Listener is a person from Student community with whom you can share anything. He is like an unknown friend to you. Here he is not going to judge you in anyway. You can feel free to book a slot with him and have a talk.",style: TextStyle(fontFamily: "Poppins",fontSize: 16.0),),
                        ],
                      ),
                    )
                  ],
                ),
              ),

              SizedBox(height: 14.0,),
              //Who are Mentors
              Container(
                decoration: BoxDecoration(
                    color: Colors.black38,
                    border: Border.all(
                      color: Colors.blueGrey,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(12))
                ),
                child: ExpansionTile(
                  title: Text("Who are Mentors?",style: TextStyle(fontFamily: "Poppins",fontSize: 18.0,),),
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.fromLTRB(17.0,10.0,17.0,10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Mentor is an experienced person with whom you can share anything. He is like an unknown friend to you. Here he is not going to judge you in anyway. He is going to solve your any queries. He will help you out solve and overcome you problems and guide you. You can feel free to book a slot with him and have a talk.",style: TextStyle(fontFamily: "Poppins",fontSize: 16.0),),
                        ],
                      ),
                    )
                  ],
                ),
              ),



              SizedBox(height: 14.0,),
              //Who are Counsellors
              Container(
                decoration: BoxDecoration(
                    color: Colors.black38,
                    border: Border.all(
                      color: Colors.blueGrey,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(12))
                ),
                child: ExpansionTile(
                  title: Text("Who are Counsellors?",style: TextStyle(fontFamily: "Poppins",fontSize: 18.0,),),
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.fromLTRB(17.0,10.0,17.0,10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Counsellors is an experienced person with whom you can share anything. He is like an mentor to you. A mental health counselor (MHC), or counselor, is a person who works with individuals and groups to promote optimum mental and emotional health. Such persons may help individuals deal with issues associated with addiction and substance abuse; family, parenting, and marital problems; stress management; self-esteem; and aging.You can feel free to book a slot with him and have a talk.",style: TextStyle(fontFamily: "Poppins",fontSize: 16.0),),
                        ],
                      ),
                    )
                  ],
                ),
              ),



              SizedBox(height: 14.0,),
              //What is feed & updates
              Container(
                decoration: BoxDecoration(
                    color: Colors.black38,
                    border: Border.all(
                      color: Colors.blueGrey,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(12))
                ),
                child: ExpansionTile(
                  title: Text("What is feed & updates?",style: TextStyle(fontFamily: "Poppins",fontSize: 18.0,),),
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.fromLTRB(17.0,10.0,17.0,10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("It is a page which will keep you up to date. Here you can a posts about new events conducted by vCare, Inspirational Posts, Unknown facts, etc..",style: TextStyle(fontFamily: "Poppins",fontSize: 16.0),),
                        ],
                      ),
                    )
                  ],
                ),
              ),

              SizedBox(height: 14.0,),
              //What is task and fun
              Container(
                decoration: BoxDecoration(
                    color: Colors.black38,
                    border: Border.all(
                      color: Colors.blueGrey,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(12))
                ),
                child: ExpansionTile(
                  title: Text("What is tasks?",style: TextStyle(fontFamily: "Poppins",fontSize: 18.0,),),
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.fromLTRB(17.0,10.0,17.0,10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("It is most interesting page where vCare will be posting a new tasks and questionnaire for self assessment. And after filling your questionnaire vCare will be sending your report by mail. And also after filling each questionnaire you will be receiving a 'CryptoV coins' and after completing your targets you will be receiving rewards from vCare",style: TextStyle(fontFamily: "Poppins",fontSize: 16.0),),
                        ],
                      ),
                    )
                  ],
                ),
              ),

              SizedBox(height: 14.0,),
              //What is CryptoV coins
              Container(
                decoration: BoxDecoration(
                    color: Colors.black38,
                    border: Border.all(
                      color: Colors.blueGrey,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(12))
                ),
                child: ExpansionTile(
                  title: Text("Are CryptoV Coins a Cryptocurrency?",style: TextStyle(fontFamily: "Poppins",fontSize: 16.0,),),
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.fromLTRB(17.0,10.0,17.0,10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("No. CryptoV coins are simply the coins generated by vCare rewarded to the user to help them get surprises.",style: TextStyle(fontFamily: "Poppins",fontSize: 16.0),),
                        ],
                      ),
                    )
                  ],
                ),
              ),


              SizedBox(height: 14.0,),
              //What is CryptoV coins
              Container(
                decoration: BoxDecoration(
                    color: Colors.black38,
                    border: Border.all(
                      color: Colors.blueGrey,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(12))
                ),
                child: ExpansionTile(
                  title: Text("when will I receive 1000 CryptoV coins?",style: TextStyle(fontFamily: "Poppins",fontSize: 16.0,),),
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.fromLTRB(17.0,10.0,17.0,10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("No worries, after completing tasks daily soon, you will receive exciting rewards and surprises delivered at your doorsteps.",style: TextStyle(fontFamily: "Poppins",fontSize: 16.0),),
                        ],
                      ),
                    )
                  ],
                ),
              ),

              SizedBox(height: 14.0,),
              //What is CryptoV coins
              Container(
                decoration: BoxDecoration(
                    color: Colors.black38,
                    border: Border.all(
                      color: Colors.blueGrey,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(12))
                ),
                child: ExpansionTile(
                  title: Text("What is CryptoV Coins?",style: TextStyle(fontFamily: "Poppins",fontSize: 18.0,),),
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.fromLTRB(17.0,10.0,17.0,10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("CryptoV coins are simply the coins generated by vCare and it is rewarded to the user to help them get surprises.",style: TextStyle(fontFamily: "Poppins",fontSize: 16.0),),
                        ],
                      ),
                    )
                  ],
                ),
              ),


            ],
          ),
        ),
      )
    );
  }

}
