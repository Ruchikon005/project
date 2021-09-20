import 'package:flutter/material.dart';
import 'package:khnomapp/action/create_sotre.dart';
import 'package:khnomapp/screens/account_screen/Account.dart';
import 'package:khnomapp/screens/store_screen/store.dart';
import 'package:khnomapp/screens/store_screen/widget/nav_store.dart';


Future<Null> normalDialog(BuildContext context, String uid) async {
  TextEditingController _storename = TextEditingController();
  final ButtonStyle style = ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 18), fixedSize: Size(100, 25));
  print("status");
  print(uid);
  String _uid = uid;
  showDialog(
      context: context,
      builder: (context) => Center(
            child: SimpleDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                  height: 250,
                  child: Column(
                    children: [
                      Text(
                        'Create store',
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 30),
                      TextFormField(
                        controller: _storename,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          labelText: 'store Name',
                        ),
                        style: TextStyle(fontSize: 18),
                      ),
                      SizedBox(height: 40),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              style: style,
                              onPressed: () =>
                                  Navigator.pop(context, Account.routeName),
                              child: Text('CANCEL'),
                            ),
                            SizedBox(width: 10),
                            ElevatedButton(
                              style: style,
                              onPressed: () {
                                print("ontap");
                                print(_uid);
                                createstore(_uid, _storename.text);
                                Navigator.pushNamed(context, Store.routeName);
                              },
                              child: Text('Okay'),
                            )
                          ])
                    ],
                  ),
                ),
              ],
            ),
          ));
}
