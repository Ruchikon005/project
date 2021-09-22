import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:khnomapp/action/create_sotre.dart';
import 'package:khnomapp/screens/account_screen/Account.dart';
import 'package:khnomapp/screens/store_screen/store.dart';
import 'package:khnomapp/screens/store_screen/widget/nav_store.dart';



Future<Null> normalDialog(BuildContext context, String uid) async {

  
    TextEditingController _storename = TextEditingController();
    final ButtonStyle style = ElevatedButton.styleFrom(
        textStyle: const TextStyle(fontSize: 18), fixedSize: Size(100, 25));
    print("status");
    print(uid);
    String _uid = uid;
    showDialog(
        context: context,
        builder: (context) => Center(
              child: SimpleDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                    height: 250,
                    child: Column(
                      children: [
                        ListTile(
                          title: Text('กล้องถ่ายรูป'),
                          // onTap: chooseImage(ImageSource.camera),
                        ),
                        ListTile(),
                      ],
                    ),
                  ),
                ],
              ),
            ));
  }

  // Future<Null> chooseImage(ImageSource source) async {
  //   try {
  //     final XFile image = await _picker.pickImage(
  //       source: source,
  //       maxWidth: 800.0,
  //       maxHeight: 800.0,
  //     );
  //     setState(() {
  //       file = File(image.path);
  //     });
  //   } catch (e) {}
  // }