import 'package:flutter/material.dart';
import 'package:khnomapp/config_ip.dart';
import 'package:khnomapp/model/invoice_model.dart';
import 'package:khnomapp/model/productfood_model.dart';
import 'package:khnomapp/screens/store_screen/pages/map_order.dart';

class OrderDetail extends StatefulWidget {
  static var routeName = '/order_detail';

  const OrderDetail({Key key}) : super(key: key);

  @override
  State<OrderDetail> createState() => _OrderDetailState();
}

class _OrderDetailState extends State<OrderDetail> {
  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context).settings.arguments as SetArgumentInvoice;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'รายละเอียดที่ต้องจัดส่ง',
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
                    color: Color.fromARGB(255, 190, 190, 190), width: 1.5),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'ผู้สั่ง',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(height: 16),
                      Text(
                        'ชื่อ : ${args.invoiceModel.customer_name}',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'เบอร์โทรศัพท์ : ${args.invoiceModel.customer_phone}',
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
                            mapOrder.routeName,
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
        ],
      ),
    );
  }
}

class SetArgumentInvoice {
  InvoiceModel invoiceModel;
  FoodModel product;
  SetArgumentInvoice(this.invoiceModel, this.product);
}
