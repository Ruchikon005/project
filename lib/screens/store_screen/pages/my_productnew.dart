import 'package:flutter/material.dart';
import 'package:khnomapp/config_ip.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class Product_to extends StatefulWidget {
  const Product_to({ Key key }) : super(key: key);


  @override
  _Product_toState createState() => _Product_toState();
}

class _Product_toState extends State<Product_to> {
  static var body;
  static SharedPreferences prefs;
  Map<String, dynamic> profile = {
    'user_id': '',
    'username': '',
    'email': '',
    "role": ''
  };

  String stid;

  @override
  void initState() {
    super.initState();
    getProfile();
    
  }
  
  @override
  void setState(VoidCallback fn) {
    // ignore: todo
    // TODO: implement setState
    super.setState(fn);
    readApiProduct();
  }

  void getProfile() async {
    prefs = await SharedPreferences.getInstance();
    var profileString = prefs.getString('profile');
    print('--------------------');
    if (profileString != null) {
      setState(() {
        profile = convert.jsonDecode(profileString);
        print(profile['user_id']);
      });
    }
  }


  Future<Null> readApiProduct() async {
    var url = Uri.parse('${ConfigIp.domain}/products/productlist/${profile['user_id']}');
    await http.get(url).then((value) => print('value ===> ${value.body}'));
  }



  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}