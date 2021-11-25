import 'package:flutter/material.dart';
import 'package:khnomapp/model/myproduct_model.dart';
import 'package:khnomapp/screens/product_detail_screen/widget_detail/box_shop.dart';
// import 'package:khnomapp/model/product_model.dart';
import 'package:khnomapp/screens/product_detail_screen/widget_detail/info_product.dart';
import 'package:khnomapp/screens/product_detail_screen/widget_detail/product_image.dart';
import 'package:khnomapp/screens/store_screen/pages/my_product_list.dart';

class Body extends StatelessWidget {

  const Body({
    Key key, this.product,
    // this.product,
  }) : super(key: key);
  final Myproduct product;

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
              ProductImage(product: product),
              InfoProduct(product: product),
              SizedBox(height: 10),
              BoxShop(product: product),
              
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
              onPressed: () {},
              child: Text('ADD TO CART'),
            ),
          ),
        ],
      ),
    );
  }
}
