import 'dart:io';
import 'dart:convert' as convert;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:khnomapp/action/imageupload.dart';
import 'package:khnomapp/config_ip.dart';
import 'package:khnomapp/screens/account_screen/Account.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UploadImage extends StatefulWidget {
  static String rountName = '/UploadImage';

  const UploadImage({Key key}) : super(key: key);

  @override
  _UploadImageState createState() => _UploadImageState();
}

class _UploadImageState extends State<UploadImage> {
  static SharedPreferences prefs;
  File file;
  final ImagePicker _picker = ImagePicker();
  Map<String, dynamic> profile = {
    'user_id': '',
    'username': '',
    'email': '',
    "role": ''
  };

  @override
  void initState() {
    super.initState();
    _getProfile();
  }

  Future _getProfile() async {
    prefs = await SharedPreferences.getInstance();
    var profileString = prefs.getString('profile');
    print(profileString);
    if (profileString != null) {
      setState(() {
        profile = convert.jsonDecode(profileString);
      });
    }
  }

  Future<Null> chooseImage(ImageSource source) async {
    try {
      final XFile image = await _picker.pickImage(
        source: source,
        maxWidth: 800.0,
        maxHeight: 800.0,
      );
      setState(() {
        file = File(image.path);
      });
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_outlined,
            color: Colors.black,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: Column(
        children: [
          Center(
            child: Column(
              children: [
                InkWell(
                  onTap: () => chooseImage(ImageSource.gallery),
                  child: CircleAvatar(
                    backgroundImage: file == null
                        ? AssetImage('assets/images/cookie_1.jpg')
                        : FileImage(file),
                    radius: 70,
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                ElevatedButton(
                    onPressed: () async {
                      print(file.path);
                      // print(tokenString);
                      print(file);
                      var res = await ImageUpload.upload(
                          file.path, '${profile['user_id']}');
                      Navigator.popAndPushNamed(context, Account.routeName);
                    },
                    child: Text('save')),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
