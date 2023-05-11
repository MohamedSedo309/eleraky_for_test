import 'package:eleraky/Auth/login_screen.dart';
import 'package:eleraky/Constants/Constants.dart';
import 'package:eleraky/Customers_Screens/Add_a_receipt.dart';
import 'package:eleraky/Customers_Screens/Customer_Details.dart';
import 'package:eleraky/Customers_Screens/Customers_Menu.dart';
import 'package:eleraky/Customers_Screens/Customers_Screen.dart';
import 'package:eleraky/Customers_Screens/Edit_payments.dart';
import 'package:eleraky/Customers_Screens/add_customer.dart';
import 'package:eleraky/Customers_Screens/get_a_Payment.dart';
import 'package:eleraky/HomePage.dart';
import 'package:eleraky/Provider/progressHUD.dart';
import 'package:eleraky/Suppliers_Screens/Add_Supplier.dart';
import 'package:eleraky/Suppliers_Screens/Add_a_Receipt.dart';
import 'package:eleraky/Suppliers_Screens/Edit_supplier_Payments.dart';
import 'package:eleraky/Suppliers_Screens/Pay_Payment.dart';
import 'package:eleraky/Suppliers_Screens/Supplier_Details.dart';
import 'package:eleraky/Suppliers_Screens/Suppliers_Menu.dart';
import 'package:eleraky/Suppliers_Screens/Suppliers_Screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool rememberMe = false;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SharedPreferences>(
        future: SharedPreferences.getInstance(),
        builder: (context, snapshot) {
          if (snapshot.data == null)
            rememberMe = false;
          else if (snapshot.data!.getBool(remember_User) == null)
            rememberMe = false;
          else
            rememberMe = snapshot.data!.getBool(remember_User)!;
          return MultiProvider(
            providers: [
              ChangeNotifierProvider<ProgressHUDprovider>(
                create: (BuildContext context) => ProgressHUDprovider(),
              ),
            ],
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'أولاد العراقي',
              home: rememberMe ? HomePage() : Login_Screen(),
              routes: {
                HomePage.screenID: (context) => HomePage(),
                Customers_Screen.screenID: (context) => Customers_Screen(),
                Add_Customer.screenID: (context) => Add_Customer(),
                Customers_Menu.screenID: (context) => Customers_Menu(),
                Customer_details.screenID: (context) => Customer_details(),
                Suppliers_Screen.screenID: (context) => Suppliers_Screen(),
                Add_Supplier.screenID: (context) => Add_Supplier(),
                Supplier_details.screenID: (context) => Supplier_details(),
                Suppliers_Menu.screenID: (context) => Suppliers_Menu(),
                Pay_Payment.screenID: (context) => Pay_Payment(),
                Add_a_Receipt.screenID: (context) => Add_a_Receipt(),
                Edit_supplier_Payments.screenID: (context) =>
                    Edit_supplier_Payments(),
                Get_Payment.screenID: (context) => Get_Payment(),
                Add_a_Customer_Receipt.screenID: (context) =>
                    Add_a_Customer_Receipt(),
                Edit_customer_Payments.screenID: (context) =>
                    Edit_customer_Payments(),
              },
            ),
          );
        });
  }
}
