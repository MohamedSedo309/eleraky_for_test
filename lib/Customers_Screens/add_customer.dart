import 'package:eleraky/Constants/Constants.dart';
import 'package:eleraky/Provider/store.dart';
import 'package:flutter/material.dart';

import 'customer.dart';

class Add_Customer extends StatefulWidget {
  static String screenID = 'Add_Customer';

  @override
  _Add_CustomerState createState() => _Add_CustomerState();
}

class _Add_CustomerState extends State<Add_Customer> {
  final form_key = GlobalKey<FormState>();

  final store = Store();

  String name = '';

  int money = 0;

  String address = '';
  String locatedIN = '';

  String phone = '';

  add() {
    final isValid = form_key.currentState!.validate();
    try {
      if (isValid) {
        form_key.currentState!.save();
        store.addCustomer(
          Customer(
              customer_name: name,
              money: money,
              address: address,
              phoneNumber: phone,
              customerID:
                  store.firestore.collection(customers_collection).doc().id,
              locatedIN: locatedIN),
        );
        show_toast('تمت اضافة العميل');

        form_key.currentState!.reset();
      }
    } catch (e) {
      show_toast("حدث خطأ حاول مرة أخرى");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColor,
      body: Center(
        child: Form(
          key: form_key,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 100),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextFormField(
                    key: ValueKey('name'),
                    validator: (value) {
                      if (value!.isEmpty) return 'أدخل إسم العميل';
                    },
                    onSaved: (val) {
                      name = val!;
                    },
                    cursorColor: mainColor,
                    decoration: InputDecoration(
                      hintTextDirection: TextDirection.rtl,
                      hintText: "إسم العميل",
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
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    key: ValueKey('Price'),
                    validator: (value) {
                      if (value!.isEmpty) return 'أدخل قيمة الحساب';
                    },
                    onSaved: (val) {
                      money = int.parse(val!);
                    },
                    keyboardType: TextInputType.number,
                    cursorColor: mainColor,
                    decoration: InputDecoration(
                      hintTextDirection: TextDirection.rtl,
                      hintText: "قيمة الحساب",
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
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    key: ValueKey('address'),
                    validator: (value) {
                      if (value!.isEmpty) return 'أدخل العنوان من فضلك';
                    },
                    onSaved: (val) {
                      address = val!;
                    },
                    cursorColor: mainColor,
                    decoration: InputDecoration(
                      hintTextDirection: TextDirection.rtl,
                      hintText: "العنوان",
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
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    key: ValueKey('locatedin'),
                    validator: (value) {
                      if (value!.isEmpty) return 'ادخل مكان اصل الحساب';
                    },
                    onSaved: (val) {
                      locatedIN = val!;
                    },
                    cursorColor: mainColor,
                    decoration: InputDecoration(
                      hintTextDirection: TextDirection.rtl,
                      hintText: "أصل الحساب في دفتر ...",
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
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    key: ValueKey('phone'),
                    validator: (value) {
                      if (value!.isEmpty) return 'أدخل رقم الموبايل';
                    },
                    onSaved: (val) {
                      phone = val!;
                    },
                    cursorColor: mainColor,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: "رقم الموبايل",
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
                  SizedBox(
                    height: 15,
                  ),
                  GestureDetector(
                    onTap: () {
                      add();
                    },
                    child: Container(
                      height: 40,
                      width: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.black,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(
                            Icons.person_add,
                            color: Colors.white,
                          ),
                          Text(
                            'إضافة',
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
        ),
      ),
    );
  }
}
