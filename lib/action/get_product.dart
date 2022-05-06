import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:khnomapp/config_ip.dart';
import 'package:khnomapp/model/productfood_model.dart';

Future getProduct(product_id) async {
  var url = "${ConfigIp.domain}/products/product/$product_id";
  http.Response response = await http.get(Uri.parse(url));
  var data = jsonDecode(response.body);
  FoodModel product = FoodModel();

  if (response.statusCode == 200) {
    product = FoodModel.fromJson(data);
    print(product.product_id);
    return product;
  } else {
    print(response.reasonPhrase);
  }
}

Future updateQuantity(int quantity, int product_id) async {
  var url = "${ConfigIp.domain}/products/updatequantity/$product_id";
  http.Response response = await http.put(Uri.parse(url), body: {
    'quantity': quantity.toString(),
  });

  var data = jsonDecode(response.body);
  print(data);

  if (response.statusCode == 200) {
    print(response.body);
  } else {
    print(response.reasonPhrase);
  }
}
