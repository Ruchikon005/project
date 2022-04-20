class InvoiceModel {
  final int invoice_id;
  final int product_id;
  final String name_location;
  final String customer_name;
  final String customer_phone;
  final String amount;
  final String quantity;
  final String date;
  final String time;
  final String status_pay;
  final String receipt_status;
  final String createdAt;
  final String updateAt;
  final int stid;

  InvoiceModel({
    this.invoice_id,
    this.product_id,
    this.name_location,
    this.customer_name,
    this.customer_phone,
    this.amount,
    this.quantity,
    this.date,
    this.time,
    this.status_pay,
    this.receipt_status,
    this.stid,
    this.createdAt,
    this.updateAt,
  });

  factory InvoiceModel.fromJson(Map<String, dynamic> json) {
    return InvoiceModel(
      invoice_id: json['invoice_id'] as int,
      product_id: json['product_id'] as int,
      name_location: json['name_location'] as String,
      customer_name: json['customer_name'] as String,
      customer_phone: json['customer_phone'] as String,
      amount: json['amount'] as String,
      quantity: json['quantity'] as String,
      date: json['date'] as String,
      time: json['time'] as String,
      status_pay: json['status_pay'] as String,
      receipt_status: json['receipt_status'] as String,
      createdAt: json['createdAt'] as String,
      updateAt: json['updateAt'] as String,
      stid: json['stid'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['invoice_id'] = this.invoice_id;
    data['product_id'] = this.product_id;
    data['name_location'] = this.name_location;
    data['customer_name'] = this.customer_name;
    data['customer_phone'] = this.customer_phone;
    data['amount'] = this.amount;
    data['quantity'] = this.quantity;
    data['date'] = this.date;
    data['time'] = this.time;
    data['status_pay'] = this.status_pay;
    data['receipt_status'] = this.receipt_status;
    data['createdAt'] = this.createdAt;
    data['updateAt'] = this.updateAt;
    data['stid'] = this.stid;
    return data;
  }
}
