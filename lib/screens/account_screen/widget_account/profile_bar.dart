import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:khnomapp/action/get_userimage.dart';
import 'package:khnomapp/config_ip.dart';
import 'package:khnomapp/screens/account_screen/upload_image.dart';
import 'package:khnomapp/utility/my_style.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class ProfileBar extends StatefulWidget {
  const ProfileBar({
    Key key,
  }) : super(key: key);

  @override
  _ProfileBarState createState() => _ProfileBarState();
}

class _ProfileBarState extends State<ProfileBar> {
  static SharedPreferences prefs;
  static String path;
  static var body;

  Map<String, dynamic> profile = {
    'user_id': '',
    'username': '',
    'email': '',
    "role": ''
  };

  Map<String, dynamic> image = {
    'userimage_id': '',
    'type': '',
    'image_path': '',
    'data': '',
  };

  @override
  void initState() {
    super.initState();
      _getProfile();
      getImageDetail();

    // _getImageprofile();
  }

  void _getProfile() async {
    prefs = await SharedPreferences.getInstance();
    var profileString = prefs.getString('profile');
    print(profileString);
    if (profileString != null) {
      setState(() {
        profile = convert.jsonDecode(profileString);
      });
    }
  }

 void getImageDetail() async {
    var url = Uri.parse(
        '${ConfigIp.domain}/userimages/userimage/${profile['user_id']}');
    var response = await http.get(url);
    body = convert.jsonDecode(response.body);
    // await prefs.setString('ImageDetail', response.body);
    if (response.statusCode == 200) {
      print(body);
      print(body['image_path']);
      setState(() {
        path = '${body['image_path']}';
        
      });
    } else {
      print(response.body);
    }
  }

  // _getImageprofile() async {
  //   var imageString = prefs.getString('ImageDetail');
  //   print(imageString);
  //   if (imageString != null) {
  //     setState(() {
  //       image = convert.jsonDecode(imageString);
  //       print('object');
  //       print(image['image_part']);
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250.0,
      child: Stack(
        children: <Widget>[
          Container(
            color: MyStyle().colorCustom,
            height: 250,
            width: double.infinity,
          ),
          SizedBox(height: 10.0),
          Align(
            alignment: Alignment(0, 0.7),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundImage:
                            NetworkImage('${ConfigIp.domain}/${path}'),
                        radius: 40,
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${profile['username']}',
                            style:
                                TextStyle(color: Colors.white, fontSize: 20.0),
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          Text(
                            '${profile['email']}',
                            style: TextStyle(color: Colors.white),
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          Container(
                            height: 20,
                            child: ElevatedButton(
                              style: OutlinedButton.styleFrom(
                                side: BorderSide(width: 1, color: Colors.blue),
                              ),
                              onPressed: () => Navigator.pushNamed(
                                  context, UploadImage.rountName),
                              child: Text(
                                'Edit',
                                style: TextStyle(
                                    fontSize: 12.0, color: Colors.blue),
                              ),
                            ),
                          ),
                          Container(
                            height: 20,
                            child: ElevatedButton(
                              style: OutlinedButton.styleFrom(
                                side: BorderSide(width: 1, color: Colors.blue),
                              ),
                              onPressed: () => {
                                getImageDetail(),
                                // print(body),
                                // getImage(body)
                              },
                              child: Text(
                                'Edit2',
                                style: TextStyle(
                                    fontSize: 12.0, color: Colors.blue),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
