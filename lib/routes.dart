import 'package:flutter/material.dart';
import 'package:khnomapp/nav/nav.dart';
import 'package:khnomapp/screens/account_screen/Account.dart';
import 'package:khnomapp/screens/account_screen/personal_info_page.dart';
import 'package:khnomapp/screens/account_screen/upload_image.dart';
import 'package:khnomapp/screens/home_screen/home.dart';
import 'package:khnomapp/screens/product_detail_screen/product_detail.dart';
import 'package:khnomapp/screens/signin_screen/signin.dart';
import 'package:khnomapp/screens/signup_screen/signup.dart';
import 'package:khnomapp/screens/store_screen/create_store.dart';
import 'package:khnomapp/screens/store_screen/store.dart';

final Map<String, WidgetBuilder> routes = {
  Nav.routeName: (context) => Nav(),
  Home.routeName: (context) => Home(),
  ProductDetail.routeName: (context) => ProductDetail(),
  SignIn.routeName: (context) => SignIn(),
  SignUp.routeName: (context) => SignUp(),
  Account.routeName: (context) => Account(),
  PersonalInfo.rountName: (context) => PersonalInfo(),
  UploadImage.rountName: (context) => UploadImage(),
  CreateStore.rountName: (context) => CreateStore(),
  Store.rounte: (context) => Store(),
};