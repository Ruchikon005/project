import 'package:http/http.dart' as http;
import 'package:khnomapp/config_ip.dart';

class ImageUpload {
  static String a;
  static upload(String path, uid) async {
    var request = http.MultipartRequest(
        'POST', Uri.parse('${ConfigIp.domain}/userimages/uploadimage'));
    request.fields.addAll({'uid': uid});
    request.files.add(await http.MultipartFile.fromPath('uploadfile', path));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }
}

// ImageUpload().upload()
// ImageUpload().a
// ImageUpload.a
// ImageUpload.upload()