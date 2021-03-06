import 'package:flutter/material.dart';

class CryptoHelpPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(16.0)),
        ),
        centerTitle: true,
        title: Text(
          "CryptoV",
          style: TextStyle(
              fontFamily: "Poppins",
              fontWeight: FontWeight.bold

          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: Text(
            "CryptoV coins are simply the coins generated by vCare rewarded to the user to help them get surprises.\n         If a user receives 1000+ CryptoV coins, then vCare delivers surprises( Gift cards, Brochure, T-shirts, Cashback, etc.) at their Dore steps.",
            style: TextStyle(fontFamily: "Poppins",fontSize: 18.0),
          ),
        ),
      ),
    );
  }
}
