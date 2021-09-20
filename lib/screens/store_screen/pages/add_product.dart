import 'package:flutter/material.dart';

class AddProduct extends StatefulWidget {
  static var routeName = '/add_product';

  AddProduct({Key key}) : super(key: key);

  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  @override
  Widget build(BuildContext context) {
    return Container(height: 500,color: Colors.white);
  }
}