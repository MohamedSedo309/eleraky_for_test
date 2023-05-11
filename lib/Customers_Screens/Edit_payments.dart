import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eleraky/Constants/Constants.dart';
import 'package:eleraky/Provider/store.dart';
import 'package:flutter/material.dart';
import 'package:date_format/date_format.dart';
import '../payment.dart';
import 'customer.dart';

class Edit_customer_Payments extends StatefulWidget {
  static String screenID = 'Edit_customer_Payments';

  @override
  _Edit_customer_PaymentsState createState() => _Edit_customer_PaymentsState();
}

class _Edit_customer_PaymentsState extends State<Edit_customer_Payments> {
  List<Payment>? payments_list = [];

  String date_controller = '';
  GlobalKey<FormState> form_key = GlobalKey<FormState>();
  TextEditingController payment_val_controller = TextEditingController();

  TextEditingController reciever_controller = TextEditingController();
  Store store = Store();

  @override
  Widget build(BuildContext context) {
    final Customer customer =
        ModalRoute.of(context)!.settings.arguments as Customer;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: secoundryColor,
        title: Text('تعديل الدفعات'),
        centerTitle: true,
      ),
      body: StreamBuilder(
          stream: store.loadPayments(customer),
          builder: (BuildContext ctx, AsyncSnapshot<QuerySnapshot> snapshot) {
            payments_list = [];
            date_controller = '';
            if (snapshot.data == null) {
              return Center(child: Text('loading...'));
            }

            snapshot.data!.docs.forEach((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data()! as Map<String, dynamic>;

              payments_list!.add(Payment(
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
            return ListView.separated(
              itemCount: payments_list!.length,
              itemBuilder: (ctx, index) {
                var value_deleted_from_receipt =
                    int.tryParse(payments_list![index].reciever);
                return ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(payments_list![index].payment.toString()),
                      Text(value_deleted_from_receipt == null
                          ? payments_list![index].reciever
                          : 'فاتورة'),
                    ],
                  ),
                  subtitle: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        payments_list![index].date.toString(),
                        style: TextStyle(color: Colors.black87),
                      ),
                      Text(
                        value_deleted_from_receipt == null
                            ? 'دفعة'
                            : payments_list![index].reciever,
                        style: TextStyle(color: Colors.black87),
                      ),
                    ],
                  ),
                  selectedTileColor: Colors.cyan,
                  onTap: () {
                    showAlert(ctx, payments_list![index], customer);
                  },
                  onLongPress: () {
                    showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                              title: Text(value_deleted_from_receipt == null
                                  ? 'هل تريد حذف هذه الدفعة ؟'
                                  : 'هل تريد حذف هذه الفاتورة ؟'),
                              content: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                      store.delete_customer_payment(
                                          customer, payments_list![index]);
                                      Navigator.pop(ctx);
                                      show_toast('تم الحذف بنجاح');
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
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return Divider(
                  color: Colors.black,
                  height: 10,
                );
              },
            );
          }),
    );
  }

  Future showAlert(crx, Payment payment, Customer customer) async {
    var value_deleted_from_receipt = int.tryParse(payment.reciever);
    payment_val_controller.text = payment.payment.toString();
    reciever_controller.text = payment.reciever.toString();
    date_controller = payment.date;
    showDialog(
        context: crx,
        builder: (crx) => StatefulBuilder(
            builder: (ctc, setDialogstate) => Form(
                  key: form_key,
                  child: AlertDialog(
                    backgroundColor: mainColor,
                    content: Container(
                      height: 350,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            height: 50,
                            width: double.infinity,
                            child: TextFormField(
                              key: ValueKey('قيمة الدفعة'),
                              validator: (value) {
                                if (value!.isEmpty)
                                  return value_deleted_from_receipt == null
                                      ? 'أدخل قيمة الدفعة'
                                      : 'أدخل قيمة الفاتورة';
                              },
                              onSaved: (val) {},
                              textDirection: TextDirection.rtl,
                              style: TextStyle(color: Colors.white),
                              cursorColor: mainColor,
                              keyboardType: TextInputType.number,
                              controller: payment_val_controller,
                              decoration: InputDecoration(
                                hintText: value_deleted_from_receipt == null
                                    ? payment.payment.toString() +
                                        '     ' +
                                        'قيمة الدفعة'
                                    : payment.payment.toString() +
                                        '     ' +
                                        'قيمة الفاتورة',
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
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Container(
                            height: 50,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: secoundryColor,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: Colors.white),
                            ),
                            child: GestureDetector(
                              onTap: () async {
                                final DateTime? pickedDate =
                                    await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(2010),
                                        lastDate: DateTime(2150));
                                if (pickedDate != null) print(date_controller);
                                setDialogstate(() {
                                  date_controller = formatDate(
                                    pickedDate!,
                                    [yyyy, '-', mm, '-', dd],
                                  );
                                });
                              },
                              child: Container(
                                margin: EdgeInsets.only(right: 10, top: 8),
                                child: Text(
                                  date_controller == "" ||
                                          date_controller == null
                                      ? payment.date.toString()
                                      : date_controller,
                                  textAlign: TextAlign.end,
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Container(
                            height: 50,
                            width: double.infinity,
                            child: TextFormField(
                              key: ValueKey('المستلم'),
                              validator: (value) {
                                if (value!.isEmpty)
                                  return value_deleted_from_receipt == null
                                      ? 'أدخل اسم المستلم'
                                      : 'ادخل المبلغ المدفوع';
                              },
                              onSaved: (val) {},
                              cursorColor: mainColor,
                              textDirection: TextDirection.rtl,
                              style: TextStyle(color: Colors.white),
                              keyboardType: TextInputType.name,
                              controller: reciever_controller,
                              decoration: InputDecoration(
                                hintText: value_deleted_from_receipt == null
                                    ? payment.reciever +
                                        '     ' +
                                        "المستلم/ملاحظات"
                                    : payment.reciever + '     ' + "المدفوع",
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
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Container(
                            child: GestureDetector(
                              onTap: () {
                                form_key.currentState!.validate();
                                if (form_key.currentState!.validate()) {
                                  editPayment(customer, payment);
                                }
                              },
                              child: Container(
                                height: 40,
                                width: 160,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.black,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Icon(
                                      Icons.settings,
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
                          ),
                        ],
                      ),
                    ),
                  ),
                )));
  }

  editPayment(Customer customer, Payment payment) {
    try {
      Payment mpayment = Payment(
          payment: 0, date: "date", reciever: "reciever", payment_ID: '');

      setState(
        () {
          mpayment.payment = int.parse(payment_val_controller.text);
          mpayment.date = date_controller;
          mpayment.reciever = reciever_controller.text;
        },
      );
      store.edit_Customer_Payments(
          customer,
          Payment(
            payment: mpayment.payment,
            date: mpayment.date,
            reciever: mpayment.reciever,
            payment_ID: payment.payment_ID,
          ));
      payment_val_controller.clear();
      form_key.currentState!.reset();
      show_toast('تم التعديل بنجاح');
      Navigator.pop(context);
    } catch (e) {
      show_toast(e.toString());
    }
  }
}
