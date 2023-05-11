import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eleraky/Constants/Constants.dart';
import 'package:eleraky/Provider/store.dart';
import 'package:eleraky/Suppliers_Screens/Edit_supplier_Payments.dart';
import 'package:eleraky/Suppliers_Screens/Pay_Payment.dart';
import 'package:eleraky/Suppliers_Screens/supplier.dart';
import 'package:flutter/material.dart';

import '../payment.dart';
import 'Add_a_receipt.dart';

class Supplier_details extends StatelessWidget {
  static String screenID = 'Supplier_details';
  static const address = 'العنوان';
  static const phoneNum = 'رقم الموبايل';
  static const starting_balance = 'رصيد البداية';

  Store store = Store();
  final form_key = GlobalKey<FormState>();
  List<Payment> payments_list = [];
  List<Payment> payments_list_toEdit = [];
  List<int> sum = [];
  TextEditingController name_val_controller = TextEditingController();
  TextEditingController address_val_controller = TextEditingController();

  TextEditingController date_controller = TextEditingController();
  TextEditingController phone_controller = TextEditingController();
  TextEditingController money_controller = TextEditingController();
  DateTime currentDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final Supplier supplier =
        ModalRoute.of(context)!.settings.arguments as Supplier;
    double hieght = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    edit_supplier() {
      final isValid = form_key.currentState!.validate();
      try {
        if (isValid) {
          form_key.currentState!.save();
          store.edit_supplier(Supplier(
            supplier_name: name_val_controller.text,
            money: int.parse(money_controller.text),
            address: address_val_controller.text,
            phoneNumber: phone_controller.text,
            supplierID: supplier.supplierID,
          ));
          show_toast('تمت تعديل المورد');

          form_key.currentState!.reset();
        }
      } catch (e) {
        show_toast("حدث خطأ حاول مرة أخرى");
      }
    }

