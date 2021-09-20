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

  onGoBack(dynamic value) {
    setState(() {});
  }

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
                      Stack(
                        children: [
                          _profileImage(),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              height: 28,
                              width: 28,
                              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20) ),
                              child: IconButton(
                                padding: EdgeInsets.all(0),
                                icon: Icon(
                                  Icons.mode_edit_outlined,
                                  color: Colors.grey,
                                ),
                                onPressed: () => Navigator.pushNamed(
                                        context, UploadImage.routeName)
                                    .then(onGoBack),
                              ),
                            ),
                          ),
                        ],
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
              radius: 45,
            ),
          ];
        } else {
          children = const <Widget>[
            CircleAvatar(
              backgroundColor: Colors.white,
              radius: 45,
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
