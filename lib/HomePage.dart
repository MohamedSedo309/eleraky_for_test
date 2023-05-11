import 'package:eleraky/Customers_Screens/Customers_Screen.dart';
import 'package:eleraky/Suppliers_Screens/Suppliers_Screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'Constants/Constants.dart';

class HomePage extends StatefulWidget {
  static String screenID = 'Homepage';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    auth.signInWithEmailAndPassword(
        email: 'admin2@mail.com', password: 'admin1234');

    return Scaffold(
      backgroundColor: mainColor,
      body: WillPopScope(
        onWillPop: () async {
          auth.signOut();
          return true;
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 150),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, Customers_Screen.screenID);
                },
                child: Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                    color: secoundryColor,
                    border: Border.all(width: 2, color: secoundryColor),
                    borderRadius: BorderRadius.circular(
                      10,
                    ),
                  ),
                  child: Text(
                    "حسابات العملاء",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Almarai',
                      fontSize: 30,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, Suppliers_Screen.screenID);
                },
                child: Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                    color: secoundryColor,
                    border: Border.all(width: 2, color: secoundryColor),
                    borderRadius: BorderRadius.circular(
                      10,
                    ),
                  ),
                  child: Text(
                    'حسابات الموردين',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Almarai',
                      fontSize: 30,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
