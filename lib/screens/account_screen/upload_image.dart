import 'dart:io';
import 'dart:convert' as convert;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:khnomapp/action/imageupload.dart';
import 'package:khnomapp/config_ip.dart';
import 'package:khnomapp/nav/nav.dart';
import 'package:khnomapp/screens/account_screen/Account.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UploadImage extends StatefulWidget {
  static String routeName = '/UploadImage';

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

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  _imgFromCamera() async {
    XFile image = await _picker.pickImage(
      source: ImageSource.camera,
      maxWidth: 800.0,
      maxHeight: 800.0,
    );

    setState(() {
      file = File(image.path);
    });
  }

  _imgFromGallery() async {
    XFile image = await _picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 800.0,
      maxHeight: 800.0,
    );

    setState(() {
      file = File(image.path);
    });
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
                  onTap: () => _showPicker(context),
                  child: file == null
                      ? CircleAvatar(
                        backgroundColor: Colors.grey.shade300,
                          child: Icon(Icons.add_a_photo_outlined,color: Colors.white,size: 50,),
                          radius: 70,
                        )
                      : CircleAvatar(
                          backgroundImage: FileImage(file), radius: 70),
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
                      // Navigator.popUntil(
                      //     context, ModalRoute.withName(Account.routeName));
                      Navigator.pop(context, true);
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
