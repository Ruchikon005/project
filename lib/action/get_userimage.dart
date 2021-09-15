import 'package:http/http.dart' as http;
import 'package:khnomapp/config_ip.dart';
import 'dart:convert' as convert;

getImage(uid) async {
    String path;
    var url = Uri.parse(
        '${ConfigIp.domain}/userimages/userimage/${uid}');
    var response = await http.get(url);
    var body = convert.jsonDecode(response.body);
    
    if (response.statusCode == 200) {
      print(body);
      print(body['image_path']);
      setpath(path, body);
      
    } else {
      print(response.body);
    }
  }

String setpath(String path, body) => path = '${body['image_path']}';


