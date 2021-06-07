import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop/Admin/uploadItems.dart';
import 'package:e_shop/Widgets/customAppBar.dart';
import 'package:e_shop/Widgets/loadingWidget.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UploadFeed extends StatefulWidget {
  final File file;

  const UploadFeed({Key key, this.file}) : super(key: key);

  @override
  _UploadFeedState createState() => _UploadFeedState(file);
}

class _UploadFeedState extends State<UploadFeed> {
  final File file;

  _UploadFeedState(this.file);

  TextEditingController _messageTextEditingController = TextEditingController();
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
            Icons.info,
            color: Colors.white,
          ),
          title: Container(
            width: 250.0,
            child: TextField(
              keyboardType: TextInputType.multiline,
              maxLines: null,
              style: TextStyle(color: Colors.white, fontFamily: "Poppins"),
              controller: _messageTextEditingController,
              decoration: InputDecoration(
                  hintText: "Message",
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
              onTap: uploading ? null : () => uploadFeedImageAndSaveItemInfo(),
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

  uploadFeedImageAndSaveItemInfo() async{
    setState(() {
      uploading = true;
    });

    String imageDownloadUrl = await uploadFeedItemImage(file);
    await saveFeedItemInfo(imageDownloadUrl);
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
        UploadPage()), (Route<dynamic> route) => false);
    Fluttertoast.showToast(msg: "Feed uploaded successfully!");
  }

  Future<String> uploadFeedItemImage(mFileImage) async{
    final StorageReference storageReference = FirebaseStorage.instance.ref().child("FeedItems");
    StorageUploadTask uploadTask = storageReference.child("product_$feedId.jpg").putFile(mFileImage);
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    String downloadUrl = await taskSnapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  saveFeedItemInfo(String downloadUrl) async{
    final itemsRef = Firestore.instance.collection("feedItems");
    itemsRef.document(feedId).setData({
      "message": _messageTextEditingController.text.trim(),
      "publishedDate": DateTime.now(),
      "thumbnailUrl": downloadUrl,
    });
    setState(() {
      uploading=false;
      feedId = DateTime.now().millisecondsSinceEpoch.toString();
      _messageTextEditingController.clear();
    });
  }
}
