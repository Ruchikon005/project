import 'package:flutter/material.dart';
import 'package:khnomapp/action/create_store.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert' as convert;

class CreateStore extends StatefulWidget {
  static var rountName = '/create_store';

  CreateStore({Key key}) : super(key: key);

  @override
  _CreateStoreState createState() => _CreateStoreState();
}

class _CreateStoreState extends State<CreateStore> {
  TextEditingController _storename = TextEditingController();

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Card(
          child: Container(
            child: Column(
              children: [
                Text(
                  'Create Store',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 50,
                ),
                TextFormField(
                  controller: _storename,
                  decoration: InputDecoration(hintText: 'Store Name'),
                ),
                SizedBox(
                  height: 50,
                ),
                ElevatedButton(
                    onPressed: () =>
                        {print(_storename.text),create('${profile['user_id']}', _storename.text)},
                    child: Text('Create')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
