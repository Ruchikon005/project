import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:khnomapp/config_ip.dart';

Future createstore(String uid, String storename) async {
  print('API');
  print(uid);
  var url = "${ConfigIp.domain}/stores/createstore";
  http.Response response = await http
      .post(Uri.parse(url), body: {'store_name': storename, 'uid': uid});

  var data = jsonDecode(response.body);
    print(data);

  if (data.toString() == "{message: Registration successful}") {
    print(response.body);
  } else {
    print(response.reasonPhrase);
  }
   
}
