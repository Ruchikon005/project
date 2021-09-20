import 'package:flutter/material.dart';
import 'package:khnomapp/screens/account_screen/personal_info_page.dart';
import 'package:khnomapp/screens/signin_screen/signin.dart';
import 'package:khnomapp/screens/store_screen/create_store.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert' as convert;

class MenuAccount extends StatefulWidget {
  const MenuAccount({
    Key key,
  }) : super(key: key);

  @override
  _MenuAccountState createState() => _MenuAccountState();
}

class _MenuAccountState extends State<MenuAccount> {

  static SharedPreferences prefs;

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

  void _logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    await prefs.remove('profile');

    //open login
    // Navigator.pushNamedAndRemoveUntil(
    //     context, '/login', (Route<dynamic> route) => false);
    Navigator.of(context, rootNavigator: true)
        .pushNamedAndRemoveUntil(SignIn.routeName, (route) => false);

  }
  

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        child: Column(
          children: <Widget>[
           ListTile(
             title: Text('Create Store'),
             leading: Icon(Icons.list_alt_rounded),
             onTap: () => {
               print('${profile['user_id']}'),
               normalDialog(context,'${profile['user_id']}')},
            //  Navigator.pushNamed(context, CreateStore.rountName),
           ),
           ListTile(
             title: Text('profile'),
             leading: Icon(Icons.list_alt_rounded),
             onTap: () => Navigator.pushNamed(context, PersonalInfo.routeName),
           ),
           ListTile(
             title: Text('history'),
             leading: Icon(Icons.list_alt_rounded),
           ),
           ListTile(
             title: Text('notification'),
             leading: Icon(Icons.notifications_rounded),
           ),
          
           ListTile(
             title: Text('setting'),
             leading: Icon(Icons.settings),
           ),
           ListTile(
             title: Text('Help'),
             leading: Icon(Icons.help_outline),
           ),
           ListTile(
             title: Text('signout'),
             leading: Icon(Icons.logout),
             onTap: () => _logout(),
           ),
           
          ],
        ),
      ),
    );
  }
}
