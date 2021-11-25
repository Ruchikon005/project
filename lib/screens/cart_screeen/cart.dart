import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {
  static var routeName = '/cart';

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final weightScreen = MediaQuery.of(context).size.width;
    final heightScreen = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.white,
        title: Text('My Cart'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Stack(
        children: [
          Container(),
          Positioned(
              bottom: 0,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(top: BorderSide(width: 1.5,color: Colors.black12))),
                height: 70,
                width: weightScreen * 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        'ราคาทั้งหมด',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    // Spacer(),
                    GestureDetector(
                      onTap: () {
                        print('ชำระเงิน');
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 70,
                        width: 150,
                        decoration:
                            BoxDecoration(color: Colors.yellow.shade800),
                        child: Text(
                          'ชำระเงิน',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
