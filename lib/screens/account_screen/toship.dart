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
import 'package:khnomapp/screens/account_screen/toship_detail.dart';

class Toship extends StatefulWidget {
  static var routeName = '/toship';

  Toship({Key key}) : super(key: key);

  @override
  _ToshipState createState() => _ToshipState();
}

class _ToshipState extends State<Toship> {
  Profile profile = Profile();
  List<InvoiceModel> invoiceModel = [];
  String customername;
  Future myfuture;
  FoodModel product = FoodModel();

  Store stName = Store();
  @override
  void initState() {
    // TODO: implement initState
    getInvoice();
    super.initState();
  }


  Future<bool> getInvoice() async {
    profile = await getProfile();
    var data = await getInvoiceBycustomer(profile.username);
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
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'รายการนัดรับ',
          style: TextStyle(color: Color.fromARGB(255, 61, 61, 61),fontSize: 20,fontWeight: FontWeight.bold),
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
      body: SingleChildScrollView(
        child: Container(
          height: heightScreen - 80,
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
                      Navigator.of(context).pushNamed(ToshipDetail.routeName,arguments: SetArgumentInvoice(invoiceModel[i],product),);
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
                            Container(
                              alignment: Alignment.center,
                              height: 80,
                              width: 120,
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 184, 130, 61),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      invoiceModel[i].date,
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      '${invoiceModel[i].time} น.',
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ),
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

  Future<FoodModel> getImageProduct(int productid) async {
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
                    width: 80,
                    height: 80,
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
