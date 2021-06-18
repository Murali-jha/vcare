import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop/Authentication/authenication.dart';
import 'package:e_shop/Authentication/login.dart';
import 'package:e_shop/Widgets/customTextField.dart';
import 'package:e_shop/DialogBox/errorDialog.dart';
import 'package:e_shop/DialogBox/loadingDialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

//import 'package:image_picker/image_picker.dart';
import '../Store/storehome.dart';
import 'package:e_shop/Config/config.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController _nameTextEditingController =
  TextEditingController();
  final TextEditingController _emailTextEditingController =
  TextEditingController();
  final TextEditingController _passwordTextEditingController =
  TextEditingController();
  final TextEditingController _confirmPasswordTextEditingController =
  TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String userImageUrl = "";
  File _imageFile;
  int creditPoints = 100;

  @override
  Widget build(BuildContext context) {
    double _screenWidth = MediaQuery.of(context).size.width;
    double _screenHeight = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(
              height: 18.0,
            ),
            InkWell(
              onTap: () {
                _selectAndPickImage();
              },
              child: CircleAvatar(
                radius: _screenWidth * 0.18,
                backgroundImage:
                _imageFile == null ? null : FileImage(_imageFile),
                child: _imageFile == null
                    ? Icon(
                  Icons.add_a_photo_outlined,
                  size: _screenWidth * 0.15,
                  color: Colors.grey,
                )
                    : null,
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  CustomTextField(
                    labelText: "UserName",
                    hintText: "UserName",
                    controller: _nameTextEditingController,
                    isObsecure: false,
                    data: Icons.person,
                  ),
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
                  CustomTextField(
                    labelText: "Confirm Password",
                    hintText: "Confirm Password",
                    controller: _confirmPasswordTextEditingController,
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
                        uploadAndSaveImage();
                      },
                      child: Text(
                        "Register",
                        style: TextStyle(
                          fontSize: 19.0,
                          fontFamily: "Poppins",
                        ),
                      ),
                      color: Colors.green,
                    ),
                  ),
                  SizedBox(
                    height: 60.0,
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
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _selectAndPickImage() async {
    File _imageFile1 = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _imageFile = _imageFile1;
    });
  }

  Future<void> uploadAndSaveImage() async {
    if (_imageFile == null) {
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (c) {
            return ErrorAlertDialog(
              message: "Please Select an Image!!",
            );
          });
    } else {
      _passwordTextEditingController.text ==
          _confirmPasswordTextEditingController.text
          ? _nameTextEditingController.text.isNotEmpty &&
          _passwordTextEditingController.text.isNotEmpty &&
          _confirmPasswordTextEditingController.text.isNotEmpty &&
          _emailTextEditingController.text.isNotEmpty
          ? uploadToStorage()
          : displayDialog("Please fill the all data!!")
          : displayDialog("Password didn't match");
    }
  }

  displayDialog(String msge) {
    showDialog(
        context: context,
        builder: (c) {
          return ErrorAlertDialog(
            message: msge,
          );
        });
  }

  uploadToStorage() async {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (c) {
          return LoadingAlertDialog(
            message: "Registering..Please wait...",
          );
        });

    String imageFilename = DateTime.now().millisecondsSinceEpoch.toString();

    StorageReference storageReference =
    FirebaseStorage.instance.ref().child(imageFilename);

    StorageUploadTask storageUploadTask = storageReference.putFile(_imageFile);

    StorageTaskSnapshot storageTaskSnapshot =
    await storageUploadTask.onComplete;

    await storageTaskSnapshot.ref.getDownloadURL().then((urlImage) {
      userImageUrl = urlImage;
      _registerUser();
    });
  }

  FirebaseAuth _auth = FirebaseAuth.instance;

  void _registerUser() async {
    FirebaseUser firebaseUser;
    await _auth
        .createUserWithEmailAndPassword(
      email: _emailTextEditingController.text.trim(),
      password: _passwordTextEditingController.text.trim(),
    )
        .then((auth) {
      firebaseUser = auth.user;
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

    try {
      await firebaseUser.sendEmailVerification();
      await _auth.signOut();
    } catch (e) {
      showDialog(
          context: context,
          builder: (c) {
            return ErrorAlertDialog(
              message: e.message.toString(),
            );
          });
      print(e.toString());
      print('unable to send email');
    }

    if (firebaseUser != null) {
      saveUserInfoToFireStore(firebaseUser);
      Navigator.pop(context);
      Route route = MaterialPageRoute(builder: (c) => AuthenticScreen());
      Navigator.pushReplacement(context, route);
      showDialog(
          context: context,
          builder: (c) {
            return ErrorAlertDialog(
              message: "Verification email has been sent to your email. Click on the link to verify your self",
            );
          });
    }
  }

  Future saveUserInfoToFireStore(FirebaseUser fUser) async
  {
    Firestore.instance.collection("users").document(fUser.uid).setData({
      "uid": fUser.uid,
      "email": fUser.email,
      "name": _nameTextEditingController.text.trim(),
      "url": userImageUrl,
      EcommerceApp.userCartList: ["garbageValue"],
    });

    Firestore.instance.collection("rewards").document(fUser.uid).setData({
      "credits": creditPoints
    });

    await EcommerceApp.sharedPreferences.setString("uid", fUser.uid);
    await EcommerceApp.sharedPreferences.setString(EcommerceApp.userEmail, fUser.email);
    await EcommerceApp.sharedPreferences.setString(EcommerceApp.userName, _nameTextEditingController.text);
    await EcommerceApp.sharedPreferences.setString(EcommerceApp.userAvatarUrl, userImageUrl);
    await EcommerceApp.sharedPreferences.setStringList(EcommerceApp.userCartList, ["garbageValue"]);
  }
}
