import 'dart:async';

import 'package:flutter/material.dart';
import 'package:khnomapp/action/add_to_cart.dart';
import 'package:khnomapp/config_ip.dart';
import 'package:khnomapp/model/myproduct_model.dart';
import 'package:khnomapp/model/productfood_model.dart';
import 'package:khnomapp/screens/product_detail_screen/widget_detail/box_shop.dart';
// import 'package:khnomapp/model/product_model.dart';
import 'package:khnomapp/screens/product_detail_screen/widget_detail/info_product.dart';
import 'package:khnomapp/screens/product_detail_screen/widget_detail/product_image.dart';
import 'package:khnomapp/screens/store_screen/pages/my_product_list.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class Body extends StatefulWidget {
  const Body({
    Key key,
    this.product,
    // this.product,
  }) : super(key: key);
  final Myproduct product;

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  static SharedPreferences prefs;
  FoodModel foodModel = FoodModel();

  Map<String, dynamic> profile = {
    'user_id': '',
    'username': '',
    'email': '',
    "role": ''
  };

  @override
  void initState() {
    // TODO: implement initState
    _getProfile();
    super.initState();
  }

  void _getProfile() async {
    prefs = await SharedPreferences.getInstance();
    var profileString = prefs.getString('profile');
    print(profileString);
    if (profileString != null) {
      setState(() {
        profile = convert.jsonDecode(profileString);
        print(profile['user_id']);
      });
    }
  }

  Future getMyCart() async {
    String uid = profile['user_id'].toString();
    print(uid);
    var url = Uri.parse('${ConfigIp.domain}/cart/mycart/$uid');
    final response = await http.get(url);
    print(response.body);
    var res = convert.jsonDecode(response.body);
    foodModel = FoodModel.fromJson(res);
    print(foodModel.product_id);
    // return foodModel.product_id;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade300,
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProductImage(product: widget.product),
              InfoProduct(product: widget.product),
              SizedBox(height: 10),
              BoxShop(product: widget.product),

              // Text('data')
            ],
          ),
          Container(
            alignment: Alignment.bottomCenter,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: Colors.amber.shade800,
                  fixedSize: Size(300, 70),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50))),
              onPressed: () async {
                await getMyCart();
                if (foodModel.product_id != null) {
                  if (foodModel.product_id == widget.product.product_id) {
                    print('have item in Cart');
                    return showDialog(
                        context: context,
                        builder: (BuildContext builderContext) {
                          Timer(Duration(seconds: 2), () {
                            Navigator.of(context).pop();
                          });
                          return AlertDialog(
                            title: Text('รายการนี้อยู่ในตะกล้าแล้ว',textAlign: TextAlign.center),
                          );
                        });
                  } else {
                    print('update');
                    return showDialog(
                        context: context,
                        builder: (BuildContext builderContext) {
                          return AlertDialog(
                            title: Text('เปลี่ยนรายการในตะกล้า',textAlign: TextAlign.center),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('ยกเลิก')),
                              TextButton(
                                  onPressed: () {
                                    setState(() async {
                                      await updateCart(
                                          widget.product.product_id.toString(),
                                          profile['user_id'].toString());
                                      Navigator.of(context).pop();
                                      showDialog(
                                          context: context,
                                          builder:
                                              (BuildContext builderContext) {
                                            Timer(Duration(seconds: 1), () {
                                              Navigator.of(context).pop();
                                            });
                                            return AlertDialog(
                                              title:
                                                  Text('เปลี่ยนรายการสำเร็จ',textAlign: TextAlign.center),
                                            );
                                          });
                                    });
                                  },
                                  child: Text('ยืนยัน'))
                            ],
                          );
                        });
                  }
                } else {
                  setState(() async {
                    await addtocart(widget.product.product_id.toString(),
                        profile['user_id'].toString());
                    showDialog(
                        context: context,
                        builder: (BuildContext builderContext) {
                          Timer(Duration(seconds: 1), () {
                            Navigator.of(context).pop();
                          });
                          return AlertDialog(
                            title: Text('เพิ่มลงในตะกล้าสำเร็จ',textAlign: TextAlign.center),
                          );
                        });
                  });
                }
              },
              child: Text('ADD TO CART'),
            ),
          ),
        ],
      ),
    );
  }

  // Widget _show() {
  //   showDialog(
  //       context: context,
  //       builder: (BuildContext builderContext) {
  //         Timer(Duration(seconds: 1), () {
  //           Navigator.of(context).pop();
  //         });
  //         return AlertDialog(
  //           title: Text('First Dialog'),
  //         );
  //       });
  // }
}
