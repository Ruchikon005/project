import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:khnomapp/config_ip.dart';
import 'package:khnomapp/model/invoice_model.dart';

Future createInvoice(InvoiceModel invoiceCreate) async {
  print('test');
  var url = "${ConfigIp.domain}/invoice/addinvoice";
  print(invoiceCreate.stid);
  http.Response response = await http.post(Uri.parse(url), body: {
    'product_id': invoiceCreate.product_id.toString(),
    'name_location': invoiceCreate.name_location,
    'customer_name': invoiceCreate.customer_name,
    'customer_phone': invoiceCreate.customer_phone,
    'amount': invoiceCreate.amount,
    'quantity': invoiceCreate.quantity,
    'date': invoiceCreate.date,
    'time': invoiceCreate.time,
    'status_pay': invoiceCreate.status_pay,
    'stid': invoiceCreate.stid.toString(),
    'receipt_status': invoiceCreate.receipt_status,
  });
  var data = jsonDecode(response.body);
  print(data);

  if (data.toString() == "{message: Add invoice successful}") {
    print(response.body);
  } else {
    print(response.reasonPhrase);
  }
}

Future getInvoiceBystid(var stid) async {
  var url ='${ConfigIp.domain}/invoice/findbystid/$stid';

  http.Response response = await http.get(Uri.parse(url));
  var data = jsonDecode(response.body);
  if (response.statusCode == 200) {
    print(response.body);
    return data;
  } else {
    print(response.reasonPhrase);
  }
}

Future getInvoiceBycustomer(var customer_name) async {
  var url ='${ConfigIp.domain}/invoice/findbycustomer_name/$customer_name';

  http.Response response = await http.get(Uri.parse(url));
  var data = jsonDecode(response.body);
  if (response.statusCode == 200) {
    print(response.body);
    return data;
  } else {
    print(response.reasonPhrase);
  }
}


