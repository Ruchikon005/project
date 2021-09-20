import 'package:flutter/material.dart';

class Order extends StatefulWidget {
  static var routeName = '/order';

  Order({Key key}) : super(key: key);

  @override
  _OrderState createState() => _OrderState();
}

class _OrderState extends State<Order> {
  @override
  Widget build(BuildContext context) {
    return Center(child: Container(child: Text('order page')));
  }
}