import 'package:date_format/date_format.dart';
import 'package:eleraky/Constants/Constants.dart';
import 'package:eleraky/Provider/store.dart';
import 'package:eleraky/Suppliers_Screens/Supplier_Details.dart';
import 'package:eleraky/Suppliers_Screens/supplier.dart';
import 'package:flutter/material.dart';

import '../payment.dart';

class Add_a_Receipt extends StatefulWidget {
  static String screenID = 'Add_a_Receipt';
  @override
  _Add_a_ReceiptState createState() => _Add_a_ReceiptState();
}

class _Add_a_ReceiptState extends State<Add_a_Receipt> {
  String date_controller = '';
  GlobalKey<FormState> form_key = GlobalKey<FormState>();
  TextEditingController payment_val_controller = TextEditingController();

  TextEditingController reciever_controller = TextEditingController();
  Store store = Store();

  @override
  Widget build(BuildContext context) {
    final Supplier supplier =
        ModalRoute.of(context)!.settings.arguments as Supplier;

    return Form(
      key: form_key,
      child: Scaffold(
        backgroundColor: mainColor,
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: EdgeInsets.symmetric(vertical: 100, horizontal: 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(0, 20, 0, 5),
                child: TextFormField(
                  key: ValueKey('قيمة الفاتورة'),
                  validator: (value) {
                    if (value!.isEmpty) return 'أدخل قيمة الفاتورة';
                  },
                  onSaved: (val) {},
                  textDirection: TextDirection.rtl,
                  style: TextStyle(color: Colors.white),
                  cursorColor: mainColor,
                  keyboardType: TextInputType.phone,
                  controller: payment_val_controller,
                  decoration: InputDecoration(
                    hintText: "قيمة الفاتورة",
                    hintStyle: TextStyle(color: Colors.white),
                    hintTextDirection: TextDirection.rtl,
                    fillColor: secoundryColor,
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: TextFormField(
                  key: ValueKey('قيمة التنزيل'),
                  validator: (value) {
                    if (value!.isEmpty) return 'أدخل مباغ الدفعة';
                  },
                  onSaved: (val) {},
                  cursorColor: mainColor,
                  textDirection: TextDirection.rtl,
                  style: TextStyle(color: Colors.white),
                  keyboardType: TextInputType.name,
                  controller: reciever_controller,
                  decoration: InputDecoration(
                    hintText: "المدفوع",
                    hintStyle: TextStyle(color: Colors.white),
                    hintTextDirection: TextDirection.rtl,
                    fillColor: secoundryColor,
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  selectDate();
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  width: double.infinity,
                  height: 65,
                  child: Container(
                    margin: EdgeInsets.only(right: 10),
                    child: Text(
                      date_controller == "" || date_controller == null
                          ? 'التاريخ'
                          : date_controller,
                      textAlign: TextAlign.end,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: secoundryColor,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.white),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  form_key.currentState!.validate();
                  if (!form_key.currentState!.validate()) return;
                  savePayment(supplier);
                  Navigator.pop(context);
                },
                child: Container(
                  height: 40,
                  width: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.black,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(
                        Icons.receipt,
                        color: Colors.white,
                      ),
                      Text(
                        'إضافة الفاتورة',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void selectDate() async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2010),
        lastDate: DateTime(2150));
    if (pickedDate != null) print(date_controller);
    setState(() {
      date_controller = formatDate(
        pickedDate!,
        [yyyy, '-', mm, '-', dd],
      );
    });
  }

  savePayment(Supplier supplier) {
    try {
      Payment payment = Payment(
          payment: 0, date: "date", reciever: "reciever", payment_ID: '');

      setState(
        () {
          payment.payment = int.parse(payment_val_controller.text);
          payment.date = date_controller;
          payment.reciever = reciever_controller.text;

          form_key.currentState!.reset();
          date_controller = 'اختر التاريخ';
        },
      );
      store.add_supplier_Payment(
          Payment(
            payment: payment.payment,
            date: payment.date,
            reciever: payment.reciever,
            payment_ID: store.firestore
                .collection(suppliers_collection)
                .doc(supplier.supplierID)
                .collection(paymentDOC)
                .doc()
                .id,
          ),
          supplier);

      show_toast('تم اضافة الفاتورة بنجاح');
    } catch (e) {
      show_toast(e.toString());
    }
  }
}
