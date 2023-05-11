import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eleraky/Constants/Constants.dart';
import 'package:eleraky/Customers_Screens/Add_a_receipt.dart';
import 'package:eleraky/Customers_Screens/Edit_payments.dart';
import 'package:eleraky/Customers_Screens/get_a_Payment.dart';
import 'package:eleraky/Provider/store.dart';
import 'package:flutter/material.dart';
import '../payment.dart';
import 'customer.dart';

class Customer_details extends StatelessWidget {
  static String screenID = 'Customer_details';
  static const address = 'العنوان';
  static const phoneNum = 'رقم الموبايل';
  static const starting_balance = 'رصيد البداية';
  static const location = 'أصل الحساب';

  Store store = Store();
  final form_key = GlobalKey<FormState>();

  List<Payment> payments_list = [];
  List<int> sum = [];
  TextEditingController name_val_controller = TextEditingController();
  TextEditingController address_val_controller = TextEditingController();
  TextEditingController payment_val_controller = TextEditingController();

  TextEditingController date_controller = TextEditingController();
  TextEditingController phone_controller = TextEditingController();
  TextEditingController money_controller = TextEditingController();
  TextEditingController locatedIN_controller = TextEditingController();
  DateTime currentDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final Customer customer =
        ModalRoute.of(context)!.settings.arguments as Customer;
    double hieght = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    edit_customer() {
      final isValid = form_key.currentState!.validate();
      try {
        if (isValid) {
          form_key.currentState!.save();
          store.edit_Customer(Customer(
              customer_name: name_val_controller.text,
              money: int.parse(money_controller.text),
              address: address_val_controller.text,
              phoneNumber: phone_controller.text,
              customerID: customer.customerID,
              locatedIN: locatedIN_controller.text));
          show_toast('تم تعديل العميل');

          form_key.currentState!.reset();
        }
      } catch (e) {
        show_toast("حدث خطأ حاول مرة أخرى");
      }
    }

    Drawer drawer(Customer customer) {
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
                Navigator.pushNamed(context, Get_Payment.screenID,
                    arguments: customer);
              },
            ),
            ListTile(
              leading: Icon(Icons.receipt),
              title: Text(
                'سحب جديد',
                textAlign: TextAlign.end,
              ),
              onTap: () {
                Navigator.pushNamed(context, Add_a_Customer_Receipt.screenID,
                    arguments: customer);
              },
            ),
            ListTile(
              leading: Icon(Icons.input),
              title: Text(
                'تعديل الدفعات',
                textAlign: TextAlign.end,
              ),
              onTap: () {
                Navigator.pushNamed(context, Edit_customer_Payments.screenID,
                    arguments: customer);
              },
            ),
            ListTile(
              leading: Icon(Icons.settings_rounded),
              title: Text(
                'تعديل بيانات العميل',
                textAlign: TextAlign.end,
              ),
              onTap: () {
                showDialog(
                    context: context,
                    builder: (ctx) {
                      name_val_controller.text = customer.customer_name;
                      payment_val_controller.text = customer.money.toString();
                      address_val_controller.text = customer.address;
                      phone_controller.text = customer.phoneNumber;
                      locatedIN_controller.text = customer.locatedIN;
                      return AlertDialog(
                        title: Text(
                          'تعديل بيانات العميل',
                          textAlign: TextAlign.center,
                        ),
                        content: Form(
                          key: form_key,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
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
                                controller: name_val_controller,
                                cursorColor: mainColor,
                                style: TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  hintTextDirection: TextDirection.rtl,
                                  hintText: customer.customer_name,
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
                                style: TextStyle(color: Colors.white),
                                cursorColor: mainColor,
                                controller: payment_val_controller,
                                decoration: InputDecoration(
                                  hintTextDirection: TextDirection.rtl,
                                  hintText: customer.money.toString(),
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
                                style: TextStyle(color: Colors.white),
                                controller: address_val_controller,
                                decoration: InputDecoration(
                                  hintTextDirection: TextDirection.rtl,
                                  hintText: customer.address,
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
                                key: ValueKey('location'),
                                validator: (value) {
                                  if (value!.isEmpty)
                                    return 'ادخل مكان اصل الحساب';
                                },
                                onSaved: (val) {
                                  locatedIN_controller.text = val!;
                                },
                                cursorColor: mainColor,
                                style: TextStyle(color: Colors.white),
                                controller: locatedIN_controller,
                                decoration: InputDecoration(
                                  hintTextDirection: TextDirection.rtl,
                                  hintText: "أصل الحساب في دفتر ...",
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
                                style: TextStyle(color: Colors.white),
                                keyboardType: TextInputType.number,
                                controller: phone_controller,
                                decoration: InputDecoration(
                                  hintText: customer.phoneNumber.toString(),
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
                                  edit_customer();
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
                'حذف العميل',
                textAlign: TextAlign.end,
              ),
              onTap: () {
                showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                          title: Text(
                            'حذف هذا العميل ؟',
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
                                  store.delete_customer(customer);
                                  show_toast('تم حذف العميل');
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
      resizeToAvoidBottomInset: false,
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
      endDrawer: drawer(customer),
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
              child: Text(
                customer.customer_name,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.white,
                ),
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
                    customer.address,
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
                    Customer_details.address,
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
                    customer.phoneNumber.toString(),
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
                    Customer_details.phoneNum,
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
                    customer.locatedIN,
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
                    Customer_details.location,
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
              stream: store.loadPayments(customer),
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
                    notes: data[notesDOC],
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
                                customer.money.toString(),
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
                                  child: Text(getsum(index, customer.money),
                                      textAlign: TextAlign.center),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(5.0),
                                  child: Text(
                                      value_deleted_from_receipt == null
                                          ? payments_list[index].reciever
                                          : '${payments_list[index].reciever} \n المدفوع' +
                                                      "\n" +
                                                      ":  ملاحظات" +
                                                      "\n" +
                                                      payments_list[index]
                                                          .notes! ==
                                                  null
                                              ? ''
                                              : '${payments_list[index].notes}',
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
