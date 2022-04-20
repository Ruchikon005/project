import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:khnomapp/config_ip.dart';

Future createlocation(Map loca, String _namelo,String _detaillo) async {
  print('API');
  print(_detaillo);
  // print(uid);
  var url = "${ConfigIp.domain}/location/addlocation";
  http.Response response = await http.post(Uri.parse(url), body: {
    'location_name': _namelo,
    'location_detail': _detaillo,
    'lat': loca['lat'],
    'lng': loca['lng'],
    'stid': loca['stid']
  });

  var data = jsonDecode(response.body);
  print(data);

  if (data.toString() == "{message: post location successful}") {
    print(response.body);
  } else {
    print(response.reasonPhrase);
  }
}
