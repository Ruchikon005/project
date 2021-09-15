import 'package:flutter/material.dart';
import 'package:khnomapp/screens/home_screen/widget_home/banner_slider.dart';
import 'package:khnomapp/screens/home_screen/widget_home/main_manu.dart';
import 'package:khnomapp/screens/home_screen/widget_home/product_list.dart';


import 'widget_home/header.dart';

class Home extends StatefulWidget {
  static String routeName = "/home_screen";

  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final _scrollController = TrackingScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12,
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                BannerSlider(),
                MainManu(),
                ProductLoadMore(),
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
}
