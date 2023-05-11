import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eleraky/Constants/Constants.dart';
import 'package:eleraky/Customers_Screens/customer.dart';
import 'package:eleraky/Suppliers_Screens/supplier.dart';

import '../payment.dart';

class Store {
  final firestore = FirebaseFirestore.instance;

  addCustomer(Customer customer) async {
    try {
      /*
      await firestore.collection(customers_collection).add({
        nameDoc: customer.customer_name,
        moneyDoc: customer.money,
        addressDoc: customer.address,
        phoneDoc: customer.phoneNumber,
        locatedINDoc: customer.locatedIN,
      });
      */
    } catch (e) {
      print(e);
      throw e;
    }
  }

  addSupplier(Supplier supplier) async {
    try {
      /*
      await firestore.collection(suppliers_collection).add({
        nameDoc: supplier.supplier_name,
        moneyDoc: supplier.money,
        addressDoc: supplier.address,
        phoneDoc: supplier.phoneNumber,
      });
      */
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Stream<QuerySnapshot>? loadCustomers() {
    try {
      /*
      return firestore
          .collection(customers_collection)
          .orderBy(nameDoc)
          .snapshots();

       */
    } catch (e) {
      print('$e');
    }
  }

  Stream<QuerySnapshot>? loadSuplliers() {
    try {
      /*
      return firestore
          .collection(suppliers_collection)
          .orderBy(nameDoc)
          .snapshots();

       */
    } catch (e) {
      print('$e');
    }
  }

  addPayment(Payment payment, Customer customer) async {
    try {
      /*
      await firestore
          .collection(customers_collection)
          .doc(customer.customerID)
          .collection(payment_collection)
          .add({
        paymentDOC: payment.payment,
        dateDOC: payment.date,
        notesDOC: payment.notes,
        paymentRecieverDOC: payment.reciever,
      });

       */
    } catch (e) {
      print(e);
      throw e;
    }
  }

  add_supplier_Payment(Payment payment, Supplier supplier) async {
    try {
      /*
      await firestore
          .collection(suppliers_collection)
          .doc(supplier.supplierID)
          .collection(payment_collection)
          .add({
        paymentDOC: payment.payment,
        dateDOC: payment.date,
        paymentRecieverDOC: payment.reciever,
        payment_id_DOC: payment.payment_ID,
      });

       */
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Stream<QuerySnapshot>? loadPayments(Customer customer) {
    try {
      /*
      return firestore
          .collection(customers_collection)
          .doc(customer.customerID)
          .collection(payment_collection)
          .orderBy(dateDOC)
          .snapshots();

       */
    } catch (e) {
      print('$e');
    }
  }

  Stream<QuerySnapshot>? loadSuppliers_payments(Supplier supplier) {
    try {
      /*
      return firestore
          .collection(suppliers_collection)
          .doc(supplier.supplierID)
          .collection(payment_collection)
          .orderBy(dateDOC)
          .snapshots();
          */
    } catch (e) {
      print('$e');
    }
  }

  edit_Supplier_Payments(Supplier supplier, Payment payment) {
    /*
    firestore
        .collection(suppliers_collection)
        .doc(supplier.supplierID)
        .collection(payment_collection)
        .doc(payment.payment_ID)
        .update({
      paymentDOC: payment.payment,
      dateDOC: payment.date,
      paymentRecieverDOC: payment.reciever,
    });

     */
    return;
  }

  edit_Customer_Payments(Customer customer, Payment payment) {
    /*
    firestore
        .collection(customers_collection)
        .doc(customer.customerID)
        .collection(payment_collection)
        .doc(payment.payment_ID)
        .update({
      paymentDOC: payment.payment,
      dateDOC: payment.date,
      paymentRecieverDOC: payment.reciever,
    });

     */
  }

  edit_Customer(Customer customer) {
    /*
    firestore.collection(customers_collection).doc(customer.customerID).update({
      nameDoc: customer.customer_name,
      moneyDoc: customer.money,
      addressDoc: customer.address,
      phoneDoc: customer.phoneNumber,
      locatedINDoc: customer.locatedIN,
    });

     */
  }

  edit_supplier(Supplier supplier) {
    /*
    firestore.collection(suppliers_collection).doc(supplier.supplierID).update({
      nameDoc: supplier.supplier_name,
      moneyDoc: supplier.money,
      addressDoc: supplier.address,
      phoneDoc: supplier.phoneNumber
    });

     */
  }

  delete_customer_payment(Customer customer, Payment payment) {
    /*
    firestore
        .collection(customers_collection)
        .doc(customer.customerID)
        .collection(payment_collection)
        .doc(payment.payment_ID)
        .delete();

     */
  }

  delete_supplier_payment(Supplier supplier, Payment payment) {
    /*
    firestore
        .collection(suppliers_collection)
        .doc(supplier.supplierID)
        .collection(payment_collection)
        .doc(payment.payment_ID)
        .delete();

     */
  }

  delete_supplier(Supplier supplier) {
    /*
    firestore
        .collection(suppliers_collection)
        .doc(supplier.supplierID)
        .delete();

     */
  }

  delete_customer(Customer customer) {
    /*
    firestore
        .collection(customers_collection)
        .doc(customer.customerID)
        .delete();

     */
  }
}
