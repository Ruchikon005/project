// import 'package:dio/dio.dart';
// import 'dart:convert';
// import 'package:fluttertoast/fluttertoast.dart';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:khnomapp/screens/signin_screen/signin.dart';
import 'package:khnomapp/utility/my_style.dart';
import 'package:http/http.dart' as http;
// import 'DashBoard.dart';

class SignUp extends StatefulWidget {
  static String routeName = "/signup_screen";

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  // String _role = 'customer';
  TextEditingController _username = TextEditingController();
  TextEditingController _tel = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController passwordAgain = TextEditingController();

  final success = SnackBar(content: Text('Register succeded!'));
  final error = SnackBar(content: Text('Already have this account'));

  final _formKey = GlobalKey<FormState>();

  Future register() async {
    // var url = "http://172.19.175.153/add/register.php";
    var url = "http://172.19.238.66:3001/users/register";
    http.Response response = await http.post(Uri.parse(url), body: {
      "username" : _username.text,
      "tel" : _tel.text,
      "email" : _email.text,
      "password" : _password.text,
      "role" : 'customer'
    });
    var data = jsonDecode(response.body);
    print(data);
    if (data.toString() == "{message: Registration successful}") {
      ScaffoldMessenger.of(context).showSnackBar(success);
      Navigator.pushNamedAndRemoveUntil(context, SignIn.routeName, (Route<dynamic> route) => false);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            myLogo(),
            MyStyle().mySizeBox(),
            textRegister(),
            MyStyle().mySizeBox(),
            usernameForm(),
            MyStyle().mySizeBox(),
            telForm(),
            MyStyle().mySizeBox(),
            emailForm(),
            MyStyle().mySizeBox(),
            passwordForm(),
            MyStyle().mySizeBox(),
            passwordAgainForm(),
            MyStyle().mySizeBox(),
            registerButton(),
          ],
        ),
      ),
    );
  }

  //Register
  Row textRegister() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        MyStyle().showTextRegister('Register'),
      ],
    );
  }

  //Username Texfield
  Widget usernameForm() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 250.0,
            child: TextFormField(
              controller: _username,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter name';
                }
                return null;
              },
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.account_box,
                  color: MyStyle().darkColor,
                ),
                labelStyle: TextStyle(color: MyStyle().darkColor),
                labelText: 'User Name',
                hintText: 'User Name',
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

  Widget telForm() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 250.0,
            child: TextFormField(
              controller: _tel,
              validator: (value) {
                if (value.isEmpty ||
                    value != RegExp(r'[0][0-9]') ||
                    value.length != 10) {
                  return 'Please enter tel';
                }
                return null;
              },
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.phone_rounded,
                  color: MyStyle().darkColor,
                ),
                labelStyle: TextStyle(color: MyStyle().darkColor),
                labelText: 'Tel',
                hintText: 'Tel',
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

  //PasswordAgain Texfield
  Widget passwordAgainForm() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 250.0,
            child: TextFormField(
              controller: passwordAgain,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter password again';
                } else if (value != _password.text) {
                  return 'Passwords do not match';
                }
                return null;
              },
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.lock_outline,
                  color: MyStyle().darkColor,
                ),
                labelStyle: TextStyle(color: MyStyle().darkColor),
                labelText: 'Enter password again',
                hintText: 'password',
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
            ),
          ),
        ],
      );

  Widget registerButton() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: Container(
              child: ElevatedButton(
                onPressed: () {
                  // _role;
                  print('name : ${_username.text}');
                  // signup(name, email, password);
                  // registerThreand();
                  // doLogin();
                  register();
                },
                child: Text('Verify'),
              ),
            ),
          ),
        ],
      );

  Row showAppname() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          children: [
            MyStyle().highLightTitle('KHNOM'),
          ],
        ),
      ],
    );
  }

  //ถ้าใช้ widget อยู่ใน listview จะมีค่าความกว้างเท่ากับขนาดของ listviwe เสมอ
  Widget myLogo() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MyStyle().showLogo(),
        ],
      );
  //thread
  // Future registerThreand() async {
  //   String url =
  //       'http://localhost:3001/api/register';

  //   try {
  //     return await Dio().post(url);
  //     options:
  //     Options(
  //       contentType: Headers.formUrlEncodedContentType,
  //     );
  //     // print('res = $response');
  //   } catch (e) {}
  // }
}

// signup(name, email, password) async {
//   var url = Uri.http("192.168.31.76", "/api/register");
//   http.Response response = await http.post(
//     url,
//     headers: <String, String>{
//       'Content-Type': 'application/json; charset=UTF-8',
//     },
//     body: jsonEncode(<String, String>{
//       'Username': name,
//       'Email': email,
//       'Password': password,
//     }),
//   );

//   if (response.statusCode == 201) {
//   } else {
//     throw Exception('Failed to create album.');
//   }
// }
