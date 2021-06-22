import 'package:e_shop/BottomNavHomePage.dart';
import 'package:e_shop/Config/config.dart';
import 'package:e_shop/Counters/cartitemcounter.dart';
import 'package:e_shop/Store/cart.dart';
import 'package:e_shop/Store/storehome.dart';
import 'package:e_shop/Models/address.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:date_format/date_format.dart';


// class AddAddress extends StatelessWidget {
//
//   final formKey = GlobalKey<FormState>();
//   final scaffoldKey = GlobalKey<ScaffoldState>();
//   final cName = TextEditingController();
//   final cPhoneNumber = TextEditingController();
//   final cFlatHomeNumber = TextEditingController();
//   final cCity = TextEditingController();
//   final cState = TextEditingController();
//   final cPinCode = TextEditingController();
//   final cSemester = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         floatingActionButton: FloatingActionButton.extended(
//           onPressed: () {
//             if(formKey.currentState.validate())
//             {
//               final model = AddressModel(
//                 name:  cName.text.trim(),
//                 state: cState.text.trim(),
//                 pincode: cPinCode.text,
//                 phoneNumber: cPhoneNumber.text,
//                 flatNumber: cFlatHomeNumber.text,
//                 city: cCity.text.trim(),
//                 semester: cSemester.text.trim()
//               ).toJson();
//
//               //add to firestore
//               EcommerceApp.firestore.collection(EcommerceApp.collectionUser)
//                   .document(EcommerceApp.sharedPreferences.getString(EcommerceApp.userUID))
//                   .collection(EcommerceApp.subCollectionAddress)
//                   .document(DateTime.now().millisecondsSinceEpoch.toString())
//                   .setData(model)
//                   .then((value){
//                     Fluttertoast.showToast(msg: "New Details added successfully.");
//                 FocusScope.of(context).requestFocus(FocusNode());
//                 formKey.currentState.reset();
//               });
//
//               Route route = MaterialPageRoute(builder: (c) => BottomNavBar());
//               Navigator.pushReplacement(context, route);
//             }
//           },
//           label: Text(
//             "Save",
//             style: TextStyle(color: Colors.white, fontFamily: "Poppins"),
//           ),
//           backgroundColor: Colors.green,
//           icon: Icon(
//             Icons.check,
//             color: Colors.white,
//           ),
//         ),
//         appBar: AppBar(
//           title: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text(
//                 "v",
//                 style: TextStyle(
//                   fontFamily: "Signatra",
//                   fontSize: 45.0,
//                 ),
//               ),
//               Text(
//                 "Care",
//                 style: TextStyle(
//                     fontFamily: "Signatra",
//                     fontSize: 45.0,
//                     color: Colors.green),
//               ),
//             ],
//           ),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.vertical(bottom: Radius.circular(16.0)),
//           ),
//           centerTitle: true,
//           actions: [
//             Stack(
//               children: [
//                 IconButton(
//                     onPressed: () {
//                       Navigator.push(context,
//                           MaterialPageRoute(builder: (context) => CartPage()));
//                     },
//                     icon: Icon(Icons.queue_play_next)),
//                 Positioned(
//                     child: Stack(
//                   children: [
//                     Icon(
//                       Icons.brightness_1,
//                       size: 20.0,
//                       color: Colors.green,
//                     ),
//                     Positioned(
//                         top: 3.0,
//                         bottom: 4.0,
//                         left: 6.0,
//                         child: Consumer<CartItemCounter>(
//                           builder: (context, counter, _) {
//                             return Text(
//                               (EcommerceApp.sharedPreferences
//                                           .getStringList(
//                                               EcommerceApp.userCartList)
//                                           .length -
//                                       1)
//                                   .toString(),
//                               style: TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 12.0,
//                                   fontWeight: FontWeight.w500,
//                                   fontFamily: "Poppins"),
//                             );
//                           },
//                         ))
//                   ],
//                 ))
//               ],
//             ),
//             SizedBox(
//               width: 10.0,
//             ),
//           ],
//         ),
//         body: SingleChildScrollView(
//           child: Column(
//             children: [
//               Align(
//                 alignment: Alignment.centerLeft,
//                 child: Padding(
//                   padding: EdgeInsets.all(8.0),
//                   child: Center(
//                     child: Text(
//                       "Add your details",
//                       style: TextStyle(
//                         fontFamily: "Poppins",
//                         fontWeight: FontWeight.bold,
//                         fontSize: 20.0
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//           Form(
//             key: formKey,
//             child: Column(
//               children: [
//                 MyTextField(
//                   label: "Name",
//                   hint: "Name",
//                   controller: cName,
//                 ),
//                 MyTextField(
//                   label: "Phone Number",
//                   hint: "Phone Number",
//                   controller: cPhoneNumber,
//                 ),
//                 MyTextField(
//                   label: "Email Id",
//                   hint: "Email Id",
//                   controller: cFlatHomeNumber,
//                 ),
//                 MyTextField(
//                   label: "Semester",
//                   hint: "Semester",
//                   controller: cSemester,
//                 ),
//                 MyTextField(
//                   label: "Preferred Time Slot",
//                   hint: "Preferred Time Slot",
//                   controller: cCity,
//                 ),
//                 MyTextField(
//                   label: "Message",
//                   hint: "Message",
//                   controller: cState,
//                 ),
//                 MyTextField(
//                   label: "Pin Code",
//                   hint: "Pin Code",
//                   controller: cPinCode,
//                 ),
//               ],
//             ),
//           )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }


