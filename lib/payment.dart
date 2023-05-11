class Payment {
  int payment;
  String date;
  String reciever;
  String? notes;
  String payment_ID;

  Payment(
      {required this.payment,
      required this.date,
      required this.reciever,
      this.notes,
      required this.payment_ID});
}
