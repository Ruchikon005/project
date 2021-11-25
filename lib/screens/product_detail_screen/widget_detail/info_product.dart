import 'package:flutter/material.dart';
import 'package:khnomapp/model/myproduct_model.dart';
import 'package:khnomapp/model/product_model.dart';

class InfoProduct extends StatelessWidget {
  const InfoProduct({
    Key key,
    this.product,
    // this.product,
  }) : super(key: key);
  final Myproduct product;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      width: double.infinity,
      height: 200,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${product.product_name}',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20),
          Text(
            '฿${product.price}',
            style: TextStyle(
                color: Colors.deepOrange,
                fontSize: 20,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          Text(
            'รายละเอียด',
            style: TextStyle(
              color: Colors.black87,
              fontSize: 15,
            ),
          ),
          SizedBox(height: 10),
          Text(
            '${product.product_detail}',
            style: TextStyle(
              color: Colors.black87,
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }
}
