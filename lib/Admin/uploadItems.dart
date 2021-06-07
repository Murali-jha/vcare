import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop/Admin/adminShiftOrders.dart';
import 'package:e_shop/Authentication/authenication.dart';
import 'package:e_shop/Widgets/loadingWidget.dart';
import 'package:e_shop/adminFeed/adminFeedUpload.dart';
import 'package:e_shop/main.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image/image.dart' as ImD;

class UploadPage extends StatefulWidget {
  @override
  _UploadPageState createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage>
    with AutomaticKeepAliveClientMixin<UploadPage> {
  bool get wantKeepAlive => true;
  File file;
  File feedFile;
  TextEditingController _descriptionTextEditingController =
      TextEditingController();
  TextEditingController _titleTextEditingController = TextEditingController();
  TextEditingController _priceTextEditingController = TextEditingController();
  TextEditingController _shortInfoTextEditingController =
      TextEditingController();
  String productId = DateTime.now().millisecondsSinceEpoch.toString();
  bool uploading = false;

  @override
  Widget build(BuildContext context) {
    return file == null
        ? displayAdminHomeScreen()
        : displayAdminUploadFormScreen();
  }

  displayAdminHomeScreen() {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: (){
          uploadImageToFeed(context);
        },
      ),
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
                  fontFamily: "Signatra", fontSize: 45.0, color: Colors.green),
            ),
            SizedBox(
              width: 5.0,
            ),
            Text(
              "Admin",
              style: TextStyle(
                  fontFamily: "Poppins", fontSize: 10.0, color: Colors.white),
            ),
          ],
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(16.0)),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.queue,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => AdminShiftOrders()));
          },
        ),
        actions: [
          FlatButton(
              onPressed: () {
                Route route = MaterialPageRoute(builder: (_) {
                  return SplashScreen();
                });
                Navigator.of(context)
                    .pushAndRemoveUntil(route, (Route<dynamic> route) => false);
              },
              child: Text(
                "Logout",
                style: TextStyle(fontFamily: "Poppins", color: Colors.red),
              ))
        ],
      ),
      body: getAdminHomeScreenBody(),
    );
  }

  getAdminHomeScreenBody() {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.shop_two,
              color: Colors.green,
              size: 100.0,
            ),
            Padding(
              padding: EdgeInsets.only(top: 20.0),
              child: RaisedButton(
                color: Colors.green,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(9.0)),
                child: Text(
                  "Add Doctor",
                  style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 20.0,
                      color: Colors.white),
                ),
                onPressed: () => takeImage(context),
              ),
            )
          ],
        ),
      ),
    );
  }

  uploadImageToFeed(mContext){
    return showDialog(
        context: mContext,
        builder: (con) {
          return SimpleDialog(
            title: Text(
              "Select Option",
              style: TextStyle(color: Colors.white, fontFamily: "Poppins"),
            ),
            children: [
              SimpleDialogOption(
                child: Text(
                  "Upload Feed",
                  style: TextStyle(color: Colors.white, fontFamily: "Poppins"),
                ),
                onPressed: () async{
                  await selectFeedImageFromGallery();
                  if(feedFile!=null){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => UploadFeed(file: feedFile,)));
                  }
                },
              ),
              SimpleDialogOption(
                child: Text(
                  "Upload Task",
                  style: TextStyle(color: Colors.white, fontFamily: "Poppins"),
                ),
                onPressed: (){

                },
              ),
              SimpleDialogOption(
                child: Text(
                  "Cancel",
                  style: TextStyle(color: Colors.white, fontFamily: "Poppins"),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ],
          );
        });
  }

  selectFeedImageFromGallery() async {
    Navigator.pop(context);
    File imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      feedFile = imageFile;
    });
  }

  takeImage(mContext) {
    return showDialog(
        context: mContext,
        builder: (con) {
          return SimpleDialog(
            title: Text(
              "Image of Doctor",
              style: TextStyle(color: Colors.white, fontFamily: "Poppins"),
            ),
            children: [
              SimpleDialogOption(
                child: Text(
                  "Capture With Camera",
                  style: TextStyle(color: Colors.white, fontFamily: "Poppins"),
                ),
                onPressed: capturePhotoWithCamera,
              ),
              SimpleDialogOption(
                child: Text(
                  "Select From Gallery",
                  style: TextStyle(color: Colors.white, fontFamily: "Poppins"),
                ),
                onPressed: pickPhotoFromGallery,
              ),
              SimpleDialogOption(
                child: Text(
                  "Cancel",
                  style: TextStyle(color: Colors.white, fontFamily: "Poppins"),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ],
          );
        });
  }

  capturePhotoWithCamera() async {
    Navigator.pop(context);
    File imageFile = await ImagePicker.pickImage(
        source: ImageSource.camera, maxWidth: 970.0, maxHeight: 680.0);
    setState(() {
      file = imageFile;
    });
  }

  pickPhotoFromGallery() async {
    Navigator.pop(context);
    File imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      file = imageFile;
    });
  }

  displayAdminUploadFormScreen() {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Fill the details",
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(16.0)),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: clearFormInfo,
        ),
        actions: [
          FlatButton(
              onPressed: uploading? null : () => uploadImageAndSaveItemInfo(),
              child: Text(
                "Upload",
                style: TextStyle(
                    color: Colors.green,
                    fontFamily: "Poppins",
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold),
              ))
        ],
      ),
      body: ListView(
        children: [
          uploading ? linearProgress() : Text(""),
          Container(
            height: 230.0,
            width: MediaQuery.of(context).size.width * 0.8,
            child: Center(
              child: AspectRatio(
                aspectRatio: 16 / 16,
                child: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: FileImage(file), fit: BoxFit.cover)),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 12.0),
          ),
          ListTile(
            leading: Icon(
              Icons.perm_device_information,
              color: Colors.white,
            ),
            title: Container(
              width: 250.0,
              child: TextField(
                keyboardType: TextInputType.multiline,
                maxLines: null,
                style: TextStyle(color: Colors.white, fontFamily: "Poppins"),
                controller: _shortInfoTextEditingController,
                decoration: InputDecoration(
                    hintText: "Short Info used for searching",
                    hintStyle:
                        TextStyle(color: Colors.grey, fontFamily: "Poppins"),
                    border: InputBorder.none),
              ),
            ),
          ),
          Divider(
            color: Colors.green,
          ),
          ListTile(
            leading: Icon(
              Icons.person,
              color: Colors.white,
            ),
            title: Container(
              width: 250.0,
              child: TextField(
                style: TextStyle(color: Colors.white, fontFamily: "Poppins"),
                controller: _titleTextEditingController,
                decoration: InputDecoration(
                    hintText: "Name",
                    hintStyle:
                        TextStyle(color: Colors.grey, fontFamily: "Poppins"),
                    border: InputBorder.none),
              ),
            ),
          ),
          Divider(
            color: Colors.green,
          ),
          ListTile(
            leading: Icon(
              Icons.info_outline,
              color: Colors.white,
            ),
            title: Container(
              width: 250.0,
              child: TextField(
                keyboardType: TextInputType.multiline,
                maxLines: null,
                style: TextStyle(color: Colors.white, fontFamily: "Poppins"),
                controller: _descriptionTextEditingController,
                decoration: InputDecoration(
                    hintText: "Description",
                    hintStyle:
                        TextStyle(color: Colors.grey, fontFamily: "Poppins"),
                    border: InputBorder.none),
              ),
            ),
          ),
          Divider(
            color: Colors.green,
          ),
          ListTile(
            leading: Icon(
              Icons.watch_later_outlined,
              color: Colors.white,
            ),
            title: Container(
              width: 250.0,
              child: TextField(
                style: TextStyle(color: Colors.white, fontFamily: "Poppins"),
                controller: _priceTextEditingController,
                decoration: InputDecoration(
                    hintText: "Availability Timing",
                    hintStyle:
                        TextStyle(color: Colors.grey, fontFamily: "Poppins"),
                    border: InputBorder.none),
              ),
            ),
          ),
          Divider(
            color: Colors.green,
          ),
        ],
      ),
    );
  }

  clearFormInfo() {
    setState(() {
      file = null;
      _descriptionTextEditingController.clear();
      _titleTextEditingController.clear();
      _shortInfoTextEditingController.clear();
      _priceTextEditingController.clear();
    });
  }

  uploadImageAndSaveItemInfo() async{
    setState(() {
      uploading = true;
    });

    String imageDownloadUrl = await uploadItemImage(file);
    saveItemInfo(imageDownloadUrl);

  }

  Future<String> uploadItemImage(mFileImage) async{
    final StorageReference storageReference = FirebaseStorage.instance.ref().child("Items");
    StorageUploadTask uploadTask = storageReference.child("product_$productId.jpg").putFile(mFileImage);
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    String downloadUrl = await taskSnapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  saveItemInfo(String downloadUrl) async{
    final itemsRef = Firestore.instance.collection("items");
    itemsRef.document(productId).setData({
      "shortInfo": _shortInfoTextEditingController.text.trim(),
      "longDescription": _descriptionTextEditingController.text.trim(),
      "price": _priceTextEditingController.text.trim(),
      "publishedDate": DateTime.now(),
      "status": "available",
      "thumbnailUrl": downloadUrl,
      "title": _titleTextEditingController.text.trim(),
    });
    setState(() {
      file = null;
      uploading=false;
      productId = DateTime.now().millisecondsSinceEpoch.toString();
      _descriptionTextEditingController.clear();
      _titleTextEditingController.clear();
      _priceTextEditingController.clear();
      _shortInfoTextEditingController.clear();
    });
  }
}
