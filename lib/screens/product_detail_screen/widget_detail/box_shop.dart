import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart';
import 'package:khnomapp/config_ip.dart';
import 'package:khnomapp/model/myproduct_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class BoxShop extends StatelessWidget {
  const BoxShop({
    Key key,
    this.product,
    // this.product,
  }) : super(key: key);
  final Myproduct product;

  Future<Map> getstore() async {
    var url = Uri.parse('${ConfigIp.domain}/stores/${product.stid}');
    final response = await http.get(url);
    // print(response.body);
    Map body = convert.jsonDecode(response.body);
    // print(body['store_name']);
    return body;
  }

  Future<String> getimgstore() async {
    Map data = await getstore();
    // print(data['uid']);
    var url =
        Uri.parse('${ConfigIp.domain}/userimages/userimage/${data['uid']}');
    final response = await http.get(url);
    var body = convert.jsonDecode(response.body);
    print(body['image_path']);
    return body['image_path'];
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        height: 80,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _imgshop(),
            SizedBox(
              width: 15,
            ),
            _showshop(),
            Spacer(),
            Container(
              alignment: Alignment.center,
              height: 30,
              width: 80,
              decoration: BoxDecoration(
                border: Border.all(
                  width: 2,
                  color: Colors.amber.shade200,
                ),
                borderRadius: BorderRadius.circular(10)
              ),
              child: Text('ดูร้านค้า'),
            )
          ],
        ),
      ),
    );
  }

  FutureBuilder<String> _imgshop() {
    return FutureBuilder<String>(
      future: getimgstore(),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        List<Widget> children;
        if (snapshot.hasData) {
          children = <Widget>[
            // Text('${snapshot.data}'),
            CircleAvatar(
              backgroundImage:
                  NetworkImage('${ConfigIp.domain}/${snapshot.data}'),
              radius: 30,
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

  FutureBuilder<Map> _showshop() {
    return FutureBuilder<Map>(
      future: getstore(),
      builder: (BuildContext context, AsyncSnapshot<Map> snapshot) {
        List<Widget> children;
        if (snapshot.hasData) {
          children = <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${snapshot.data['store_name']}',
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(height: 5),
                Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      size: 20,
                      color: Colors.black54,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      'จังหวัดภูเก็ต',
                      style: TextStyle(color: Colors.black54),
                    ),
                  ],
                )
              ],
            ),
          ];
        } else {}
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: children,
          ),
        );
      },
    );
  }
}
