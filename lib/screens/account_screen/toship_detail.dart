import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:khnomapp/config_ip.dart';
import 'package:khnomapp/model/invoice_model.dart';
import 'package:khnomapp/model/productfood_model.dart';
import 'package:khnomapp/screens/account_screen/page/map_toship.dart';
import 'package:http/http.dart' as http;
import 'package:khnomapp/screens/account_screen/toship.dart';

class ToshipDetail extends StatefulWidget {
  static var routeName = '/toship_detail';

  const ToshipDetail({Key key}) : super(key: key);

  @override
  State<ToshipDetail> createState() => _ToshipDetailState();
}

class _ToshipDetailState extends State<ToshipDetail> {
  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context).settings.arguments as SetArgumentInvoice;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'รายละเอียดการนัดรับ',
          style: TextStyle(
              color: Color.fromARGB(255, 61, 61, 61),
              fontSize: 20,
              fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new_rounded),
            color: Colors.black,
            onPressed: () {
              Navigator.of(context).pop();
            }),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                        color: Color.fromARGB(255, 190, 190, 190),
                        width: 1.5))),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 100,
                    width: 100,
                    child: Image(
                        image: NetworkImage(
                            '${ConfigIp.domain}/${args.product.image_path}',
                            scale: 5),
                        fit: BoxFit.cover),
                  ),
                  SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 16),
                      Text(
                        args.product.product_name,
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: 8),
                      Container(
                        width: 280,
                        child: Text(
                          'รายละเอียด : ${args.product.product_detail}',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                          softWrap: true,
                          // overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'ราคา/ชิ้น : ${args.product.price} ฿',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                    color: Color.fromARGB(255, 190, 190, 190), width: 1.5),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        'จำนวน',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                      Spacer(),
                      Text(
                        'x ${args.invoiceModel.quantity}',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Text(
                        'วันที่',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                      Spacer(),
                      Text(
                        args.invoiceModel.date,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Text(
                        'เวลา',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                      Spacer(),
                      Text(
                        '${args.invoiceModel.time} น.',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                    color: Color.fromARGB(255, 190, 190, 190), width: 1.5),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Row(children: [
                Text(
                  'สถานที่',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
                Spacer(),
                Row(
                  children: [
                    Text(
                      args.invoiceModel.name_location,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(width: 8),
                    Container(
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 12, 147, 224),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: IconButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed(
                            maptoship.routeName,
                            arguments: args.invoiceModel.name_location,
                          );
                        },
                        icon: Icon(
                          Icons.turn_right_rounded,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
              ]),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                    color: Color.fromARGB(255, 190, 190, 190), width: 1.5),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        'สถานะ',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                      Spacer(),
                      Text(
                        args.invoiceModel.receipt_status,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Text(
                        'การชำระเงิน',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                      Spacer(),
                      Text(
                        args.invoiceModel.status_pay,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 20),
          Container(
            height: 50,
            child: ElevatedButton(
              onPressed: () async {
                print('Click');
                await updatereceiptStatus(
                    args.invoiceModel.invoice_id, 'สำเร็จ');
                showSuccess();
              },
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                      Color.fromARGB(255, 107, 175, 28))),
              child: Text(
                'ยืนยันการรับสินค้า',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
            ),
          )
        ],
      ),
    );
  }

  Future updatereceiptStatus(invoice_id, receiptstatus) async {
    var url = '${ConfigIp.domain}/invoice/updatestatus/$invoice_id';

    http.Response response = await http.put(Uri.parse(url), body: {
      'receipt_status': receiptstatus,
    });
    var data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      print(response.body);
    } else {
      print(response.reasonPhrase);
    }
  }

  Future showSuccess() async {
    showDialog(
        context: context,
        builder: (BuildContext builderContext) {
          Timer(Duration(seconds: 2), () {
            // Navigator.pushNamed(context, Nav.routeName);
            Navigator.popUntil(
                context, (route) => route.settings.name == Toship.routeName);
          });
          return AlertDialog(
            backgroundColor: Colors.green,
            title: Text(
              'สำเร็จ',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          );
        });
  }
}

class SetArgumentInvoice {
  InvoiceModel invoiceModel;
  FoodModel product;
  SetArgumentInvoice(this.invoiceModel, this.product);
}
