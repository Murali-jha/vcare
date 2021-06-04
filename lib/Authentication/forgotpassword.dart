import 'package:e_shop/Authentication/authenication.dart';
import 'package:e_shop/Authentication/forgotLoading.dart';
import 'package:e_shop/Authentication/forgotauth.dart';
import 'package:e_shop/DialogBox/errorDialog.dart';
import 'package:flutter/material.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  String _email;
  bool loading =false;
  var _formKey = GlobalKey<FormState>();
  AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    double _screenWidth = MediaQuery.of(context).size.width;
    return loading?Loading():Scaffold(
        appBar: AppBar(
          title: Text('Change Password'),
        ),
        body:Center(
          child: Container(
            margin: EdgeInsets.all(50.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    validator: (value){
                      if(value.isEmpty){
                        return "Enter the email";
                      }
                    },
                    decoration: InputDecoration(
                      hintText: 'Email',
                    ),
                    onChanged: (value){
                      setState(() {
                        _email=value;
                      });
                    },
                  ),
                  SizedBox(height: 25.0,),
                  Container(
                    width: _screenWidth * 0.9,
                    height: _screenWidth * 0.11,
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: BorderSide(color: Colors.white)),
                      onPressed: () async{
                        if(_formKey.currentState.validate()){
                          setState(() {
                            loading=true;
                          });
                          dynamic result = await _auth.forgot(email: _email);
                          if(result==1){
                            setState(() {
                              loading =false;
                            });
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(builder: (context) => AuthenticScreen()),
                                  (Route<dynamic> route) => false,
                            );
                            showDialog(
                                context: context,
                                builder: (c) {
                                  return ErrorAlertDialog(
                                    message: "Password reset email has been sent.",
                                  );
                                });
                          }
                          else{
                            setState(() {
                              loading =false;
                            });
                            showDialog(
                                context: context,
                                builder: (c) {
                                  return ErrorAlertDialog(
                                    message: "Something Went Wrong! check your email and internet",
                                  );
                                });
                          }
                        }
                      },
                      child: Text(
                        "Submit",
                        style: TextStyle(
                          fontSize: 19.0,
                          fontFamily: "Poppins",
                        ),
                      ),
                      color: Colors.green,
                    ),
                  ),

                ],
              ),
            ),
          ),
        )
    );
  }
}
