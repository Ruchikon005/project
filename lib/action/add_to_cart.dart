import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:khnomapp/config_ip.dart';

Future addtocart(String item_id, String uid) async {
  print('API');
  // print(uid);
  var url = "${ConfigIp.domain}/cart/addCart";
  http.Response response = await http.post(Uri.parse(url), body: {
    'item_id': item_id,
    'uid': uid
  });

  var data = jsonDecode(response.body);
  print(data);

  if (data.toString() == "{message: post successful}") {
    print(response.body);
    return response.body;
  } else {
    print(response.reasonPhrase);
  }
}

Future updateCart(String item_id, String uid) async {
  var url = "${ConfigIp.domain}/cart/update/$uid";
  http.Response response = await http.put(Uri.parse(url), body: {
    'item_id': item_id,
  });

  var data = jsonDecode(response.body);
  print(data);

  if (data.toString() == "{message: Update successful}") {
    print(response.body);
  } else {
    print(response.reasonPhrase);
  }
}
