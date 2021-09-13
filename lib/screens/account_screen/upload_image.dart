import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UploadImage extends StatefulWidget {
  static String rountName = '/UploadImage';

  const UploadImage({Key key}) : super(key: key);

  @override
  _UploadImageState createState() => _UploadImageState();
}

class _UploadImageState extends State<UploadImage> {
  File file;
  final ImagePicker _picker = ImagePicker();

  Map<String, dynamic> profile = {
    'username': '',
    'email': '',
    'role': '',
    'tel': ''
  };

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
                ElevatedButton(
                  onPressed: () => chooseImage(ImageSource.gallery),
                  child: CircleAvatar(
                    backgroundImage: file == null
                        ? AssetImage('assets/images/cookie_1.jpg')
                        : Image.file(file),
                    radius: 70,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
