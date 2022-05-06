import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:khnomapp/config_ip.dart';
import 'package:khnomapp/model/cart_model.dart';

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

  if (response.statusCode == 200) {
    print(response.body);
  } else {
    print(response.reasonPhrase);
  }
}

Future deleteCart(cart_id) async {
  var url = "${ConfigIp.domain}/cart/delete/$cart_id";
  http.Response response = await http.delete(Uri.parse(url));
  var data = jsonDecode(response.body);
  print(data);

  if (response.statusCode == 200) {
    print(response.body);
  } else {
    print(response.reasonPhrase);
  }
}

Future getCartid(uid) async {
  Cart cartModel = Cart();
  var url = "${ConfigIp.domain}/cart/getcart/$uid";
  http.Response response = await http.get(Uri.parse(url));
  var data = jsonDecode(response.body);
  print(data);
  if (response.statusCode == 200) {
    cartModel = Cart.fromJson(data);
    return cartModel;
  } else {
    print(response.reasonPhrase);
  }
}

