import 'package:http/http.dart' as http;
import 'package:khnomapp/config_ip.dart';
import 'dart:convert' as convert;

class MyStore {
  getMyStore() async {
    var request = http.MultipartRequest('GET', Uri.parse('${ConfigIp.domain}/stores/ownerfindstore/6'));


http.StreamedResponse response = await request.send();

if (response.statusCode == 200) {
  print(await response.stream.bytesToString());
}
else {
  print(response.reasonPhrase);
}
  }
}