import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final IconData data;
  final String hintText;
  bool isObsecure = true;
  final String labelText;

  CustomTextField(
      {Key key,
      this.controller,
      this.data,
      this.hintText,
      this.isObsecure,
      this.labelText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // decoration: BoxDecoration(
      //   color: Colors.grey,
      //   borderRadius: BorderRadius.all(Radius.circular(10.0)),
      // ),
      padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 10.0),
      child: TextFormField(
        controller: controller,
        style: TextStyle(color: Colors.white,fontFamily: "Poppins"),
        obscureText: isObsecure,
        cursorColor: Colors.grey[300],
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey[300], fontFamily: "Poppins"),
          labelStyle: TextStyle(color: Colors.grey[300], fontSize: 20.0,fontFamily: "Poppins"),
          //border: InputBorder.none,
          labelText: labelText,
          prefixIcon: Icon(
            data,
            color: Colors.grey[300],
          ),
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
        validator: (Value) {
          return Value;
        },
      ),
    );
  }
}
