import 'package:flutter/material.dart';
import 'package:khnomapp/config_ip.dart';
import 'package:khnomapp/model/openstore_model.dart';
import 'package:khnomapp/screens/account_screen/personal_info_page.dart';
import 'package:khnomapp/screens/signin_screen/signin.dart';
import 'package:khnomapp/screens/store_screen/create_store.dart';
import 'package:khnomapp/screens/store_screen/store.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class MenuAccount extends StatefulWidget {
  const MenuAccount({
    Key key,
  }) : super(key: key);

  @override
  _MenuAccountState createState() => _MenuAccountState();
}

class _MenuAccountState extends State<MenuAccount> {

  static SharedPreferences prefs;
  static var body;

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

  // ignore: missing_return
  Future<String> getStoreDetail(String uid) async {
    var url = Uri.parse('${ConfigIp.domain}/stores/ownerfindstore/$uid');
    var response = await http.get(url);
    body = convert.jsonDecode(response.body);
    // await prefs.setString('ImageDetail', response.body);
    if (response.statusCode == 200) {
      print(body);
      print(body['store_id']);
      String stid = '${body['store_id']}';
      print(stid);
      return stid;
    } else {
      print(response.body);
    }
  }

  Future<String> getStore() async {
    String data = await getStoreDetail('${profile['user_id']}');
    return data;
  }

  onGoBack(dynamic value) {
    setState(() {});
  }
  

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        child: Column(
          children: <Widget>[
           _manageStore(),
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

  FutureBuilder<String> _manageStore() {
    return FutureBuilder<String>(
      future: getStore(),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        List<Widget> children;
        if (snapshot.hasData) {
          print(snapshot);
          children = <Widget>[
            ListTile(
             title: Text('Store'),
             tileColor: Colors.red[400],
             leading: Icon(Icons.add_business_rounded),
             onTap: () => {
               print('gotostore${profile['user_id']}'),
               Navigator.pushNamed(context, Store.routeName,arguments: OpenStore(1))},
            //  Navigator.pushNamed(context, CreateStore.rountName),
           ),
          ];
        } else {
          // print('manage');
          // print(snapshot);

          children = <Widget>[
            ListTile(
             title: Text('Create Store'),
             tileColor: Colors.red[400],
             leading: Icon(Icons.add_business_rounded),
             onTap: () => {
               print('${profile['user_id']}'),
               normalDialog(context,'${profile['user_id']}')},
            //  Navigator.pushNamed(context, CreateStore.rountName),
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
