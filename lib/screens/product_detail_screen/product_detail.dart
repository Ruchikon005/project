import 'package:flutter/material.dart';
import 'package:khnomapp/model/myproduct_model.dart';
import 'package:khnomapp/model/product_model.dart';
import 'package:khnomapp/model/productfood_model.dart';
import 'package:khnomapp/screens/product_detail_screen/widget_detail/body.dart';

class ProductDetail extends StatelessWidget {
  static var routeName = "/product_detail_screen";

  @override
  Widget build(BuildContext context) {
    final product = ModalRoute.of(context).settings.arguments as Myproduct;
    return Scaffold(
      // appBar: AppBar(title:Text(product.product_name))
      appBar: CustomAppBar(context),
      
      body: Body(product: product,),
    );
  }

  AppBar CustomAppBar(BuildContext context) {
    return AppBar(
      // title: Text(),
      backgroundColor: Colors.white,
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: Icon(Icons.arrow_back_ios_new_rounded),
        color: Colors.black,
      ),
    );
  }
}

