import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:khnomapp/config_ip.dart';
import 'dart:convert' as convert;
import 'package:khnomapp/model/qr_model.dart';

Future generatePrompt(int uid, String amount ) async {
  var url = "${ConfigIp.domain}/generateQr/Qr/$uid";
  http.Response response = await http.post(Uri.parse(url), body: {
    'amount': amount,
  });
  Qr qrcodes = Qr();
  var data = jsonDecode(response.body);
  if (response.statusCode == 200) {
    print(data);
    return data;
  } else {
    print(response.reasonPhrase);
  }
}