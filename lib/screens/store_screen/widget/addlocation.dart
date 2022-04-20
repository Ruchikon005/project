import 'package:flutter/material.dart';


Future<Null> _addlocation(BuildContext context) async {
 
  showDialog(
      context: context,
      builder: (context) => Center(
            child: SimpleDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              children: [
                Container(
                  
                ),
              ],
            ),
          ));
}
