import 'package:flutter/material.dart';
import 'package:khnomapp/nav/nav.dart';
import 'package:khnomapp/screens/account_screen/Account.dart';
import 'package:khnomapp/screens/account_screen/personal_info_page.dart';
import 'package:khnomapp/screens/account_screen/upload_image.dart';
import 'package:khnomapp/screens/category_allscreen/page/cate1.dart';
import 'package:khnomapp/screens/category_allscreen/page/cate2.dart';
import 'package:khnomapp/screens/category_allscreen/page/cate3.dart';
import 'package:khnomapp/screens/category_allscreen/page/cate4.dart';
import 'package:khnomapp/screens/category_allscreen/page/cate5.dart';
import 'package:khnomapp/screens/category_allscreen/page/cate6.dart';
import 'package:khnomapp/screens/home_screen/home.dart';
import 'package:khnomapp/screens/product_detail_screen/product_detail.dart';
import 'package:khnomapp/screens/signin_screen/signin.dart';
import 'package:khnomapp/screens/signup_screen/signup.dart';
import 'package:khnomapp/screens/store_screen/pages/add_product.dart';
import 'package:khnomapp/screens/store_screen/pages/my_product_list.dart';
import 'package:khnomapp/screens/store_screen/pages/order.dart';
import 'package:khnomapp/screens/store_screen/store.dart';
import 'package:khnomapp/screens/store_screen/widget/nav_store.dart';

final Map<String, WidgetBuilder> routes = {
  Nav.routeName: (context) => Nav(),
  NavStore.routeName: (context) => NavStore(),
  Home.routeName: (context) => Home(),
  ProductDetail.routeName: (context) => ProductDetail(),
  SignIn.routeName: (context) => SignIn(),
  SignUp.routeName: (context) => SignUp(),
  Account.routeName: (context) => Account(),
  PersonalInfo.routeName: (context) => PersonalInfo(),
  UploadImage.routeName: (context) => UploadImage(),
  Store.routeName: (context) => Store(),
  AddProduct.routeName: (context) => AddProduct(),
  Order.routeName: (context) => Order(),
  MyProduct.routeName: (context) => MyProduct(),
  Cate1.routeName: (context) => Cate1(),
  Cate2.routeName: (context) => Cate2(),
  Cate3.routeName: (context) => Cate3(),
  Cate4.routeName: (context) => Cate4(),
  Cate5.routeName: (context) => Cate5(),
  Cate6.routeName: (context) => Cate6(),
};