class AddAddress extends StatefulWidget {

  @override
  _AddAddressState createState() => _AddAddressState();
}

class _AddAddressState extends State<AddAddress> with TickerProviderStateMixin {

  ScrollController scrollController;
  bool dialVisible = true;
  String _setTime;

  String _hour, _minute, _time;

  String dateTime;
  TimeOfDay selectedTime = TimeOfDay(hour: 00, minute: 00);

  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final cName = TextEditingController();
  final cPhoneNumber = TextEditingController();
  final cFlatHomeNumber = TextEditingController();
  final cCity = TextEditingController();
  final cState = TextEditingController();
  final cPinCode = TextEditingController();
  final cSemester = TextEditingController();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkDialogIntroShown();
    scrollController = ScrollController()
      ..addListener(() {
        setDialVisible(scrollController.position.userScrollDirection ==
            ScrollDirection.forward);
      });
  }

  Future<Null> _selectTime(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null)
      setState(() {
        selectedTime = picked;
        _hour = selectedTime.hour.toString();
        _minute = selectedTime.minute.toString();
        _time = _hour + ' : ' + _minute;
        cCity.text = _time;
        cCity.text = formatDate(
            DateTime(2019, 08, 1, selectedTime.hour, selectedTime.minute),
            [hh, ':', nn, " ", am]).toString();
      });
  }

  void setDialVisible(bool value) {
    setState(() {
      dialVisible = value;
    });
  }

  Widget buildBody() {
    return ListView.builder(
      controller: scrollController,
      itemCount: 30,
      itemBuilder: (ctx, i) => ListTile(title: Text('Item $i')),
    );
  }

  SpeedDial buildSpeedDial() {
    return SpeedDial(
      marginEnd: 18,
      marginBottom: 20,
      icon: Icons.check,
      activeIcon: Icons.remove,
      buttonSize: 56.0,
      visible: true,
      closeManually: false,
      curve: Curves.bounceIn,
      overlayColor: Colors.black,
      overlayOpacity: 0.5,
      onOpen: () => print('OPENING DIAL'),
      onClose: () => print('DIAL CLOSED'),
      tooltip: 'Click Here to save you details',
      heroTag: 'speed-dial-hero-tag',
      backgroundColor: Colors.green,
      foregroundColor: Colors.white,
      elevation: 8.0,
      shape: CircleBorder(),
      gradientBoxShape: BoxShape.circle,
      children: [
        SpeedDialChild(
          child: Icon(Icons.group_work_rounded),
          backgroundColor: Colors.orange,
          label: 'Save Anonymously',
          labelStyle: TextStyle(fontSize: 18.0),
          onTap: () {
            if (formKey.currentState.validate()) {
              final model = AddressModel(
                  name: "[Anonymous]\n${cName.text.trim()}",
                  state: "[Anonymous]\n${cState.text.trim()}",
                  pincode: "[Anonymous]\n${cPinCode.text.trim()}",
                  phoneNumber: "[Anonymous]\n${cPhoneNumber.text.trim()}",
                  flatNumber: "[Anonymous]\n${cFlatHomeNumber.text.trim()}",
                  city: "[Anonymous]\n${cCity.text.trim()}",
                  semester: "[Anonymous]\n${cSemester.text.trim()}")
                  .toJson();

              //add to firestore
              EcommerceApp.firestore
                  .collection(EcommerceApp.collectionUser)
                  .document(EcommerceApp.sharedPreferences
                  .getString(EcommerceApp.userUID))
                  .collection(EcommerceApp.subCollectionAddress)
                  .document(DateTime.now().millisecondsSinceEpoch.toString())
                  .setData(model)
                  .then((value) {
                Fluttertoast.showToast(msg: "New Details added Anonymously.");
                FocusScope.of(context).requestFocus(FocusNode());
                formKey.currentState.reset();
              });

              Route route = MaterialPageRoute(builder: (c) => StoreHome());
              Navigator.pushReplacement(context, route);
            }
          },
          onLongPress: () {
            Fluttertoast.showToast(
                msg:
                "Click here to save your details anonymously. Your info only will be visible to you");
          },
        ),
        SpeedDialChild(
          child: Icon(Icons.check),
          backgroundColor: Colors.blue,
          label: 'Save',
          labelStyle: TextStyle(fontSize: 18.0),
          onTap: () {
            if (formKey.currentState.validate()) {
              final model = AddressModel(
                  name: cName.text.trim(),
                  state: cState.text.trim(),
                  pincode: cPinCode.text,
                  phoneNumber: cPhoneNumber.text,
                  flatNumber: cFlatHomeNumber.text,
                  city: cCity.text.trim(),
                  semester: cSemester.text.trim())
                  .toJson();

              //add to firestore
              EcommerceApp.firestore
                  .collection(EcommerceApp.collectionUser)
                  .document(EcommerceApp.sharedPreferences
                  .getString(EcommerceApp.userUID))
                  .collection(EcommerceApp.subCollectionAddress)
                  .document(DateTime.now().millisecondsSinceEpoch.toString())
                  .setData(model)
                  .then((value) {
                Fluttertoast.showToast(msg: "New Details added successfully.");
                FocusScope.of(context).requestFocus(FocusNode());
                formKey.currentState.reset();
              });

              Route route = MaterialPageRoute(builder: (c) => StoreHome());
              Navigator.pushReplacement(context, route);
            }
          },
          onLongPress: () {
            Fluttertoast.showToast(
                msg:
                "Click here to save your information. Your info will be visible to vCare");
          },
        ),
        SpeedDialChild(
          child: Icon(Icons.transit_enterexit),
          backgroundColor: Colors.red,
          label: 'Close',
          labelStyle: TextStyle(fontSize: 18.0),
          onTap: () => print("Pressed"),
          onLongPress: () {
            Fluttertoast.showToast(msg: "Click here to cancel");
          },
        ),
      ],
    );
  }

  Future checkDialogIntroShown() async {
    SharedPreferences userAddYourDetailsHomePageSeen = await SharedPreferences.getInstance();
    bool _seen = (userAddYourDetailsHomePageSeen.getBool('seenUserAddYourDetailsHomePageSeen') ?? false);

    if (_seen) {


    }
    else{
      await userAddYourDetailsHomePageSeen.setBool('seenUserAddYourDetailsHomePageSeen', true);
      //showAlertDialog(context);
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => CustomAlertDialog(
          title: "Hey ${EcommerceApp.sharedPreferences.getString(EcommerceApp.userName)} !",
          desc: "Here you can add your details so that we can contact you. If you want meeting to be Anonymous then click on 'save anonymously'. If you have any kind of suggestions regarding appointment you can enter in message text field our mods will consider it",
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    dateTime = DateFormat.yMd().format(DateTime.now());
    return SafeArea(
      child: Scaffold(
        floatingActionButton: buildSpeedDial(),
        // floatingActionButton: FloatingActionButton.extended(
        //   onPressed: () {
        //     if(formKey.currentState.validate())
        //     {
        //       final model = AddressModel(
        //           name:  cName.text.trim(),
        //           state: cState.text.trim(),
        //           pincode: cPinCode.text,
        //           phoneNumber: cPhoneNumber.text,
        //           flatNumber: cFlatHomeNumber.text,
        //           city: cCity.text.trim(),
        //           semester: cSemester.text.trim()
        //       ).toJson();
        //
        //       //add to firestore
        //       EcommerceApp.firestore.collection(EcommerceApp.collectionUser)
        //           .document(EcommerceApp.sharedPreferences.getString(EcommerceApp.userUID))
        //           .collection(EcommerceApp.subCollectionAddress)
        //           .document(DateTime.now().millisecondsSinceEpoch.toString())
        //           .setData(model)
        //           .then((value){
        //         Fluttertoast.showToast(msg: "New Details added successfully.");
        //         FocusScope.of(context).requestFocus(FocusNode());
        //         formKey.currentState.reset();
        //       });
        //
        //       Route route = MaterialPageRoute(builder: (c) => BottomNavBar());
        //       Navigator.of(context).pushAndRemoveUntil(route, (Route<dynamic> route) => false);
        //     }
        //   },
        //   label: Text(
        //     "Save",
        //     style: TextStyle(color: Colors.white, fontFamily: "Poppins"),
        //   ),
        //   backgroundColor: Colors.green,
        //   icon: Icon(
        //     Icons.check,
        //     color: Colors.white,
        //   ),
        // ),
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
        body: SingleChildScrollView(
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                      "Add your details",
                      style: TextStyle(
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0
                      ),
                    ),
                  ),
                ),
              ),
              Form(
                key: formKey,
                child: Column(
                  children: [
                    MyTextField(
                      label: "Name",
                      hint: "Name",
                      controller: cName,
                    ),
                    MyTextField(
                      label: "Phone Number",
                      hint: "Phone Number",
                      controller: cPhoneNumber,
                    ),
                    MyTextField(
                      label: "Email Id",
                      hint: "Email Id",
                      controller: cFlatHomeNumber,
                    ),
                    MyTextField(
                      label: "Semester",
                      hint: "Semester",
                      controller: cSemester,
                    ),
                    InkWell(
                      onTap: () {
                        _selectTime(context);
                      },
                      child: Container(
                        margin: const EdgeInsets.all(8.0),
                        padding: EdgeInsets.only(left: 10.0),
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.white,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(15))
                        ),
                        child: TextFormField(
                          // controller: controller,
                          // decoration: InputDecoration.collapsed(hintText: hint),
                          // validator: (val) => val.isEmpty ? "Field can not be empty." : null,
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          controller: cCity,
                          onSaved: (String val) {
                            _setTime = val;
                          },
                          enabled: false,
                          style: TextStyle(color: Colors.white,fontFamily: "Poppins"),
                          cursorColor: Colors.grey[300],
                          decoration: InputDecoration(
                            hintText: "Select Time",
                            hintStyle: TextStyle(color: Colors.grey[300], fontFamily: "Poppins"),
                            labelStyle: TextStyle(color: Colors.grey[300], fontSize: 20.0,fontFamily: "Poppins"),
                            //border: InputBorder.none,
                            labelText: "Preferred Time",
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              borderSide: BorderSide(
                                color: Colors.grey[300],
                                width: 1.0,
                              ),
                            ),
                          ),
                          validator: (val) => val.isEmpty ? "Field can not be empty." : null,
                        ),
                      ),
                    ),
                    MyTextField(
                      label: "Message",
                      hint: "Message",
                      controller: cState,
                    ),
                    MyTextField(
                      label: "Pin Code",
                      hint: "Pin Code",
                      controller: cPinCode,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}


class MyTextField extends StatelessWidget {
  final String hint;
  final String label;
  final TextEditingController controller;

  MyTextField({Key key, this.hint, this.controller, this.label,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: TextFormField(
        // controller: controller,
        // decoration: InputDecoration.collapsed(hintText: hint),
        // validator: (val) => val.isEmpty ? "Field can not be empty." : null,
        keyboardType: TextInputType.multiline,
        maxLines: null,
        controller: controller,
        style: TextStyle(color: Colors.white,fontFamily: "Poppins"),
        cursorColor: Colors.grey[300],
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: Colors.grey[300], fontFamily: "Poppins"),
          labelStyle: TextStyle(color: Colors.grey[300], fontSize: 20.0,fontFamily: "Poppins"),
          //border: InputBorder.none,
          labelText: label,
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
              borderSide: BorderSide(color: Colors.green, width: 1.0)),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: BorderSide(
              color: Colors.grey[300],
              width: 1.0,
            ),
          ),
        ),
        validator: (val) => val.isEmpty ? "Field can not be empty." : null,
      ),
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