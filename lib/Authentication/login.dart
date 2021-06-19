import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop/Admin/adminLogin.dart';
import 'package:e_shop/Authentication/forgotpassword.dart';
import 'package:e_shop/Widgets/customTextField.dart';
import 'package:e_shop/DialogBox/errorDialog.dart';
import 'package:e_shop/DialogBox/loadingDialog.dart';
import 'package:e_shop/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Store/storehome.dart';
import 'package:e_shop/Config/config.dart';


class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}





class _LoginState extends State<Login>
{
  final TextEditingController _emailTextEditingController =
  TextEditingController();
  final TextEditingController _passwordTextEditingController =
  TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double _screenWidth = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [

            Container(
              alignment: Alignment.bottomCenter,
              child: Image.asset("images/login.png"),
              height: 150.0,
              width:150.0,
            ),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Text("Welcome to vCare Family!",style: TextStyle(fontFamily: "Poppins",fontSize: 15.0),),
            ),
            SizedBox(
              height: 18.0,
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  CustomTextField(
                    labelText: "Email",
                    hintText: "Email",
                    controller: _emailTextEditingController,
                    isObsecure: false,
                    data: Icons.email,
                  ),
                  CustomTextField(
                    labelText: "Password",
                    hintText: "Password",
                    controller: _passwordTextEditingController,
                    isObsecure: true,
                    data: Icons.vpn_key,
                  ),
                  SizedBox(
                    height: 25.0,
                  ),
                  Container(
                    width: _screenWidth * 0.9,
                    height: _screenWidth * 0.11,
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: BorderSide(color: Colors.white)),
                      onPressed: () {
                        _emailTextEditingController.text.isNotEmpty
                            && _passwordTextEditingController.text.isNotEmpty?
                        loginUser():showDialog(
                          barrierDismissible: false,
                            context: context,builder: (c){
                          return ErrorAlertDialog(message: "Please fill all the data",);
                        });
                      },
                      child: Text(
                        "Login",
                        style: TextStyle(
                          fontSize: 19.0,
                          fontFamily: "Poppins",
                        ),
                      ),
                      color: Colors.green,
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  FlatButton(
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>ForgotPassword()));
                      },
                      child:Text("Forgot Password?",style: TextStyle(fontFamily: "Poppins"),)
                  ),
                  SizedBox(
                    height: 80.0,
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 10.0),
                    height: 1.5,
                    width: _screenWidth * 0.5,
                    color: Colors.green,
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  FlatButton.icon(
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>AdminSignInPage()));
                      },
                      icon: Icon(Icons.dangerous,color: Colors.green,),
                      label:Text("I'm Admin",style: TextStyle(fontFamily: "Poppins"),)
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  FirebaseAuth _auth = FirebaseAuth.instance;
  void loginUser() async{
    showDialog(
        barrierDismissible: false,
        context: context,builder: (c){
      return LoadingAlertDialog(message:"Authenticating..Please wait...");
    });
    FirebaseUser firebaseUser;
    await _auth.signInWithEmailAndPassword(
        email: _emailTextEditingController.text.trim(),
        password: _passwordTextEditingController.text.trim()
    ).then((authUser){
      firebaseUser = authUser.user;
    }).catchError((error) {
      Navigator.pop(context);
      showDialog(
        barrierDismissible: false,
          context: context,
          builder: (c) {
            return ErrorAlertDialog(
              message: error.message.toString(),
            );
          });
    });

    if(firebaseUser!=null){
      bool emailFlag = firebaseUser.isEmailVerified;
      if (emailFlag) {
        readData(firebaseUser).then((s) {
          Navigator.pop(context);
          Route route = MaterialPageRoute(builder: (_) {
            return SplashScreen();
          });
          Navigator.pushReplacement(context, route);
        });
      } else {
        await _auth.signOut();
        Navigator.pop(context);
        showDialog(
          barrierDismissible: false,
            context: context,
            builder: (c) {
              return ErrorAlertDialog(
                message: "Please Verify your email. Verification link has been sent to your registered email id",
              );
            });
      }
    }
  }

  Future readData(FirebaseUser fUser) async
  {
    EcommerceApp.sharedPreferences = await SharedPreferences.getInstance();

    
    Firestore.instance.collection("users").document(fUser.uid).get().then((dataSnapshot)
    async {

      await EcommerceApp.sharedPreferences.setString("uid", dataSnapshot.data[EcommerceApp.userUID]);

      await EcommerceApp.sharedPreferences.setString(EcommerceApp.userEmail, dataSnapshot.data[EcommerceApp.userEmail]);

      await EcommerceApp.sharedPreferences.setString(EcommerceApp.userName,dataSnapshot.data[EcommerceApp.userName]);

      await EcommerceApp.sharedPreferences.setString(EcommerceApp.userAvatarUrl, dataSnapshot.data[EcommerceApp.userAvatarUrl]);

      List<String> cartList = dataSnapshot.data[EcommerceApp.userCartList].cast<String>();
      await EcommerceApp.sharedPreferences.setStringList(EcommerceApp.userCartList, cartList);
    });
  }

}
