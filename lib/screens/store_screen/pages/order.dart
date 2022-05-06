import 'dart:convert' as convert;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:khnomapp/action/create_invoice.dart';
import 'package:khnomapp/action/get_myproduct.dart';
import 'package:khnomapp/action/get_profileprefs.dart';
import 'package:khnomapp/config_ip.dart';
import 'package:khnomapp/main.dart';
import 'package:khnomapp/model/invoice_model.dart';
import 'package:khnomapp/model/productfood_model.dart';
import 'package:khnomapp/model/profile_model.dart';
import 'package:http/http.dart' as http;
import 'package:khnomapp/model/store_model.dart';
import 'package:khnomapp/screens/store_screen/pages/order_detail.dart';

class Order extends StatefulWidget {
  static var routeName = '/order';

  Order({Key key}) : super(key: key);

  @override
  _OrderState createState() => _OrderState();
}

class _OrderState extends State<Order> {
  Profile profile = Profile();
  List<InvoiceModel> invoiceModel = [];
  int stid;
  Future myfuture;
  FoodModel product = FoodModel();

  Store stName = Store();
  @override
  void initState() {
    // TODO: implement initState
    getInvoice();
    super.initState();
  }

  getStoreDetail() async {
    profile = await getProfile();
    print(profile.user_id);
    var url = Uri.parse(
        '${ConfigIp.domain}/stores/ownerfindstore/${profile.user_id}');
    final response = await http.get(url);

    print(response.body);
    var res = json.decode(response.body);
    if (response.statusCode == 200) {
      stName = Store.fromJson(res);
      stid = stName.store_id;
      print(stName.store_id);
    } else {
      print(response.body);
    }
  }

  Future<bool> getInvoice() async {
    invoiceModel = [];
    await getStoreDetail();
    var data = await getInvoiceBystid(stid);
    print(data);
    print('Testtttttttttttttttttttttttttttttttttt');
    for (var item in data) {
      InvoiceModel invoice = InvoiceModel.fromJson(item);
      setState(() {
        invoiceModel.add(invoice);
      });
    }
    return true;
  }

  // getProduct() async {
  //   await getInvoice();
  //   await getProductByid(invoiceModel.);
  // }

  @override
  Widget build(BuildContext context) {
    var weightScreen = MediaQuery.of(context).size.width;
    var heightScreen = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: RefreshIndicator(
        onRefresh: getInvoice,
        child: Container(
          height: heightScreen - 350,
          child: ListView.builder(
              // shrinkWrap: true,
              scrollDirection: Axis.vertical,
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: invoiceModel.length,
              itemBuilder: (ctx, i) {
                return Container(
                  height: 100,
                  child: InkWell(
                    onTap: () {
                      print('Click');
                      Navigator.of(context).pushNamed(
                        OrderDetail.routeName,
                        arguments: SetArgumentInvoice(invoiceModel[i], product),
                      );
                    },
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            getProduct(invoiceModel[i]),
                            Spacer(),
                            invoiceModel[i].receipt_status == 'สำเร็จ'
                                ? Container(
                                    alignment: Alignment.center,
                                    height: 40,
                                    width: 100,
                                    decoration: BoxDecoration(
                                      color: Color.fromARGB(255, 201, 201, 201),
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    child: Text(
                                      invoiceModel[i].receipt_status,
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )
                                : Container(
                                    alignment: Alignment.center,
                                    height: 40,
                                    width: 100,
                                    decoration: BoxDecoration(
                                      color: Colors.lightGreen,
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    child: Text(
                                      invoiceModel[i].status_pay,
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }),
        ),
      ),
    );
  }

  Future<FoodModel> getImageProduct(productid) async {
    var data = await getProductByid(productid);
    product = FoodModel.fromJson(data);
    print(product.image_path);
    return product;
  }

  Widget getProduct(InvoiceModel productlist) {
    return FutureBuilder(
        future: getImageProduct(productlist.product_id),
        builder: (BuildContext context, AsyncSnapshot<FoodModel> snapshot) {
          if (snapshot.hasData) {
            return Container(
              child: Row(
                children: [
                  Container(
                    height: 80,
                    width: 80,
                    child: Image(
                        image: NetworkImage(
                            '${ConfigIp.domain}/${snapshot.data.image_path}'),
                        fit: BoxFit.cover),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(snapshot.data.product_name,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w600)),
                      Row(
                        children: [
                          Icon(
                            Icons.shopping_bag_outlined,
                            size: 20,
                            color: Colors.black54,
                          ),
                          SizedBox(width: 10),
                          Text('จำนวน   x${productlist.quantity} ชิ้น'),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            size: 20,
                            color: Colors.black54,
                          ),
                          SizedBox(width: 10),
                          Text(productlist.name_location),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            );
          } else {
            return Container();
          }
        });
  }
}
