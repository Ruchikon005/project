import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:khnomapp/config_ip.dart';
import 'dart:convert' as convert;

class NetworkUse {
  getImage(String uid) async {
    String path;
    var url = Uri.parse('${ConfigIp.domain}/userimages/userimage/${uid}');
    var response = await http.get(url);
    var body = convert.jsonDecode(response.body);

    if (response.statusCode == 200) {
      print(body);
      print(body['image_path']);
      path = body['image_part'];
    } else {
      print(response.body);
    }

    return getImage(path);
  }
}
