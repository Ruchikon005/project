import 'package:flutter/material.dart';
import 'package:khnomapp/model/product_model.dart';
import 'package:khnomapp/screens/product_detail_screen/widget_detail/body.dart';

class ProductDetail extends StatelessWidget {
  static var routeName = "/product_detail_screen";

  @override
  Widget build(BuildContext context) {
    final ProductDetailArguments arguments = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: CustomAppBar(context),
      body: Body(product: arguments.product,),
    );
  }


  AppBar CustomAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: Icon(Icons.arrow_back_ios_new_rounded),
        color: Colors.black,
      ),
    );
  }
}

class ProductDetailArguments {
  final ProductModel product;

  ProductDetailArguments({@required this.product});
}
