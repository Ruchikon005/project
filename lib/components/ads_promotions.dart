import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdsPromotions extends StatelessWidget {
  const AdsPromotions({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: double.infinity,
        height: 100,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(20),
          
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: RichText(
            
            text: TextSpan(
              text: 'sale\n' ,
              style: TextStyle(fontSize: 15, color: Colors.white),
              children: const <TextSpan> [
                TextSpan(
                  text: '50% OFF' ,
                  style: TextStyle(fontSize: 30, color: Colors.white)
                )
              ]
            ),
          ),
        ),
      ),
    );
  }
}