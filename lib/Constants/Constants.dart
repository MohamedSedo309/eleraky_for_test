import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

const Color mainColor = Color.fromRGBO(26, 35, 126, 0.8);
const Color secoundryColor = Color.fromRGBO(0, 150, 136, 1);

const customers_collection = 'Customers';
const suppliers_collection = 'Suppliers';
const payment_collection = 'Payments';
const nameDoc = 'Name';
const moneyDoc = 'Debit';
const addressDoc = 'Address';
const phoneDoc = 'Phone';
const locatedINDoc = 'locatedIN';
const paymentDOC = 'payment';
const payment_id_DOC = 'payment_id';
const dateDOC = 'date';
const notesDOC = 'notes';

const paymentRecieverDOC = 'reciever';

const String remember_User = 'keepmeloggedin';

show_toast(String msg) {
  Fluttertoast.showToast(msg: msg);
}
