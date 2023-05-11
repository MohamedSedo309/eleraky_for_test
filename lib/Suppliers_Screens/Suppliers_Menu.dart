import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eleraky/Constants/Constants.dart';
import 'package:eleraky/Provider/store.dart';
import 'package:eleraky/Suppliers_Screens/supplier.dart';

import 'package:flutter/material.dart';
import 'package:search_page/search_page.dart';
import 'Supplier_Details.dart';

class Suppliers_Menu extends StatefulWidget {
  static String screenID = 'Suppliers_Menu';

  @override
  _Suppliers_MenuState createState() => _Suppliers_MenuState();
}

class _Suppliers_MenuState extends State<Suppliers_Menu> {
  @override
  Widget build(BuildContext context) {
    var store = Store();
    List<Supplier> suppliers_list = [];
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
          'قائمة الموردين',
          textAlign: TextAlign.center,
        ),
      ),
      body: StreamBuilder(
          stream: store.loadSuplliers(),
          builder: (BuildContext ctx, AsyncSnapshot<QuerySnapshot> snapshot) {
            suppliers_list = [];
            if (snapshot.data == null) {
              return Center(
                  child: Text(
                'لا يوجد موردين',
                textDirection: TextDirection.rtl,
              ));
            }

            snapshot.data!.docs.forEach((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data()! as Map<String, dynamic>;

              suppliers_list.add(Supplier(
                  supplier_name: data[nameDoc],
                  money: data[moneyDoc],
                  address: data[addressDoc],
                  phoneNumber: data[phoneDoc].toString(),
                  supplierID: document.id));
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
              itemCount: suppliers_list.length,
              itemBuilder: (context, index) {
                final Supplier person = suppliers_list[index];
                return ListTile(
                  focusColor: Colors.white,
                  title: Text(
                    person.supplier_name,
                    textAlign: TextAlign.right,
                    style: TextStyle(color: Colors.black),
                  ),
                  onTap: () => Navigator.pushNamed(
                      context, Supplier_details.screenID,
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
          delegate: SearchPage<Supplier>(
            barTheme: ThemeData(
                appBarTheme: AppBarTheme(backgroundColor: mainColor),
                textTheme:
                    Theme.of(context).textTheme.apply(bodyColor: Colors.white)),
            onQueryUpdate: (s) => print(s),
            items: suppliers_list,
            searchLabel: 'ادخل اسم المورد',
            failure: Center(
              child: Text('عفوا , لا يوجد موردين'),
            ),
            filter: (person) => [
              person.supplier_name,
            ],
            builder: (person) => ListTile(
              focusColor: Colors.white,
              title: Text(person.supplier_name),
              onTap: () => Navigator.pushReplacementNamed(
                  context, Supplier_details.screenID,
                  arguments: person),
            ),
          ),
        ),
        child: Icon(Icons.search),
      ),
    );
  }
}
