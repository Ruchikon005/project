import 'package:flutter/material.dart';
import 'package:khnomapp/model/product_model.dart';

class ProductImage extends StatelessWidget {
  const ProductImage({
    Key key,
    @required this.product,
  }) : super(key: key);

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 3 / 2,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.greenAccent,
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            image: ExactAssetImage(product.image),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
