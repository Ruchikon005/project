import 'package:flutter/material.dart';
import 'package:khnomapp/model/product_model.dart';
import 'package:khnomapp/screens/product_detail_screen/widget_detail/info_product.dart';
import 'package:khnomapp/screens/product_detail_screen/widget_detail/product_image.dart';

class Body extends StatelessWidget {
  final ProductModel product;

  const Body({
    Key key,
    this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProductImage(product: product),
              SizedBox(height: 20),
              InfoProduct(product: product),
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
