// import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
// import 'package:khnomapp/nav/nav.dart';
import 'package:khnomapp/screens/home_screen/widget_home/banner_slider.dart';
import 'package:khnomapp/screens/home_screen/widget_home/main_manu.dart';
import 'package:khnomapp/screens/home_screen/widget_home/product_list.dart';

// import 'package:khnomapp/screens/signup_screen/signup.dart';
// import 'package:khnomapp/utility/my_style.dart';
// import 'package:khnomapp/widgets/search_homepage.dart';

import 'widget_home/header.dart';

class Home extends StatefulWidget {
  static String routeName = "/home_screen";

  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // TextEditingController _textEditingController = TextEditingController();

  final _scrollController = TrackingScrollController();
  // Offset _position;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12,
      // appBar: AppBar(
      //   title: search_bar(textEditingController: _textEditingController),
      //   actions: [
      //     IconButton(
      //       onPressed: () {},
      //       icon: Icon(Icons.shopping_cart_outlined),
      //     ),
      //     IconButton(
      //       onPressed: () {},
      //       icon: Icon(Icons.notifications_outlined),
      //     ),
      //   ],
      // ),

      body: Stack(
        children: [
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                BannerSlider(),
                MainManu(),
                ProductLoadMore(),
                // Container(
                //   color: MyStyle().colorCustom,
                //   child: Text('xxx'),
                //   height: 1500,
                //   width: double.infinity,
                // ),
                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: Container(
                //     width: 160,
                //     height: 200,
                //     decoration: BoxDecoration(
                //       color: Colors.white,
                //       borderRadius: BorderRadius.circular(5),
                //     ),
                //     child: Column(
                //       children: [
                //         Image.asset('assets/images/candy.jpg'),
                //       ],
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
          Header(_scrollController),
          Column(
            children: [],
          ),
        ],
      ),
      // bottomNavigationBar:Nav(),
      //  BodyHome(),
      // body: searchFoods(),
      // drawer: showDrawer(),
      // bottomNavigationBar: Nav(),
    );
  }

  // Drawer showDrawer() => Drawer(
  //       child: ListView(
  //         children: <Widget>[
  //           showHeadDrawer(),
  //           signInMenu(),
  //           signUpMenu(),
  //         ],
  //       ),
  //     );

  // ListTile signInMenu() {
  //   return ListTile(
  //     leading: Icon(Icons.android),
  //     title: Text('Sign In'),
  //     onTap: () {
  //       Navigator.pop(context);
  //       MaterialPageRoute route =
  //           MaterialPageRoute(builder: (value) => SignIn());
  //       Navigator.push(context, route);
  //     },
  //   );
  // }

  // ListTile signUpMenu() {
  //   return ListTile(
  //     leading: Icon(Icons.android),
  //     title: Text('Sign Up'),
  //     onTap: () {
  //       Navigator.pop(context);
  //       MaterialPageRoute route =
  //           MaterialPageRoute(builder: (value) => SignUp());
  //       Navigator.push(context, route);
  //     },
  //   );
  // }

  // UserAccountsDrawerHeader showHeadDrawer() {
  //   return UserAccountsDrawerHeader(
  //       accountName: Text('Guest'), accountEmail: Text('Please Login'));
  // }
}
