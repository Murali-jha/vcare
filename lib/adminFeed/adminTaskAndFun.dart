import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop/Admin/uploadItems.dart';
import 'package:e_shop/Widgets/customAppBar.dart';
import 'package:e_shop/Widgets/loadingWidget.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UploadTaskAndFun extends StatefulWidget {
  final File file;

  const UploadTaskAndFun({Key key, this.file}) : super(key: key);

  @override
  _UploadTaskAndFun createState() => _UploadTaskAndFun(file);
}

class _UploadTaskAndFun extends State<UploadTaskAndFun> {
  final File file;

  _UploadTaskAndFun(this.file);

  TextEditingController _descriptionTextEditingController = TextEditingController();
  TextEditingController _titleTextEditingController = TextEditingController();
  TextEditingController _urlTextEditingController = TextEditingController();

  String feedId = DateTime.now().millisecondsSinceEpoch.toString();
  bool uploading = false;

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
      ),
      body: displayFeedUploadScreen(),
    );
  }

  displayFeedUploadScreen() {
    return ListView(
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
            Icons.person,
            color: Colors.white,
          ),
          title: Container(
            width: 250.0,
            child: TextField(
              keyboardType: TextInputType.multiline,
              maxLines: null,
              style: TextStyle(color: Colors.white, fontFamily: "Poppins"),
              controller: _titleTextEditingController,
              decoration: InputDecoration(
                  hintText: "Title",
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
            Icons.info,
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
            Icons.link,
            color: Colors.white,
          ),
          title: Container(
            width: 250.0,
            child: TextField(
              keyboardType: TextInputType.multiline,
              maxLines: null,
              style: TextStyle(color: Colors.white, fontFamily: "Poppins"),
              controller: _urlTextEditingController,
              decoration: InputDecoration(
                  hintText: "Url of questionnaire",
                  hintStyle:
                  TextStyle(color: Colors.grey, fontFamily: "Poppins"),
                  border: InputBorder.none),
            ),
          ),
        ),
        Divider(
          color: Colors.green,
        ),
        Padding(
          padding: EdgeInsets.all(10.0),
          child: Center(
            child: InkWell(
              onTap: uploading ? null : () => uploadTaskAndFunImageAndSaveItemInfo(),
              child: Container(
                color: Colors.green,
                width: MediaQuery.of(context).size.width - 40.0,
                height: 50.0,
                child: Center(
                  child: Text(
                    "Upload",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.0,
                        fontFamily: "Poppins"),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  uploadTaskAndFunImageAndSaveItemInfo() async{
    setState(() {
      uploading = true;
    });

    String imageDownloadUrl = await uploadTaskAndFunItemImage(file);
    await saveTaskAndFunItemInfo(imageDownloadUrl);
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
        UploadPage()), (Route<dynamic> route) => false);
    Fluttertoast.showToast(msg: "Task uploaded successfully!");
  }

  Future<String> uploadTaskAndFunItemImage(mFileImage) async{
    final StorageReference storageReference = FirebaseStorage.instance.ref().child("TaskAndFunItems");
    StorageUploadTask uploadTask = storageReference.child("product_$feedId.jpg").putFile(mFileImage);
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    String downloadUrl = await taskSnapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  saveTaskAndFunItemInfo(String downloadUrl) async{
    final itemsRef = Firestore.instance.collection("taskAndFun");
    itemsRef.document(feedId).setData({
      "description": _descriptionTextEditingController.text.trim(),
      "title": _titleTextEditingController.text.trim(),
      "url": _urlTextEditingController.text.trim(),
      "publishedDate": DateTime.now(),
      "thumbnailUrl": downloadUrl,
    });
    setState(() {
      uploading=false;
      feedId = DateTime.now().millisecondsSinceEpoch.toString();
      _descriptionTextEditingController.clear();
      _titleTextEditingController.clear();
      _urlTextEditingController.clear();
    });
  }
}
