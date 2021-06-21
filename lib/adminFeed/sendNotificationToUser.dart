import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_shop/Admin/uploadItems.dart';
import 'package:e_shop/Widgets/loadingWidget.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SendNotificationToUser extends StatefulWidget {

  @override
  _SendNotificationToUserState createState() => _SendNotificationToUserState();
}

class _SendNotificationToUserState extends State<SendNotificationToUser> {

  TextEditingController _notificationTextEditingController = TextEditingController();
  TextEditingController _userUIDTextEditingController = TextEditingController();

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
              "v",
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
      body: displayNotificationUploadScreen(),
    );
  }

  displayNotificationUploadScreen() {
    return ListView(
      children: [
        uploading ? linearProgress() : Text(""),
        ListTile(
          leading: Icon(
            Icons.perm_identity_sharp,
            color: Colors.white,
          ),
          title: Container(
            width: 250.0,
            child: TextField(
              style: TextStyle(color: Colors.white, fontFamily: "Poppins"),
              controller: _userUIDTextEditingController,
              decoration: InputDecoration(
                  hintText: "Enter UID",
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
              controller: _notificationTextEditingController,
              decoration: InputDecoration(
                  hintText: "Enter Notification",
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
              onTap: uploading ? null : () => uploadNotification(),
              child: Container(
                color: Colors.green,
                width: MediaQuery.of(context).size.width - 40.0,
                height: 50.0,
                child: Center(
                  child: Text(
                    "Send",
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

  uploadNotification() async{
    setState(() {
      uploading = true;
    });

    await saveNotificationInfo();
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
        UploadPage()), (Route<dynamic> route) => false);
    Fluttertoast.showToast(msg: "Notification Sent Successfully");
  }

  saveNotificationInfo() async{
    final itemsRef = Firestore.instance.collection("notifications").document(_userUIDTextEditingController.text.trim());
    itemsRef.collection("notificationData").document(feedId).setData({
      "message": _notificationTextEditingController.text.trim(),
      "publishedDate": DateTime.now(),
    });
    setState(() {
      uploading=false;
      feedId = DateTime.now().millisecondsSinceEpoch.toString();
      _notificationTextEditingController.clear();
      _userUIDTextEditingController.clear();
    });
  }


}


