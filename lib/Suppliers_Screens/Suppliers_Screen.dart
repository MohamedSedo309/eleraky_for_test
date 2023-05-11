import 'package:eleraky/Constants/Constants.dart';
import 'package:eleraky/Suppliers_Screens/Add_Supplier.dart';
import 'package:eleraky/Suppliers_Screens/Suppliers_Menu.dart';
import 'package:flutter/material.dart';

class Suppliers_Screen extends StatefulWidget {
  static String screenID = 'Suppliers_Screen';

  @override
  _Suppliers_ScreenState createState() => _Suppliers_ScreenState();
}

class _Suppliers_ScreenState extends State<Suppliers_Screen> {
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
                Navigator.pushNamed(context, Add_Supplier.screenID);
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
                      'إضافة مورد',
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
                Navigator.pushNamed(context, Suppliers_Menu.screenID);
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
                      'الموردين',
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
