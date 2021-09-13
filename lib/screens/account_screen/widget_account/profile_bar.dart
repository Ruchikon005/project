
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:khnomapp/screens/account_screen/upload_image.dart';
import 'package:khnomapp/utility/my_style.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert' as convert;

class ProfileBar extends StatefulWidget {
  const ProfileBar({
    Key key,
  }) : super(key: key);

  @override
  _ProfileBarState createState() => _ProfileBarState();
}

class _ProfileBarState extends State<ProfileBar> {

  Map<String, dynamic> profile = {'username': '', 'email': '', "role": ''};
  // Map<String, dynamic> token = {'access_token': ''};

  // _initPref() async {
  //   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //   // int counter = (prefs.getInt('counter') ?? 0) + 1;
  //   // print('Pressed $counter times.');
  //   // await prefs.setInt('counter', counter);
  // }

  @override
  void initState() {
    super.initState();
    // _initPref();
    _getProfile();
    // _getToken();
  }

  _getProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var profileString = prefs.getString('profile');
    print(profileString);
    if (profileString != null) {
      setState(() {
        profile = convert.jsonDecode(profileString);
      });
    }
  }

  // _getToken() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   var tokenString = prefs.getString('token');
  //   print(tokenString);
  //   if (tokenString != null) {
  //     setState(() {
  //       token = convert.jsonDecode(tokenString);
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
                        backgroundImage: AssetImage('assets/images/cookie_1.jpg'),
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
                              onPressed: () => Navigator.pushNamed(context, UploadImage.rountName),
                              child: Text(
                                'Edit',
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
