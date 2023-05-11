import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eleraky/Constants/Constants.dart';
import 'package:eleraky/Customers_Screens/Customer_Details.dart';
import 'package:eleraky/Provider/store.dart';
import 'package:flutter/material.dart';
import 'package:search_page/search_page.dart';
import 'customer.dart';

class Customers_Menu extends StatefulWidget {
  static String screenID = 'Customers_Menu';

  @override
  _Suppliers_MenuState createState() => _Suppliers_MenuState();
}

class _Suppliers_MenuState extends State<Customers_Menu> {
  @override
  Widget build(BuildContext context) {
    var store = Store();
    List<Customer> customers_list = [];
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: mainColor,
        title: Text(
          'قائمة العملاء',
          textAlign: TextAlign.center,
        ),
      ),
      body: StreamBuilder(
          stream: store.loadCustomers(),
          builder: (BuildContext ctx, AsyncSnapshot<QuerySnapshot> snapshot) {
            customers_list = [];
            if (snapshot.data == null) {
              return Center(
                  child: Text(
                'لا يوجد عملاء',
                textDirection: TextDirection.rtl,
              ));
            }

            snapshot.data!.docs.forEach((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data()! as Map<String, dynamic>;

              customers_list.add(
                Customer(
                    customer_name: data[nameDoc],
                    money: data[moneyDoc],
                    address: data[addressDoc],
                    phoneNumber: data[phoneDoc].toString(),
                    locatedIN: data[locatedINDoc],
                    customerID: document.id),
              );
            });
            if (snapshot.hasError) {
              return Center(child: Text('حدث خطأ , حاول مرة اخرى'));
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                  child: Text(
                "جاري التحميل ...",
                textDirection: TextDirection.rtl,
              ));
            }
            return ListView.separated(
              itemCount: customers_list.length,
              itemBuilder: (context, index) {
                final Customer person = customers_list[index];
                return ListTile(
                  focusColor: Colors.white,
                  title: Text(
                    person.customer_name,
                    textAlign: TextAlign.right,
                    style: TextStyle(color: Colors.black),
                  ),
                  onTap: () => Navigator.pushNamed(
                      context, Customer_details.screenID,
                      arguments: person),
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: mainColor,
        tooltip: 'Search people',
        onPressed: () => showSearch(
          context: context,
          delegate: SearchPage<Customer>(
            barTheme: ThemeData(
                appBarTheme: AppBarTheme(backgroundColor: mainColor),
                textTheme:
                    Theme.of(context).textTheme.apply(bodyColor: Colors.white)),
            onQueryUpdate: (s) => print(s),
            items: customers_list,
            searchLabel: 'ادخل اسم العميل',
            failure: Center(
              child: Text('عفوا , لا يوجد عملاء'),
            ),
            filter: (person) => [
              person.customer_name,
            ],
            builder: (person) => ListTile(
              focusColor: Colors.white,
              title: Text(person.customer_name),
              onTap: () => Navigator.pushReplacementNamed(
                  context, Customer_details.screenID,
                  arguments: person),
            ),
          ),
        ),
        child: Icon(Icons.search),
      ),
    );
  }
}
