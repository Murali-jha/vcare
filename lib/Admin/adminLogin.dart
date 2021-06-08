import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop/Admin/uploadItems.dart';
import 'package:e_shop/Authentication/authenication.dart';
import 'package:e_shop/Widgets/customTextField.dart';
import 'package:e_shop/DialogBox/errorDialog.dart';
import 'package:flutter/material.dart';

class AdminSignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "V - ",
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
            SizedBox(width: 5.0,),
            Text(
              "Admin",
              style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 10.0,
                  color: Colors.white),
            ),
          ],
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(16.0)),
        ),
        centerTitle: true,
      ),
      body: AdminSignInScreen(),
    );
  }
}

class AdminSignInScreen extends StatefulWidget {
  @override
  _AdminSignInScreenState createState() => _AdminSignInScreenState();
}

class _AdminSignInScreenState extends State<AdminSignInScreen> {
  final TextEditingController _adminIdTextEditingController =
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
            SizedBox(
              height: 28.0,
            ),
            Container(
              alignment: Alignment.bottomCenter,
              child: Image.asset("images/adminlogin.png",),
              height: 170.0,
              width:170.0,
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("Warning: This page is for admin!",style: TextStyle(fontFamily: "Poppins",fontSize: 15.0),),
            ),
            SizedBox(
              height: 22.0,
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  CustomTextField(
                    labelText: "Id",
                    hintText: "Id",
                    controller: _adminIdTextEditingController,
                    isObsecure: false,
                    data: Icons.perm_identity_sharp,
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
                        _adminIdTextEditingController.text.isNotEmpty
                            && _passwordTextEditingController.text.isNotEmpty?
                        loginAdmin():showDialog(context: context,builder: (c){
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
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.dangerous,color: Colors.green,),
                      label:Text("I'm not Admin",style: TextStyle(fontFamily: "Poppins"),)
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  loginAdmin(){
    Firestore.instance.collection("admins").getDocuments().then((snapshot){
      snapshot.documents.forEach((result) {
        if(result.data["id"] != _adminIdTextEditingController.text.trim()){
          Scaffold.of(context).showSnackBar(SnackBar(content: Text("Id entered is incorrect")));
        }
        else if(result.data["password"] != _passwordTextEditingController.text.trim()){
          Scaffold.of(context).showSnackBar(SnackBar(content: Text("Password entered is incorrect")));
        }
        else{
          Scaffold.of(context).showSnackBar(SnackBar(content: Text("Welcome Dear, "+ result.data["name"])));
          setState(() {
            _adminIdTextEditingController.text = "";
            _passwordTextEditingController.text = "";
          });

          Route route = MaterialPageRoute(builder: (_) {
            return UploadPage();
          });
          Navigator.of(context).pushAndRemoveUntil(route, (Route<dynamic> route) => false);
        }
      });
    });
  }
}
