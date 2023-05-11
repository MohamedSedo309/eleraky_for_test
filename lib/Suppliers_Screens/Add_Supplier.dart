import 'package:eleraky/Constants/Constants.dart';
import 'package:eleraky/Provider/store.dart';
import 'package:eleraky/Suppliers_Screens/supplier.dart';
import 'package:flutter/material.dart';

class Add_Supplier extends StatefulWidget {
  static String screenID = 'Add_Supplier';

  @override
  _Add_SupplierState createState() => _Add_SupplierState();
}

class _Add_SupplierState extends State<Add_Supplier> {
  final form_key = GlobalKey<FormState>();

  final store = Store();

  String name = '';

  int money = 0;

  String address = '';

  String phone = '';

  add() {
    final isValid = form_key.currentState!.validate();
    try {
      if (isValid) {
        form_key.currentState!.save();
        store.addSupplier(
          Supplier(
              supplier_name: name,
              money: money,
              address: address,
              phoneNumber: phone,
              supplierID:
                  store.firestore.collection(suppliers_collection).doc().id),
        );
        show_toast('تمت اضافة المورد');

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
                      if (value!.isEmpty) return 'أدخل إسم المورد';
                    },
                    onSaved: (val) {
                      name = val!;
                    },
                    cursorColor: mainColor,
                    decoration: InputDecoration(
                      hintTextDirection: TextDirection.rtl,
                      hintText: "إسم المورد",
                      hintStyle: TextStyle(color: Colors.white),
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
                      hintStyle: TextStyle(color: Colors.white),
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
                      hintStyle: TextStyle(color: Colors.white),
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
