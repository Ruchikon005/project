import 'dart:io';
import 'package:flutter/material.dart';
import 'package:khnomapp/config_ip.dart';
import 'package:khnomapp/screens/store_screen/pages/my_productnew.dart';
import 'package:khnomapp/utility/my_style.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class AddProduct extends StatefulWidget {
  static var routeName = '/add_product';

  AddProduct({Key key}) : super(key: key);

  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  static SharedPreferences prefs;
  static var body;
  final ImagePicker _picker = ImagePicker();
  File file;
  TextEditingController _productname = TextEditingController();
  TextEditingController _productdetail = TextEditingController();
  TextEditingController _productprice = TextEditingController();
  TextEditingController _category = TextEditingController();
  TextEditingController _quantity = TextEditingController();

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

  List<String> options = <String>[
    'ขนมขบเคี้ยว',
    'อาหารเพื่อสุขภาพ',
    'เบเกอรี่',
    'เครื่องดื่ม',
    'ผลิตภัทณ์ OTOP',
    'Candy',
  ];
  String dropdownValue;

  _imgFromCamera() async {
    XFile image = await _picker.pickImage(
      source: ImageSource.camera,
      maxWidth: 800.0,
      maxHeight: 800.0,
    );

    setState(() {
      file = File(image.path);
    });
  }

  _imgFromGallery() async {
    XFile image = await _picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 800.0,
      maxHeight: 800.0,
    );

    setState(() {
      file = File(image.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    final weightbar = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Add Product'),
      ),
      body: Stack(children: [
        SingleChildScrollView(
          child: Column(children: [
            inputImage(),
            SizedBox(height: 8),
            inputNameProduct(),
            SizedBox(height: 8),
            inputDetail(),
            SizedBox(height: 8),
            Column(children: [
              inputPrice(),
              inputQuantity(),
              selectCategory(),
            ]),
          ]),
        ),
        Container(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: 70,
            width: double.infinity,
            // color: Colors.white,
            decoration: BoxDecoration(color: Colors.white),
            child: Container(
                padding: EdgeInsets.all(10),
                child: InkWell(
                  onTap: () {
                    addproduct();
                    Navigator.pop(context);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 50.0,
                    width: weightbar * 0.4,
                    decoration: BoxDecoration(
                        color: MyStyle().colorCustom,
                        borderRadius: BorderRadius.circular(5)),
                    child: Text('Start Selling',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold)),
                  ),
                )),
          ),
        ),
      ]),
    );
  }

  Container inputImage() {
    return Container(
      height: 150,
      color: Colors.white,
      width: double.infinity,
      alignment: Alignment.center,
      child: InkWell(
        child: Container(
          alignment: Alignment.center,
          height: 120,
          width: 120,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: file == null ? AssetImage('') : FileImage(file)),
            border: Border.all(color: MyStyle().colorCustom, width: 1.5),
          ),
          child: file == null ? Text('+ เพิ่มรูปอาหาร') : Text(''),
        ),
        onTap: () => _showPicker(context),
      ),
    );
  }

  Container inputNameProduct() {
    return Container(
      padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
      width: double.infinity,
      color: Colors.white,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          'ชื่ออาหาร',
          style: TextStyle(fontSize: 15),
        ),
        TextFormField(
          controller: _productname,
          decoration: InputDecoration(
            hintStyle: TextStyle(fontSize: 15),
            hintText: 'เพิ่มชื่ออาหาร',
            border: InputBorder.none,
            contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
          ),
        ),
      ]),
    );
  }

  // ignore: missing_return
  Future<String> getStoreDetail(String uid) async {
    var url = Uri.parse('${ConfigIp.domain}/stores/ownerfindstore/$uid');
    var response = await http.get(url);
    body = convert.jsonDecode(response.body);
    // await prefs.setString('ImageDetail', response.body);
    if (response.statusCode == 200) {
      print(body);
      // print(body['store_id']);
      String stid = '${body['store_id']}';
      // print(stid);
      return stid;
    } else {
      print(response.body);
    }
  }

  Future<String> getStore() async {
    String data = await getStoreDetail('${profile['user_id']}');
    // print(data);
    return data;
  }

  Container inputDetail() {
    return Container(
      padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
      width: double.infinity,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'รายละเอียดอาหาร',
            style: TextStyle(fontSize: 15),
          ),
          TextFormField(
            controller: _productdetail,
            decoration: InputDecoration(
              hintStyle: TextStyle(fontSize: 15),
              hintText: 'เพิ่มรายละเอียดอาหาร',
              border: InputBorder.none,
              contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
              // labelText: 'ชื่อสินค้า',
              // labelStyle: TextStyle(color: Colors.black, fontSize: 15),
            ),
          ),
        ],
      ),
    );
  }

  Widget inputPrice() {
    return Container(
      padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
      // color: Colors.white,
      height: 50,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(
            color: Colors.grey.shade300,
            width: 0.5,
          ),
          bottom: BorderSide(
            color: Colors.grey.shade300,
            width: 0.5,
          ),
        ),
      ),
      child: Row(
        children: <Widget>[
          Icon(Icons.attach_money_rounded, size: 25),
          SizedBox(width: 5),
          Text('ราคา', style: TextStyle(fontSize: 15)),
          Expanded(
            child: TextFormField(
              controller: _productprice,
              style: TextStyle(fontSize: 15),
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintStyle: TextStyle(fontSize: 15),
                hintText: 'ตั้งค่า',
                border: InputBorder.none,
              ),
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }

  Widget inputQuantity() {
    return Container(
      padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
      // color: Colors.white,
      height: 50,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(
            color: Colors.grey.shade300,
            width: 0.5,
          ),
          bottom: BorderSide(
            color: Colors.grey.shade300,
            width: 0.5,
          ),
        ),
      ),
      child: Row(
        children: <Widget>[
          Icon(Icons.dynamic_feed, size: 25),
          SizedBox(width: 5),
          Text('จำนวน', style: TextStyle(fontSize: 15)),
          Expanded(
            child: TextFormField(
              controller: _quantity,
              style: TextStyle(fontSize: 15),
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintStyle: TextStyle(fontSize: 15),
                hintText: 'ตั้งค่า',
                border: InputBorder.none,
              ),
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }

  Widget selectCategory() {
    return Container(
      padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
      // color: Colors.white,
      height: 50,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(
            color: Colors.grey.shade300,
            width: 0.5,
          ),
          bottom: BorderSide(
            color: Colors.grey.shade300,
            width: 0.5,
          ),
        ),
      ),
      child: Row(
        children: <Widget>[
          Icon(Icons.format_list_bulleted_rounded, size: 25),
          SizedBox(width: 5),
          Text('หมวดหมู่', style: TextStyle(fontSize: 15)),
          Spacer(),
          Container(
            // alignment: Alignment.centerRight,
            child: DropdownButton<String>(
              value: dropdownValue,
              onChanged: (String newValue) {
                setState(() {
                  dropdownValue = newValue;
                  _category.text = dropdownValue;
                  print(_category.text);
                });
              },
              underline: Container(),
              hint: Container(
                  alignment: Alignment.centerRight,
                  width: 180,
                  child: Text("เลือกหมวดหมู่",
                      style: TextStyle(fontSize: 15),
                      textAlign: TextAlign.end)),
              selectedItemBuilder: (BuildContext context) {
                return options.map<Widget>((String item) {
                  return Container(
                      alignment: Alignment.centerRight,
                      width: 180,
                      child: Text(item, style: TextStyle(fontSize: 15)));
                }).toList();
              },
              items: options.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value, style: TextStyle(fontSize: 15)),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  Future addproduct() async {
    
    
    print('object');
    print(await getStore());
    print('object');

    var request = http.MultipartRequest(
        'POST', Uri.parse('${ConfigIp.domain}/products/addproduct'));
    request.fields.addAll({
      "product_name": _productname.text,
      "product_detail": _productdetail.text,
      "price": _productprice.text,
      "quantity": _quantity.text,
      "category": _category.text,
      "stid": await getStore(),
    });

    request.files
        .add(await http.MultipartFile.fromPath('uploadproductfile', file.path));
    print(getStore().toString());

    http.StreamedResponse response = await request.send();
    print('add2');
    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }

//   Future <ImageSource> normalDialog(BuildContext context, String uid) async {
//     // TextEditingController _storename = TextEditingController();
//     // final ButtonStyle style = ElevatedButton.styleFrom(
//     //     textStyle: const TextStyle(fontSize: 18), fixedSize: Size(100, 25));
//     print("status");
//     print(uid);
//     String _uid = uid;
//     showDialog(
//         context: context,
//         builder: (context) => Center(
//               child: SimpleDialog(
//                 shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(20)),
//                 children: [
//                   Container(
//                     padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
//                     height: 250,
//                     child: Column(
//                       children: [
//                         ListTile(
//                           title: Text('กล้องถ่ายรูป'),
//                           onTap: chooseImage(ImageSource.camera),
//                         ),
//                         ListTile(
//                           title: Text('กล้องถ่ายรูป'),
//                           onTap: chooseImage(ImageSource.camera),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ));
//   }

  // Future <ImageSource> chooseImage(ImageSource source) async {
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
}
