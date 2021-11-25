import 'package:flutter/material.dart';
import 'package:khnomapp/config_ip.dart';
import 'package:khnomapp/model/myproduct_model.dart';

import 'package:khnomapp/screens/store_screen/pages/my_product_list.dart';

class ProductImage extends StatelessWidget {
  
  const ProductImage({
    Key key, this.product,
    // this.product,
  }) : super(key: key);
  final Myproduct product;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 3 / 2,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.greenAccent,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10)),
          image: DecorationImage(
            image: NetworkImage('${ConfigIp.domain}/${product.image_path}'),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
