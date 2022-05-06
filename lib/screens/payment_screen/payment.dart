import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:khnomapp/action/add_to_cart.dart';
import 'package:khnomapp/action/create_invoice.dart';
import 'package:khnomapp/action/generateQr.dart';
import 'package:khnomapp/action/get_product.dart';
import 'package:khnomapp/action/get_profileprefs.dart';
import 'package:khnomapp/config_ip.dart';
import 'package:khnomapp/model/cart_model.dart';
import 'package:khnomapp/model/invoice_model.dart';
import 'package:khnomapp/model/productfood_model.dart';
import 'package:khnomapp/model/profile_model.dart';
import 'package:khnomapp/nav/nav.dart';
import 'package:khnomapp/screens/cart_screeen/cart.dart';
import 'package:khnomapp/utility/my_style.dart';

class PaymentScreen extends StatefulWidget {
  static String routeName = "/payment";

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  Profile profile = Profile();
  InvoiceModel invoiceCreate = InvoiceModel();
  FoodModel product = FoodModel();
  Cart cartModel = Cart();
  bool check = false;

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context).settings.arguments as ScreenArguments;
    return Scaffold(
      backgroundColor: Color.fromARGB(241, 243, 243, 243),
      appBar: AppBar(
        title: const Text(
          'Payment',
          style: TextStyle(color: Colors.black),
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
      body: Stack(
        children: [
          ListView(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                height: 80,
                decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                          color: Color.fromARGB(255, 202, 202, 202), width: 1),
                    ),
                    color: Colors.white),
                child: Row(
                  children: [
                    Text(
                      'รวมยอดชำระเงิน',
                      style: TextStyle(fontSize: 20),
                    ),
                    Spacer(),
                    Text(
                      '฿${args.amount}',
                      style: TextStyle(
                          fontSize: 22,
                          color: Colors.deepOrange,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                height: 80,
                decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                          color: Color.fromARGB(255, 202, 202, 202), width: 1),
                    ),
                    color: Colors.white),
                child: Row(
                  children: [
                    Text(
                      'วิธีชำระเงิน',
                      style: TextStyle(fontSize: 20),
                    ),
                    Spacer(),
                    Text(
                      args.howpay,
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Container(
            alignment: Alignment.bottomCenter,
            child: Container(
              color: Color.fromARGB(255, 255, 255, 255),
              height: 80,
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: SizedBox(
                height: 60,
                width: double.infinity,
                child: Container(
                  height: 100,
                  decoration: BoxDecoration(color: MyStyle().colorCustom),
                  child: TextButton(
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.all(16.0),
                      primary: Colors.white,
                      textStyle: const TextStyle(fontSize: 20),
                    ),
                    onPressed: () async {
                      if (args.howpay == 'เงินสด') {
                        profile = await getProfile();
                        print('//////////////////////////');
                        print(args.howpay);
                        setState(() {
                          invoiceCreate = InvoiceModel(
                            product_id: args.product_id,
                            name_location: args.namelocation,
                            customer_name: profile.username,
                            customer_phone: profile.tel,
                            amount: args.amount,
                            quantity: args.qauntity,
                            date: args.dateMatFinal,
                            time: args.timeFinal,
                            status_pay: 'เงินสด',
                            receipt_status: 'จัดเตรียมสินค้า',
                            stid: args.stid,
                          );
                        });
                        await setInfo(invoiceCreate, args);
                        await showPaySuccess();
                      } else {
                        profile = await getProfile();
                        final url = Uri.parse(
                            "${ConfigIp.domain}/payment?amount=${args.amount}&currency=thb&email=${profile.email}");
                        final response = await http.get(url);
                        print(response.body);
                        var jsonBody = jsonDecode(response.body);
                        Map<String, dynamic> paymentIntentData;
                        paymentIntentData = jsonBody;
                        if (paymentIntentData["paymentIntent"] != "" &&
                            paymentIntentData["paymentIntent"] != null) {
                          String _intent = paymentIntentData["paymentIntent"];
                          await Stripe.instance.initPaymentSheet(
                            paymentSheetParameters: SetupPaymentSheetParameters(
                              paymentIntentClientSecret: _intent,
                              applePay: false,
                              googlePay: false,
                              merchantCountryCode: "TH",
                              merchantDisplayName: "Test",
                              testEnv: false,
                              customerId: paymentIntentData['customer'],
                              customerEphemeralKeySecret:
                                  paymentIntentData['ephemeralKey'],
                            ),
                          );
                          await Stripe.instance.presentPaymentSheet();
                          setState(() {
                            invoiceCreate = InvoiceModel(
                              product_id: args.product_id,
                              name_location: args.namelocation,
                              customer_name: profile.username,
                              customer_phone: profile.tel,
                              amount: args.amount,
                              quantity: args.qauntity,
                              date: args.dateMatFinal,
                              time: args.timeFinal,
                              status_pay: 'ชำระแล้ว',
                              receipt_status: 'จัดเตรียมสินค้า',
                              stid: args.stid,
                            );
                          });
                          await setInfo(invoiceCreate, args);
                          await showPaySuccess();
                        }
                      }
                    },
                    child: const Text(
                      'ชำระ',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }


  Future<bool> setInfo(InvoiceModel invoiceCreate, ScreenArguments args) async {
    await createInvoice(invoiceCreate);
    profile = await getProfile();
    product = await getProduct(args.product_id);
    print(product.quantity);
    var updateqauntity = product.quantity - int.parse(args.qauntity);
    await updateQuantity(updateqauntity, args.product_id);
    cartModel = await getCartid(profile.user_id);
    await deleteCart(cartModel.cart_id);
    return true;
  }

  Future showPaySuccess() async {
    showDialog(
        context: context,
        builder: (BuildContext builderContext) {
          Timer(Duration(seconds: 2), () {
            // Navigator.pushNamed(context, Nav.routeName);
            Navigator.popUntil(
                context, (route) => route.settings.name == Nav.routeName);
          });
          return AlertDialog(
            backgroundColor: Colors.green,
            title: Text(
              'Paid Successfully',
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
