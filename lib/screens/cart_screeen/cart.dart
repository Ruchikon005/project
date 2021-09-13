import 'package:flutter/material.dart';

class CartScreen extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    final weightScreen =  MediaQuery.of(context).size.width;
    final heightScreen =  MediaQuery.of(context).size.height;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(),
            Row(
              children: [
                Container(
                  width: weightScreen * 0.5,
                  height: heightScreen * 0.5,
                  color: Colors.black,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: weightScreen * 0.5,
                  height: heightScreen * 0.5,
                  color: Colors.black,
                ),
              ],
            ),
      
          ],
        ),
      ),
    );
  }
}