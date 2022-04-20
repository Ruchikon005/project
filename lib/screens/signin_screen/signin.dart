import 'dart:async';
import 'dart:convert';
import 'dart:convert' as convert;
import 'package:flutter/material.dart';
import 'package:khnomapp/config_ip.dart';
import 'package:khnomapp/model/user_argument_model.dart';
import 'package:khnomapp/nav/nav.dart';
import 'package:khnomapp/screens/signup_screen/signup.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:khnomapp/utility/my_style.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class SignIn extends StatefulWidget {
  static String routeName = "/signin_screen";

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  List<UserArgumentModel> userModel = <UserArgumentModel>[];
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  static SharedPreferences prefs;

  _initPref() async {
    prefs = await SharedPreferences.getInstance();
    if (prefs.getString('token') != null) {
      Navigator.pushReplacementNamed(context, Nav.routeName);
    }
  }

  @override
  void initState() {
    _initPref();
    super.initState();
  }

  final success = SnackBar(content: Text('Login succeded!'));
  final error = SnackBar(content: Text('Wrong email or password!'));
  final _formKey = GlobalKey<FormState>();

  Future login() async {
    print("OK");
    var url = "${ConfigIp.domain}/users/authenticate";
    
    http.Response response = await http.post(Uri.parse(url), body: {
      "email": _email.text,
      "password": _password.text,
    });
    var jsonResponse;
    print(response);
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      print("Response status: ${response.statusCode}");
      print("Response status: ${response.body}");

      if (jsonResponse != null) {
        prefs.setString("token", jsonResponse['token']);
        print(prefs.getString('token'));
        await _getProfile();
        return true;
      }
    } else {
      setState(() {});
      print("Response status: ${response.body}");
      return false;
    }
  }

  Future<void> _getProfile() async {
    //get token from pref
    var tokenString = prefs.getString('token');
    var url = Uri.parse('${ConfigIp.domain}/users/current');
    http.Response response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $tokenString',
      },
    );
    var body = convert.jsonDecode(response.body);
    if (response.statusCode == 200) {
      //save profile to pref
      await prefs.setString('profile', response.body);
    } else {
      print(body['message']);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign In'),
      ),
      body: Center(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              MyStyle().showLogo(),
              // MyStyle().showTitle('KHNOM'),
              MyStyle().highLightTitle('KHNOM'),
              MyStyle().mySizeBox(),
              emailForm(),
              MyStyle().mySizeBox(),
              passwordForm(),
              MyStyle().mySizeBox(),
              loginButton(),
              MyStyle().mySizeBox(),
              _divider(),
              MyStyle().mySizeBox(),
              registerButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _divider() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                thickness: 1,
              ),
            ),
          ),
          Text('or'),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                thickness: 1,
              ),
            ),
          ),
          SizedBox(
            width: 20,
          ),
        ],
      ),
    );
  }

  Widget registerButton(BuildContext context) {
    return Container(
      child: ElevatedButton(
          onPressed: () => Navigator.pushNamed(context, SignUp.routeName),
          child: Text("Create Account")),
    );
  }

  Widget loginButton() => Container(
        child: ElevatedButton(
          onPressed: () async {
            print(_email.text);
            print(_password.text);
            bool check = await login();
            _password.text.isEmpty || _email.text.isEmpty
                ? await showDialog(
                    context: context,
                    builder: (BuildContext builderContext) {
                      Timer(Duration(seconds: 2), () {
                        Navigator.of(context).pop();
                      });
                      return AlertDialog(
                        title: Container(
                          alignment: Alignment.center,
                          height: 80,
                          child: Text(
                            'Please enter your\nEmail and Password',
                            textAlign: TextAlign.center,
                          ),
                        ),
                        backgroundColor: Colors.white,
                      );
                    })
                // :setState(() {});
                : await showDialog(
                    context: context,
                    builder: (BuildContext builderContext) {
                      Timer(Duration(seconds: 2), () {
                        Navigator.of(context).pop();
                      });
                      return AlertDialog(
                          title: Container(
                            height: 100,
                            alignment: Alignment.center,
                            child: check == true
                                ? Text(
                                    'Login Sucsess',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 30),
                                  )
                                : Text(
                                    'Wrong\nEmail or Password',
                                    style: TextStyle(color: Colors.white),
                                    textAlign: TextAlign.center,
                                  ),
                          ),
                          backgroundColor:
                              check == true ? Colors.green : Colors.red);
                    });
            setState(() {
              if (prefs.getString('token') != null) {
                Navigator.pushReplacementNamed(context, Nav.routeName);
              }
              // check == true ? Navigator.pushReplacementNamed(context, Nav.routeName,) : {};
            });
          },
          child: Text('LOGIN'),
        ),
      );

  //Email Texfield
  Widget emailForm() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 250.0,
            child: TextFormField(
              controller: _email,
              validator: (value) {
                if (value.isEmpty ||
                    !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(value)) {
                  return 'Enter a valid email!';
                }
                return null;
              },
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.email_rounded,
                  color: MyStyle().darkColor,
                ),
                labelStyle: TextStyle(color: MyStyle().darkColor),
                labelText: 'Email',
                hintText: 'Email',
                enabledBorder: OutlineInputBorder(
                  borderRadius: MyStyle().borderRadius,
                  borderSide: BorderSide(color: MyStyle().darkColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: MyStyle().borderRadius,
                  borderSide: BorderSide(color: MyStyle().primryColor),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: MyStyle().borderRadius,
                  borderSide: BorderSide(color: MyStyle().errorBorder),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: MyStyle().borderRadius,
                  borderSide: BorderSide(color: MyStyle().errorBorder),
                ),
              ),
            ),
          ),
        ],
      );

  //Password Texfield
  Widget passwordForm() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              width: 250.0,
              child: TextFormField(
                controller: _password,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter password';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.lock_outline,
                    color: MyStyle().darkColor,
                  ),
                  labelStyle: TextStyle(color: MyStyle().darkColor),
                  labelText: 'Password',
                  hintText: 'Password',
                  enabledBorder: OutlineInputBorder(
                    borderRadius: MyStyle().borderRadius,
                    borderSide: BorderSide(color: MyStyle().darkColor),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: MyStyle().borderRadius,
                    borderSide: BorderSide(color: MyStyle().primryColor),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: MyStyle().borderRadius,
                    borderSide: BorderSide(color: MyStyle().errorBorder),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: MyStyle().borderRadius,
                    borderSide: BorderSide(color: MyStyle().errorBorder),
                  ),
                ),
                autofocus: false,
                obscureText: true,
              )),
        ],
      );
}
