import 'package:http/http.dart' as http;
import 'package:khnomapp/config_ip.dart';
import 'dart:convert';

Future getlocationname(var location_name) async {
  var url ='${ConfigIp.domain}/location/findbylocationname/$location_name';

  http.Response response = await http.get(Uri.parse(url));
  var data = jsonDecode(response.body);
  if (response.statusCode == 200) {
    print(response.body);
    return data;
  } else {
    print(response.reasonPhrase);
  }
}