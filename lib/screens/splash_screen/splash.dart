import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:khnomapp/nav/nav.dart';
import 'package:khnomapp/screens/payment_screen/payment.dart';
import 'package:khnomapp/screens/signin_screen/signin.dart';
import 'package:khnomapp/utility/my_style.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashPage extends StatefulWidget {
  static String routeName = "/splash";

  const SplashPage({Key key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  static SharedPreferences prefs;


  @override
void initState() {
  super.initState();
  startTimer();
}

startTimer() async {
  var duration = Duration(seconds: 5);
  return new Timer(duration, route);
}

route() async {
  prefs = await SharedPreferences.getInstance();
    if (prefs.getString('token') != null) {
      Navigator.pushReplacementNamed(context, Nav.routeName);
    }
    else{
      Navigator.pushReplacementNamed(context, SignIn.routeName);
      // Navigator.pushReplacementNamed(context, PaymentScreen.routeName);
    }
  
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyStyle().colorCustom,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MyStyle().showLogoSplash(),
          ],
        ),
      ),
    );
  }
}
