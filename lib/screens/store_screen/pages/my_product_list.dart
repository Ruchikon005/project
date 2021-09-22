import 'dart:async';

import 'package:flutter/material.dart';
import 'package:khnomapp/config_ip.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:shared_preferences/shared_preferences.dart';

class MyProduct extends StatefulWidget {
  static var routeName = '/my_product_list';

  const MyProduct({Key key}) : super(key: key);

  @override
  _MyProductState createState() => _MyProductState();
}

class _MyProductState extends State<MyProduct> {
  static var body;
  static SharedPreferences prefs;
  Map<String, dynamic> profile = {
    'user_id': '',
    'username': '',
    'email': '',
    "role": ''
  };

  @override
  void initState() {
    super.initState();
    _getProfile();
    
    onGoBack(dynamic);
  }

  onGoBack(dynamic value) {
    setState(() {});
  }

  void _getProfile() async {
    prefs = await SharedPreferences.getInstance();
    var profileString = prefs.getString('profile');
    print(profileString);
    print('--------------------');
    if (profileString != null) {
      setState(() {
        profile = convert.jsonDecode(profileString);
      });
    }
  }

  // ignore: missing_return
  Future<String> getStoreDetail(String uid) async {
    var url = Uri.parse('${ConfigIp.domain}/stores/ownerfindstore/$uid');
    var response = await http.get(url);
    body = convert.jsonDecode(response.body);
    print(body);
    print('++++++++++');
    // await prefs.setString('ImageDetail', response.body);
    if (response.statusCode == 200) {
      print(body);
      print(body['store_id']);
      String stid = '${body['store_id']}';
      print('>>>>>>>>>>>>>>>>>>>');
      print(stid);
      return stid;
    } else {
      print(response.body);
    }
  }

  Future<String> getStore() async {
    // _getProfile();
    String data = await getStoreDetail('${profile['user_id']}');
    print('${profile['store_id']}');
    print('//////////////////////');
    print(data);
    return data;
  }

  // ignore: missing_return
  Future<String> getproduct() async {
    var data;
    // print(await getStore());
    var request = http.MultipartRequest(
        'GET', Uri.parse('${ConfigIp.domain}/products/productlist/${await getStore()}'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      // print(await response.stream.bytesToString());
      // body = await response.stream.bytesToString();
      data = await response.stream.bytesToString();
      print('data................');
      print(data);
      
    } else {
      print(response.reasonPhrase);
    }return data.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Container(height: 500, color: Colors.white,child: Product(),),
        ],
      ),
    );
  }

   // ignore: non_constant_identifier_names
   FutureBuilder<String> Product() {
    return FutureBuilder<String>(
      future: getproduct(),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        List<Widget> children;
        print(snapshot);
        if (snapshot.hasData) {

          children = <Widget>[
            Text(snapshot.data),
          ];
        } else {
          // print(snapshot.hasData);
          children = const <Widget>[
            
          ];
        }
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: children,
          ),
        );
      },
    );
  }
}