    Drawer drawer(Supplier supplier) {
      return Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text(
                'تعديل الحساب',
                textAlign: TextAlign.end,
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
              decoration: BoxDecoration(
                color: secoundryColor,
              ),
            ),
            ListTile(
              leading: Icon(Icons.attach_money),
              title: Text(
                'تنزيل دفعة',
                textAlign: TextAlign.end,
              ),
              onTap: () {
                Navigator.pushNamed(context, Pay_Payment.screenID,
                    arguments: supplier);
              },
            ),
            ListTile(
              leading: Icon(Icons.receipt),
              title: Text(
                'تنزيل فاتورة',
                textAlign: TextAlign.end,
              ),
              onTap: () {
                Navigator.pushNamed(context, Add_a_Receipt.screenID,
                    arguments: supplier);
              },
            ),
            ListTile(
              leading: Icon(Icons.input),
              title: Text(
                'تعديل الدفعات',
                textAlign: TextAlign.end,
              ),
              onTap: () {
                Navigator.pushNamed(context, Edit_supplier_Payments.screenID,
                    arguments: supplier);
              },
            ),
            ListTile(
              leading: Icon(Icons.settings_rounded),
              title: Text(
                'تعديل بيانات المورد',
                textAlign: TextAlign.end,
              ),
              onTap: () {
                showDialog(
                    context: context,
                    builder: (ctx) {
                      name_val_controller.text = supplier.supplier_name;
                      money_controller.text = supplier.money.toString();
                      address_val_controller.text = supplier.address;
                      phone_controller.text = supplier.phoneNumber;
                      print(supplier.money);
                      return AlertDialog(
                        title: Text(
                          'تعديل بيانات المورد',
                          textAlign: TextAlign.center,
                        ),
                        content: Form(
                          key: form_key,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              TextFormField(
                                key: ValueKey('name'),
                                validator: (value) {
                                  if (value!.isEmpty) return 'أدخل إسم العميل';
                                },
                                onSaved: (val) {
                                  name_val_controller.text = val!;
                                },
                                cursorColor: mainColor,
                                controller: name_val_controller,
                                decoration: InputDecoration(
                                  hintTextDirection: TextDirection.rtl,
                                  hintText: supplier.supplier_name,
                                  hintStyle: TextStyle(color: Colors.grey),
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
                              TextFormField(
                                key: ValueKey('Price'),
                                validator: (value) {
                                  if (value!.isEmpty) return 'أدخل قيمة الحساب';
                                },
                                onSaved: (val) {
                                  money_controller.text = val!;
                                },
                                keyboardType: TextInputType.number,
                                cursorColor: mainColor,
                                controller: money_controller,
                                decoration: InputDecoration(
                                  hintTextDirection: TextDirection.rtl,
                                  hintText: supplier.money.toString(),
                                  hintStyle: TextStyle(color: Colors.grey),
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
                              TextFormField(
                                key: ValueKey('address'),
                                validator: (value) {
                                  if (value!.isEmpty)
                                    return 'أدخل العنوان من فضلك';
                                },
                                onSaved: (val) {
                                  address_val_controller.text = val!;
                                },
                                cursorColor: mainColor,
                                controller: address_val_controller,
                                decoration: InputDecoration(
                                  hintTextDirection: TextDirection.rtl,
                                  hintText: supplier.address,
                                  hintStyle: TextStyle(color: Colors.grey),
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
                              TextFormField(
                                key: ValueKey('phone'),
                                validator: (value) {
                                  if (value!.isEmpty)
                                    return 'أدخل رقم الموبايل';
                                },
                                onSaved: (val) {
                                  phone_controller.text = val!;
                                },
                                cursorColor: mainColor,
                                controller: phone_controller,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  hintText: supplier.phoneNumber.toString(),
                                  hintStyle: TextStyle(color: Colors.grey),
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
                                height: 5,
                              ),
                              GestureDetector(
                                onTap: () {
                                  edit_supplier();
                                  Navigator.pop(ctx);
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  height: 40,
                                  width: 150,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.black,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Icon(
                                        Icons.settings_rounded,
                                        color: Colors.white,
                                      ),
                                      Text(
                                        'تعديل',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 20),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    });
              },
            ),
            ListTile(
              leading: Icon(Icons.person_remove),
              title: Text(
                'حذف المورد',
                textAlign: TextAlign.end,
              ),
              onTap: () {
                showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                          title: Text(
                            'حذف هذا المورد ؟',
                            textAlign: TextAlign.center,
                          ),
                          content: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(ctx);
                                },
                                child: Text('إلغاء'),
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          secoundryColor),
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  store.delete_supplier(supplier);
                                  show_toast('تم حذف المورد');
                                  Navigator.pop(ctx);
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                },
                                child: Text('تأكيد'),
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          secoundryColor),
                                ),
                              ),
                            ],
                          ),
                        ));
              },
            ),
          ],
        ),
      );
    }

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: mainColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'تفاصيل الحساب',
          style: TextStyle(
            fontSize: 25,
          ),
        ),
        backgroundColor: mainColor,
      ),
      endDrawer: drawer(supplier),
      body: Padding(
        padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
        child: ListView(
          //crossAxisAlignment: CrossAxisAlignment.start,
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                color: secoundryColor,
                border: Border.all(color: secoundryColor, width: 4),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    supplier.supplier_name,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              decoration: BoxDecoration(
                color: secoundryColor,
                border: Border.all(color: secoundryColor, width: 4),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    supplier.address,
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    '  : ',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    Supplier_details.address,
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              decoration: BoxDecoration(
                color: secoundryColor,
                border: Border.all(color: secoundryColor, width: 4),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    supplier.phoneNumber.toString(),
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    ' : ',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    Supplier_details.phoneNum,
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 5,
            ),
            StreamBuilder(
              stream: store.loadSuppliers_payments(supplier),
              builder:
                  (BuildContext ctx, AsyncSnapshot<QuerySnapshot> snapshot) {
                sum = [];
                payments_list = [];
                if (snapshot.data == null) {
                  return Center(child: Text('loading...'));
                }

                snapshot.data!.docs.forEach((DocumentSnapshot document) {
                  Map<String, dynamic> data =
                      document.data()! as Map<String, dynamic>;

                  payments_list.add(Payment(
                    payment: data[paymentDOC],
                    date: data[dateDOC].toString(),
                    reciever: data[paymentRecieverDOC],
                    payment_ID: document.id,
                  ));
                });
                if (snapshot.hasError) {
                  return Center(child: Text('حدث خطأ , حاول مرة اخرى'));
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: Text("جاري التحميل ..."));
                }
                return Container(
                  width: width - 40,
                  height: hieght * 0.6,
                  color: Colors.white,
                  child: ListView(
                    children: [
                      Table(
                        border: TableBorder.all(color: Colors.black),
                        children: [
                          TableRow(
                            children: [
                              Text(
                                'الباقي',
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                'المستلم',
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                'التاريخ',
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                'المبلغ',
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ],
                      ),
                      Table(
                        border: TableBorder.all(color: Colors.black),
                        children: [
                          TableRow(
                            children: [
                              Text(
                                supplier.money.toString(),
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                '---',
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                '---',
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                'رصيد البداية',
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ],
                      ),
                      Table(
                        border: TableBorder.all(color: Colors.black),
                        children: List<TableRow>.generate(
                          payments_list.length,
                          (index) {
                            var value_deleted_from_receipt =
                                int.tryParse(payments_list[index].reciever);
                            return TableRow(
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(5.0),
                                  child: Text(getsum(index, supplier.money),
                                      textAlign: TextAlign.center),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(5.0),
                                  child: Text(
                                      value_deleted_from_receipt == null
                                          ? payments_list[index].reciever
                                          : '${payments_list[index].reciever} \n المدفوع',
                                      textAlign: TextAlign.center),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(5.0),
                                  child: Text(
                                    payments_list[index].date.toString(),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 13),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(5.0),
                                  child: Text(
                                      value_deleted_from_receipt == null
                                          ? '-  ' +
                                              payments_list[index]
                                                  .payment
                                                  .toString()
                                          : '+ ${payments_list[index].payment.toString()} \n فاتورة',
                                      textAlign: TextAlign.center),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  String getsum(index, int start) {
    var value_deleted_from_receipt =
        int.tryParse(payments_list[index].reciever);
    try {
      if (sum.isEmpty && value_deleted_from_receipt != null) {
        sum.add(
            start + (payments_list[0].payment - value_deleted_from_receipt));
        if (payments_list[0].payment - value_deleted_from_receipt < 0) {
          return '$start' +
              ' - ' +
              '${(payments_list[index].payment - value_deleted_from_receipt).abs()} ' +
              '\n= ${sum[index]}';
        }
        return '$start' +
            ' + ' +
            '${payments_list[index].payment - value_deleted_from_receipt} ' +
            '\n= ${sum[index]}';
      }
      if (sum.isEmpty) {
        sum.add(start - payments_list[0].payment);
        return sum[index].toString();
      }
      if (value_deleted_from_receipt != null) {
        sum.add(sum[index - 1] +
            (payments_list[index].payment - value_deleted_from_receipt));
        if (payments_list[index].payment - value_deleted_from_receipt < 0) {
          return '${sum[index - 1]}' +
              ' - ' +
              '${(payments_list[index].payment - value_deleted_from_receipt).abs()} ' +
              '\n= ${sum[index]}';
        }
        return '${sum[index - 1]}' +
            ' + ' +
            '${payments_list[index].payment - value_deleted_from_receipt} ' +
            '\n= ${sum[index]}';
      } else if (sum.length == 1) {
        sum.add(sum[index - 1] - payments_list[index].payment);

        return sum[index].toString();
      } else {
        sum.add(sum[index - 1] - payments_list[index].payment);
        return sum[index].toString();
      }
    } catch (e) {
      print(e);
      return '';
    }
  }
}
