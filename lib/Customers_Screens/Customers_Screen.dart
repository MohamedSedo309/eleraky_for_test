import 'package:eleraky/Constants/Constants.dart';
import 'package:eleraky/Customers_Screens/add_customer.dart';
import 'package:flutter/material.dart';

import 'Customers_Menu.dart';

class Customers_Screen extends StatefulWidget {
  static String screenID = 'Customers_Screen';

  @override
  _Suppliers_ScreenState createState() => _Suppliers_ScreenState();
}

class _Suppliers_ScreenState extends State<Customers_Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 150),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, Add_Customer.screenID);
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(
                      Icons.person_add,
                      size: 40,
                      color: Colors.white,
                    ),
                    Text(
                      'إضافة عميل',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Almarai',
                        fontSize: 30,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, Customers_Menu.screenID);
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(
                      Icons.people,
                      size: 40,
                      color: Colors.white,
                    ),
                    Text(
                      'العملاء',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Almarai',
                        fontSize: 30,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
