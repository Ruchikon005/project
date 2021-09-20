// import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:khnomapp/config_ip.dart';
import 'package:khnomapp/screens/store_screen/pages/add_product.dart';
import 'package:khnomapp/screens/store_screen/pages/order.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Store extends StatefulWidget {
  static String routeName = '/store';

  Store({Key key}) : super(key: key);

  @override
  _StoreState createState() => _StoreState();
}

int sharedValue = 0;

List<Widget> _widgetOption = <Widget>[
  AddProduct(),
  Order(),
];

class _StoreState extends State<Store> {
  static SharedPreferences prefs;
  static var body;

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
  }

  void _getProfile() async {
    prefs = await SharedPreferences.getInstance();
    var profileString = prefs.getString('profile');
    print(profileString);
    if (profileString != null) {
      setState(() {
        profile = convert.jsonDecode(profileString);
      });
    }
  }

  // ignore: missing_return
  Future<String> getImageDetail(String uid) async {
    var url = Uri.parse('${ConfigIp.domain}/userimages/userimage/$uid');
    var response = await http.get(url);
    body = convert.jsonDecode(response.body);
    // await prefs.setString('ImageDetail', response.body);
    if (response.statusCode == 200) {
      print(body);
      print(body['image_path']);
      uid = body['image_path'];
      print(uid);
      return uid;
    } else {
      print(response.body);
    }
  }

  Future<String> getUse() async {
    String url = await getImageDetail('${profile['user_id']}');
    return url;
  }

  onGoBack(dynamic value) {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final weightbar = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.black,
          ),
          onPressed: () {
            var count = 0;
            Navigator.popUntil(context, (route) {
              return count++ == 2;
            });
          },
        ),
        actions: [],
        title: Text(
          'My Store',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.black),
        ),
      ),
      backgroundColor: Colors.blueGrey,
      body: SingleChildScrollView(
        child: Column(children: [
          Container(
            height: 200,
            color: Colors.white,
            width: double.infinity,
            child: Stack(children: [
              Column(children: [
                SizedBox(height: 40),
                _profileImage(),
                SizedBox(height: 20),
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    'Store name',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ]),
            ]),
          ),
          CupertinoSegmentedControl(
            unselectedColor: Colors.red.withOpacity(0),
            selectedColor: Colors.red.withOpacity(0),
            pressedColor: Colors.red.withOpacity(0),
            borderColor: Colors.red.withOpacity(0),
            children: {
              0: Container(
                alignment: Alignment.center,
                height: 50,
                width: weightbar * 0.8,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(20.0),
                    bottomLeft: const Radius.circular(20.0),
                  ),
                  color: sharedValue == 0 ? Colors.blue[100] : Colors.white,
                ),
                padding: EdgeInsets.all(8),
                child: Text(
                  'Product',
                  style: TextStyle(color: Colors.black, fontSize: 18),
                ),
              ),
              1: Container(
                alignment: Alignment.center,
                height: 50,
                width: weightbar * 0.8,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: const Radius.circular(20.0),
                    bottomRight: const Radius.circular(20.0),
                  ),
                  color: sharedValue == 1 ? Colors.blue[100] : Colors.white,
                ),
                // color: sharedValue == 1 ? Colors.blue[100] : Colors.white,
                padding: EdgeInsets.all(8),
                child: Text(
                  'Oder',
                  style: TextStyle(color: Colors.black, fontSize: 18),
                ),
              )
            },
            onValueChanged: (int val) {
              setState(() {
                sharedValue = val;
              });
            },
            groupValue: sharedValue,
          ),
          Container(
            child: _widgetOption[sharedValue],
          )
        ]),
      ),
    );
  }

  FutureBuilder<String> _profileImage() {
    return FutureBuilder<String>(
      future: getUse(),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        List<Widget> children;
        if (snapshot.hasData) {
          children = <Widget>[
            CircleAvatar(
              backgroundImage:
                  NetworkImage('${ConfigIp.domain}/${snapshot.data}'),
              radius: 45,
            ),
          ];
        } else {
          children = const <Widget>[
            CircleAvatar(
              backgroundColor: Colors.white,
              radius: 45,
            ),
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
