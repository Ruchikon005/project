import 'package:http/http.dart' as http;
import 'package:khnomapp/config_ip.dart';
import 'dart:convert' as convert;

getMycart(String uid) async {
  var request = http.MultipartRequest(
      'GET', Uri.parse('${ConfigIp.domain}/cart/mycart/$uid'));

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    print(await response.stream.bytesToString());
  } else {
    print(response.reasonPhrase);
  }
}
