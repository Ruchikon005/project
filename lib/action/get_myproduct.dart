import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:khnomapp/config_ip.dart';
import 'dart:convert' as convert;

class getMyProductStore {
  myproduct(String stid) async {
    var request = http.MultipartRequest(
        'GET', Uri.parse('${ConfigIp.domain}/products/productlist/$stid'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }
}

Future getProductByid(var product_id) async {
  var url ='${ConfigIp.domain}/products/product/$product_id';

  http.Response response = await http.get(Uri.parse(url));
  var data = jsonDecode(response.body);
  if (response.statusCode == 200) {
    print(response.body);
    return data;
  } else {
    print(response.reasonPhrase);
  }
}

