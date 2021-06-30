import 'package:e_shop/Address/address.dart';
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


class EditAddressDetailHomePage extends StatefulWidget {

  final String addressId,phoneNumber,pDate,pinCode,semester,time,reason;

  const EditAddressDetailHomePage({Key key, this.addressId, this.phoneNumber, this.pDate, this.pinCode, this.semester, this.time, this.reason}) : super(key: key);
  @override
  _EditAddressDetailHomePageState createState() => _EditAddressDetailHomePageState(addressId,phoneNumber,pDate,pinCode,semester,time,reason);
}

class _EditAddressDetailHomePageState extends State<EditAddressDetailHomePage> with TickerProviderStateMixin {
  final String addressId,phoneNumber,pDate,pinCode,semester,time,reason;  bool dialVisible = true;
  String _setTime,_setDate;
  String dropdownValue = 'Reason:';

  String _hour, _minute, _time;

  String dateTime;
  TimeOfDay selectedTime = TimeOfDay(hour: 00, minute: 00);
  DateTime selectedDate = DateTime.now();

  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final cName = TextEditingController();
  final cPhoneNumber = TextEditingController();
  final cFlatHomeNumber = TextEditingController();
  final cCity = TextEditingController();
  final cState = TextEditingController();
  final cPinCode = TextEditingController();
  final cSemester = TextEditingController();
  final cDate = TextEditingController();
  String name,email;

  _EditAddressDetailHomePageState(this.addressId, this.phoneNumber, this.pDate, this.pinCode, this.semester, this.time, this.reason);


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkDialogIntroShown();
    fetchDataUsersName();
    initializeTextFormField();
  }


  Future fetchDataUsersName() async{
    EcommerceApp.sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      email  = EcommerceApp.sharedPreferences.getString(EcommerceApp.userEmail);
      name = EcommerceApp.sharedPreferences.getString(EcommerceApp.userName);
    });
  }

  Future initializeTextFormField() async{
    setState(() {
      cPhoneNumber.text = phoneNumber.toString();
      cDate.text = pDate.toString();
      cPinCode.text = pinCode.toString();
      cSemester.text = semester.toString();
      cCity.text = time.toString();
      dropdownValue = reason.toString();
    });
  }

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(2015),
        lastDate: DateTime(2101));
    if (picked != null)
      setState(() {
        selectedDate = picked;
        cDate.text = DateFormat.yMd().format(selectedDate);
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


  Future checkDialogIntroShown() async {
    SharedPreferences userEditYourDetailsHomePageSeen = await SharedPreferences.getInstance();
    bool _seen = (userEditYourDetailsHomePageSeen.getBool('seenUserEditYourDetailsHomePageSeen') ?? false);

    if (_seen) {


    }
    else{
      await userEditYourDetailsHomePageSeen.setBool('seenUserEditYourDetailsHomePageSeen', true);
      //showAlertDialog(context);
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => CustomAlertDialog(
          title: "Hey ${EcommerceApp.sharedPreferences.getString(EcommerceApp.userName)} !",
          desc: "You can edit your details here!",
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    dateTime = DateFormat.yMd().format(DateTime.now());
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Colors.green,
            onPressed: (){
              if (formKey.currentState.validate()) {
                final model = AddressModel(
                    name: name.toString(),
                    state: dropdownValue,
                    pincode: cPinCode.text,
                    phoneNumber: cPhoneNumber.text,
                    flatNumber: email.toString(),
                    city: cCity.text.trim(),
                    date: cDate.text.trim(),
                    semester: cSemester.text.trim())
                    .toJson();

                //add to firestore
                EcommerceApp.firestore
                    .collection(EcommerceApp.collectionUser)
                    .document(EcommerceApp.sharedPreferences
                    .getString(EcommerceApp.userUID))
                    .collection(EcommerceApp.subCollectionAddress)
                    .document(addressId)
                    .updateData(model)
                    .then((value) {
                  Fluttertoast.showToast(msg: "New Details updated successfully.");
                  FocusScope.of(context).requestFocus(FocusNode());
                  formKey.currentState.reset();
                });

                Navigator.pop(context);
              }
            },
            label: Text("Update",style: TextStyle(fontFamily: "Poppins",color: Colors.white),)
        ),
        appBar: AppBar(
          title: Text(
            "Edit Details",
            style: TextStyle(
              fontFamily: "Poppins",
              fontWeight: FontWeight.bold
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
                    icon: Icon(Icons.filter_drama_rounded)),
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
                      "Edit your details",
                      style: TextStyle(
                          decoration: TextDecoration.underline,
                          decorationStyle: TextDecorationStyle.double,
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
                      label: "Phone Number",
                      hint: "Phone Number",
                      controller: cPhoneNumber,
                    ),
                    MyTextField(
                      label: "Semester",
                      hint: "Semester",
                      controller: cSemester,
                    ),
                    InkWell(
                      onTap: () {
                        _selectDate(context);
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
                          controller: cDate,
                          onSaved: (String val) {
                            _setDate = val;
                          },
                          enabled: false,
                          style: TextStyle(color: Colors.white,fontFamily: "Poppins"),
                          cursorColor: Colors.grey[300],
                          decoration: InputDecoration(
                            hintText: "Select Date",
                            hintStyle: TextStyle(color: Colors.grey[300], fontFamily: "Poppins"),
                            labelStyle: TextStyle(color: Colors.grey[300], fontSize: 20.0,fontFamily: "Poppins"),
                            //border: InputBorder.none,
                            labelText: "Preferred Date",
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
                          //keyboardType: TextInputType.multiline,
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
                    // MyTextField(
                    //   label: "Message",
                    //   hint: "Message",
                    //   controller: cState,
                    // ),



                    Container(
                      margin: const EdgeInsets.all(8.0),
                      padding: EdgeInsets.only(left: 10.0,right: 10.0,top: 4.0,bottom: 4.0),
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.white,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(15))
                      ),
                      child: DropdownButton<String>(
                        isExpanded: true,
                        value: dropdownValue,
                        icon: const Icon(Icons.arrow_drop_down_sharp),
                        iconSize: 24,
                        elevation: 16,
                        style: const TextStyle(color: Colors.white),
                        underline: Container(
                          color: Colors.transparent,
                        ),
                        onChanged: (String newValue) {
                          setState(() {
                            dropdownValue = newValue;
                          });
                        },
                        items: <String>[
                          'Reason:',
                          'Have a talk',
                          'Sexual Assault',
                          'Motivation',
                          'Depressed',
                          'Others'
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value,style: TextStyle(fontFamily: "Poppins",fontSize: 18.0),),
                          );
                        }).toList(),
                      ),
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
