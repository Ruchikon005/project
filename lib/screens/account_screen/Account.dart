import 'package:flutter/material.dart';
import 'package:khnomapp/screens/account_screen/widget_account/manu_account.dart';
import 'package:khnomapp/screens/account_screen/widget_account/profile_bar.dart';

class Account extends StatefulWidget {
  static var routeName = '/Account';

  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProfileBar(),
         MenuAccount(),
        ],
      ),
    );
  }
}


