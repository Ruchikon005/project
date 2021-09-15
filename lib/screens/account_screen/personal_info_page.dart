import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert' as convert;

class PersonalInfo extends StatefulWidget {
  static String rountName = '/PersonalInfo';

  const PersonalInfo({Key key}) : super(key: key);

  @override
  _PersonalInfoState createState() => _PersonalInfoState();
}

class _PersonalInfoState extends State<PersonalInfo> {
  Map<String, dynamic> profile = {
    'username': '',
    'email': '',
    'role': '',
    'tel': ''
  };
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
    _getProfile();
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

  @override
  Widget build(BuildContext context) {
    final weightScreen = MediaQuery.of(context).size.width;

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
          Stack(
            children: [
              CircleAvatar(
                backgroundImage: AssetImage('assets/images/cookie_1.jpg'),
              ),
              Center(
                child: Column(
                  children: [
                    Card(
                      child: Container(
                        padding: EdgeInsets.all(20),
                        height: 500,
                        width: weightScreen * 0.9,
                        child: Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Username : ${profile['username']}',
                                style: TextStyle(fontSize: 18),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Email : ${profile['email']}',
                                style: TextStyle(fontSize: 18),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Tel : ${profile['tel']}',
                                style: TextStyle(fontSize: 18),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Role : ${profile['role']}',
                                style: TextStyle(fontSize: 18),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
