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
    // getImageDetail(path);

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

  // ignore: missing_return
  Future<String> getImageDetail(String uid) async {
    var url = Uri.parse('${ConfigIp.domain}/userimages/userimage/$uid');
    var response = await http.get(url);
    body = convert.jsonDecode(response.body);
    // await prefs.setString('ImageDetail', response.body);
    if (response.statusCode == 200) {
      print(body);
      print(body['image_path']);
      uid = body['image_path'];
      print(uid);
      return uid;
    } else {
      print(response.body);
    }
  }

  Future<String> getUse() async {
    String url = await getImageDetail('${profile['user_id']}');
    return url;
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
                      _profileImage(),
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
                                // getImageDetail(),
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

  FutureBuilder<String> _profileImage() {
    return FutureBuilder<String>(
      future: getUse(),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        List<Widget> children;
        if (snapshot.hasData) {
          children = <Widget>[
            CircleAvatar(
              backgroundImage:
                  NetworkImage('${ConfigIp.domain}/${snapshot.data}'),
              radius: 40,
            ),
          ];
        } else {
          children = const <Widget>[
            CircleAvatar(
              backgroundColor: Colors.white,
              radius: 40,
            ),
          ];
        }
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: children,
          ),
        );
      },
    );
  }
}
