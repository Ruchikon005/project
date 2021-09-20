import 'package:flutter/material.dart';

class Store extends StatefulWidget {
  static String routeName = '/store';


  Store({Key key}) : super(key: key);

  @override
  _StoreState createState() => _StoreState();
}

class _StoreState extends State<Store> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: Column(
         children: [
           Text('Store name')
         ],
       ),
    );
  }
}