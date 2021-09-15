import 'package:http/http.dart' as http;
import 'package:khnomapp/config_ip.dart';

Future create(uid, storename) async {
  var request = http.MultipartRequest(
      'POST', Uri.parse('${ConfigIp.domain}/stores/createstore'));
  request.fields.addAll({'uid': '2', 'store_name': storename});

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    print(await response.stream.bytesToString());
    // Navigator.pushAndRemoveUntil(context,Store.routeName, (route) => false);
  } else {
    print(response.reasonPhrase);
  }
}
